"""Record final-VM CPU profiles without inferring physical phone FPS."""
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1103'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    baseline_path = OUT / 'loop-baseline-profiles.json'
    baseline = json.loads(baseline_path.read_text('utf8'))
    vm = sha(ROOT / 'build-windows/nuclearthronemobile.win')
    rows = []
    for prior in baseline:
        case = prior['scenario']
        folder = OUT / 'tests' / case.replace(',', '-')
        receipt_path = folder / 'receipt.json'
        receipt = json.loads(receipt_path.read_text('utf8'))
        assert receipt['status'] == 'PASS' and receipt['checks'] >= 5
        assert receipt['scenario'] == case and receipt['vm_sha256'] == vm
        log_path = folder / 'runner.log'
        matches = re.findall(r'HARDMODE FRAME106 (\{[^\r\n]+\})', log_path.read_text('utf8', errors='replace'))
        assert len(matches) == 1
        current = json.loads(matches[0])
        old = prior['profile']
        scene_keys = ('area', 'sub', 'rate', 'walls', 'actors', 'samples')
        same_scene = all(current[key] == old[key] for key in scene_keys)
        same_scene = same_scene and receipt['floors'] == prior['receipt']['floors']
        assert current['median_us'] > 0 and current['p95_us'] >= current['median_us']
        rows.append(dict(scenario=case, final_vm_sha256=vm, receipt_sha256=sha(receipt_path),
            runner_log_sha256=sha(log_path), previous_candidate_vm_sha256=prior['receipt']['vm_sha256'],
            same_reported_scene_and_sample_size=same_scene, previous=old, current=current,
            median_ratio=current['median_us']/old['median_us'] if same_scene else None,
            p95_ratio=current['p95_us']/old['p95_us'] if same_scene else None))
    report = dict(status='PASS', final_vm_sha256=vm, baseline_sha256=sha(baseline_path),
        baseline_kind='Recorded earlier development candidate, not the published 1.1.2 release',
        measurements=rows, physical_phone_tested=False, performance_fps_claim=False,
        limits=['Frame CPU timings on this Windows host; no universal high-loop or phone FPS claim.',
                'Timing ratios are reported only when scenario, scene counts and sample sizes match.',
                'Short seeded profiles do not establish sustained thermal or long-run performance.'])
    (OUT / 'loop-final-profiles.json').write_text(json.dumps(report, indent=2)+'\n', 'utf8')
    print('Final host CPU profiles recorded:', len(rows))


if __name__ == '__main__':
    main()
