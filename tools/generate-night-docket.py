#!/usr/bin/env python3
"""Original noir felt-piano loop for Czerwona Teczka. No third-party samples."""

from __future__ import annotations

import math
import struct
import wave
from pathlib import Path

SR = 44100
BPM = 48
BEAT = 60.0 / BPM
BARS = 8
BEATS_PER_BAR = 4
DURATION = BARS * BEATS_PER_BAR * BEAT
PI = math.pi


def midi_hz(note: float) -> float:
    return 440.0 * (2.0 ** ((note - 69.0) / 12.0))


def hash_noise(index: int) -> float:
    x = (index * 1103515245 + 12345) & 0x7FFFFFFF
    return (x / 0x7FFFFFFF) * 2.0 - 1.0


def piano(freq: float, t: float, velocity: float, sample_index: int) -> float:
    if t < 0:
        return 0.0
    brightness = min(1.0, freq / 720.0)
    attack = min(1.0, t / 0.010)
    inharmonic = 0.00028
    sample = 0.0
    amps = (1.00, 0.34, 0.16, 0.08, 0.035, 0.016, 0.007)
    for harmonic, amp in enumerate(amps, start=1):
        partial = freq * harmonic * math.sqrt(1.0 + inharmonic * harmonic * harmonic)
        decay = math.exp(-t * (1.35 + harmonic * (1.55 + 2.4 * brightness)))
        detune = 1.0 + 0.0009 * math.sin(harmonic + freq)
        sample += amp * math.sin(2.0 * PI * partial * detune * t) * decay
    hammer = math.exp(-t * 62.0) * math.sin(2.0 * PI * freq * 7.4 * t) * 0.10
    thud = math.exp(-t * 14.0) * math.sin(2.0 * PI * 48.0 * t) * 0.07
    felt = hash_noise(sample_index) * math.exp(-t * 85.0) * 0.045
    return velocity * attack * (sample * (1.0 - 0.35 * brightness) + hammer + thud + felt)


# (start_beats, midi, length_beats, velocity)
NOTES: list[tuple[float, float, float, float]] = [
    # left hand — slow d-minor walk
    (0, 50, 3.8, 0.36), (1.5, 57, 2.4, 0.22), (2.5, 62, 1.6, 0.18),
    (4, 45, 3.8, 0.34), (5.5, 52, 2.4, 0.20), (6.5, 60, 1.6, 0.18),
    (8, 53, 3.8, 0.32), (9.5, 60, 2.4, 0.20), (10.5, 65, 1.6, 0.16),
    (12, 46, 3.8, 0.34), (13.5, 53, 2.2, 0.20), (14.5, 61, 1.6, 0.20),
    (16, 50, 3.8, 0.36), (17.5, 57, 2.4, 0.22), (18.5, 62, 1.6, 0.18),
    (20, 43, 3.8, 0.34), (21.5, 50, 2.4, 0.22), (22.5, 55, 1.6, 0.18),
    (24, 45, 3.8, 0.32), (25.5, 52, 2.4, 0.20), (26.5, 57, 1.6, 0.16),
    (28, 50, 4.0, 0.38), (29.5, 57, 2.6, 0.22), (30.5, 62, 2.2, 0.20),
    # melody — sparse, late-night
    (0.0, 74, 2.5, 0.40), (3.0, 69, 1.0, 0.28),
    (4.0, 70, 2.5, 0.36), (7.0, 74, 1.0, 0.30),
    (8.0, 72, 3.2, 0.34), (11.5, 69, 0.8, 0.26),
    (12.0, 76, 2.2, 0.38), (14.5, 73, 1.6, 0.30),
    (16.0, 77, 2.4, 0.36), (19.0, 74, 1.2, 0.30),
    (20.0, 70, 1.2, 0.28), (21.5, 74, 1.2, 0.32), (23.0, 69, 1.0, 0.26),
    (24.0, 76, 4.0, 0.30),
    (28.0, 74, 4.0, 0.36),
]


def lowpass(samples: list[float], cutoff: float) -> list[float]:
    rc = 1.0 / (2.0 * PI * cutoff)
    dt = 1.0 / SR
    alpha = dt / (rc + dt)
    y = 0.0
    out = [0.0] * len(samples)
    for i, x in enumerate(samples):
        y += alpha * (x - y)
        out[i] = y
    return out


def render() -> tuple[list[float], list[float]]:
    n = int(DURATION * SR)
    fade = int(0.18 * SR)
    buf = [0.0] * (n + fade + int(2.2 * SR))
    for start_beats, midi, length_beats, velocity in NOTES:
        start = int(start_beats * BEAT * SR)
        length = int((length_beats * BEAT + 1.6) * SR)
        freq = midi_hz(midi)
        for i in range(length):
            idx = start + i
            if idx >= len(buf):
                break
            buf[idx] += piano(freq, i / SR, velocity, idx)

    wet = buf[:]
    delays = ((int(0.19 * SR), 0.15), (int(0.37 * SR), 0.08), (int(0.61 * SR), 0.04))
    for i in range(len(buf)):
        echo = 0.0
        for delay, gain in delays:
            if i >= delay:
                echo += gain * buf[i - delay]
        wet[i] = buf[i] + echo
    wet = lowpass(wet, 2400.0)

    left = wet[:n]
    for i in range(fade):
        t = i / fade
        left[i] = wet[i] * t + wet[n + i] * (1.0 - t)

    delay = int(0.013 * SR)
    right = [0.0] * n
    for i, sample in enumerate(left):
        delayed = left[i - delay] if i >= delay else sample
        right[i] = 0.82 * sample + 0.18 * delayed

    peak = max(1e-9, max(max(abs(s) for s in left), max(abs(s) for s in right)))
    scale = 0.70 / peak
    left = [max(-1.0, min(1.0, s * scale)) for s in left]
    right = [max(-1.0, min(1.0, s * scale)) for s in right]
    return left, right


def write_wav(path: Path, left: list[float], right: list[float]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "w") as handle:
        handle.setnchannels(2)
        handle.setsampwidth(2)
        handle.setframerate(SR)
        frames = bytearray()
        for l_sample, r_sample in zip(left, right):
            frames += struct.pack("<hh", int(l_sample * 32767), int(r_sample * 32767))
        handle.writeframes(frames)


if __name__ == "__main__":
    out = Path("/tmp/NightDocket.wav")
    left, right = render()
    write_wav(out, left, right)
    print(f"Wrote {out} ({DURATION:.1f}s stereo)")
