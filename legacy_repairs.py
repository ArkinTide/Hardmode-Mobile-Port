"""Small, explicit repairs for missing data in the supplied b24 source."""
from collections import deque


def prison_door_mask(layout):
    """Recover the omitted psd table using the authored map's door regions.

    Other Venuz maps include a parallel letter grid. b24's secret prison
    references psd without declaring it. Keep its geometry and give each
    connected chamber a group, discovered from the original player start.
    """
    rows = layout.splitlines()
    doors = {(x, y) for y, row in enumerate(rows) for x, c in enumerate(row) if c in '=+?@'}
    tiles = {(x, y) for y, row in enumerate(rows) for x, c in enumerate(row) if c not in 'Xx=+?@'}
    start = next((x, y) for y, row in enumerate(rows) for x, c in enumerate(row) if c == '2')
    components, membership = [], {}
    while tiles:
        first = min(tiles, key=lambda p: (p[1], p[0]))
        component, pending = set(), [first]
        while pending:
            point = pending.pop()
            if point not in tiles:
                continue
            tiles.remove(point)
            component.add(point)
            x, y = point
            pending.extend([(x-1,y),(x+1,y),(x,y-1),(x,y+1)])
        for point in component:
            membership[point] = len(components)
        components.append(component)
    door_regions = []
    unseen = set(doors)
    while unseen:
        region, pending = set(), [min(unseen)]
        while pending:
            point = pending.pop()
            if point not in unseen:
                continue
            unseen.remove(point)
            region.add(point)
            x,y = point
            pending.extend([(x-1,y),(x+1,y),(x,y-1),(x,y+1)])
        sides = set()
        for x,y in region:
            sides.update(membership[p] for p in [(x-1,y),(x+1,y),(x,y-1),(x,y+1)] if p in membership)
        door_regions.append((region,sides))
    groups = {membership[start]: '_'}
    pending = deque([membership[start]])
    door_groups = {}
    while pending:
        current = pending.popleft()
        for region,sides in door_regions:
            if current not in sides:
                continue
            for side in sorted(sides):
                if side not in groups:
                    groups[side] = chr(ord('a')+len(groups)-1)
                    pending.append(side)
            candidates = [groups[s] for s in sides if groups[s] != '_']
            if candidates:
                for point in region:
                    door_groups[point] = max(candidates).upper()
    assert len(door_groups)==len(doors), 'Secret prison has an unreachable unlabelled door'
    assert all(membership[p] in groups for p in membership), 'Unreachable authored prison chamber'
    return '\n'.join(''.join(door_groups.get((x,y),'X' if c in 'Xx' else groups[membership[x,y]])
                            if (x,y) not in doors else door_groups[x,y]
                            for x,c in enumerate(row)) for y,row in enumerate(rows))+'\n'
