package com.arkintide.nuclearthronehardmode;

import java.util.concurrent.locks.LockSupport;

/** Upper-bound native simulation callbacks using monotonic time, not display refresh. */
final class HardmodeFramePacer {
    interface Clock {
        long now();
        void waitNanos(long nanos);
    }

    private final Clock clock;
    private long previous;
    private int rate;
    private boolean started;

    HardmodeFramePacer() {
        this(new Clock() {
            public long now() { return System.nanoTime(); }
            public void waitNanos(long nanos) { LockSupport.parkNanos(nanos); }
        });
    }

    HardmodeFramePacer(Clock clock) { this.clock = clock; }

    void awaitFrame(double requestedRate) {
        int nextRate = (int)Math.round(requestedRate);
        if (nextRate != 30 && nextRate != 60) {
            started = false;
            rate = 0;
            return;
        }
        long now = clock.now();
        if (!started || rate != nextRate) {
            started = true;
            rate = nextRate;
            previous = now;
            return;
        }
        long deadline = previous + (1_000_000_000L + rate - 1) / rate;
        // Spurious wakeups must not advance the simulation. Interrupted GL
        // shutdown returns promptly; regular Android pause/resume never banks
        // simulation debt or replays a burst of missed frames.
        while (now < deadline && !Thread.currentThread().isInterrupted()) {
            clock.waitNanos(deadline - now);
            now = clock.now();
        }
        previous = now;
    }
}
