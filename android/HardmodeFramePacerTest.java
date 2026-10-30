package com.arkintide.nuclearthronehardmode;

final class HardmodeFramePacerTest {
    static final class FakeClock implements HardmodeFramePacer.Clock {
        long time;
        int wakes;
        public long now() { return time; }
        public void waitNanos(long nanos) {
            // Exercise premature wakeups as well as exact deadlines.
            time += (++wakes % 2 == 1 && nanos > 2) ? nanos / 2 : nanos;
        }
    }
    static int checks;
    static void check(boolean value, String message) {
        if (!value) throw new AssertionError(message);
        checks++;
    }
    public static void main(String[] args) {
        for (int rate : new int[] {30, 60}) {
            FakeClock c = new FakeClock();
            HardmodeFramePacer p = new HardmodeFramePacer(c);
            p.awaitFrame(rate);
            long first = c.time;
            for (int i = 1; i <= rate * 10; i++) {
                // Simulate an early native callback; never select 120 FPS.
                c.time += 1_000_000;
                p.awaitFrame(rate);
            }
            check(c.time - first >= 10_000_000_000L, "simulation cannot exceed real time");
            check(c.time - first < 10_001_000_000L, "no accumulated extra frame delay");
            long previous = c.time;
            c.time += 5_000_000_000L;
            p.awaitFrame(rate);
            check(c.time == previous + 5_000_000_000L, "pause incurs no extra sleep");
            previous = c.time;
            p.awaitFrame(rate);
            check(c.time > previous, "resume cannot replay a catch-up burst");
            previous = c.time;
            p.awaitFrame(rate == 30 ? 60 : 30);
            check(c.time == previous, "setting change resets old deadline");
            p.awaitFrame(0);
            previous = c.time;
            p.awaitFrame(rate);
            check(c.time == previous, "native startup rate zero resets the limiter");
        }
        System.out.println("PASS Hardmode Android pacing " + checks);
    }
}
