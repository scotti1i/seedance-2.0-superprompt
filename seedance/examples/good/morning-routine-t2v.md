# Good Example — T2V Morning Routine (10s)

## Engineered prompt

```
Vertical video 9:16. Overall audio atmosphere: warm lo-fi piano with gentle female humming, soft morning ambience with distant birdsong, no voiceover.

[0-3s] Extreme close-up on a cream linen pillow, soft golden sunlight from camera-right, slight handheld micro-shake. A young woman's hand slowly drifts into frame and brushes a strand of hair off her cheek. Beige walls, cream linen, warm wood. Sound: faint fabric rustle, distant birdsong.

[3-7s] Cut to medium shot, low angle from the bedside. She lifts her head off the pillow, eyes barely open, exhales slowly, then pushes herself up with one elbow. A single ceramic mug on the nightstand catches a rim of light. Camera holds still. Sound: bedding swoosh, mug clinks softly.

[7-10s] Cut to close-up on her face from the side. She tilts her head toward the window, eyes squint at the brightness, the corner of her mouth lifts into a small private smile. Warm sunlight crosses her cheekbone. Sound: lo-fi piano swells gently.

Shot on Sony A7S3, natural skin tone, slight film grain, documentary realism. Face stable, no distortion, body proportions natural, motion fluid, no flicker, no plastic skin, no oversaturated colors, no on-screen text.
```

## Why this is good (rule-by-rule)

| Rule | Status | Notes |
|---|---|---|
| R-T01 (≤4 segments) | 🟢 | 3 segments |
| R-T02 (contiguous segments) | 🟢 | 0-3, 3-7, 7-10 |
| R-T03 (within duration) | 🟢 | Last segment ends at 10s |
| R-S01 (color + material + light) | 🟢 | "beige walls, cream linen, warm wood" + "golden sunlight from camera-right" |
| R-C01 (one camera move / segment) | 🟢 | handheld micro-shake → locked → locked, single move each |
| R-J01 (no junk tokens) | 🟢 | No "highly detailed", "8k", "cinematic" alone, "masterpiece" |
| R-J03 (named camera) | 🟢 | Sony A7S3 |
| R-X01 (text ≤4 words) | 🟢 | No on-screen text |
| R-A01 (Overall audio atmosphere) | 🟢 | Line 2 declared |
| R-N01 (3-5 negatives) | 🟢 | 5 specific negatives at the end |
| R-B01 (length limit) | 🟢 | ~700 chars |
| R-B03 (stable duration) | 🟢 | 10s |

## Engineering choices

- **Sony A7S3** instead of "cinematic" — invokes documentary realism
- **Natural sound design** instead of music dominance — "lo-fi piano +
  birdsong + bedding swoosh" creates depth without overwhelming
- **Subject described once at top of segment 1** (`A young woman's hand`),
  then continues with "she" in subsequent segments
- **3 distinct camera setups**: extreme close-up of pillow (object-focused)
  → medium low angle (body-focused) → side close-up face (emotion-focused)
- **Lighting consistency** with explicit time-of-day cues ("golden", "rim
  light", "warm sunlight") so the model doesn't drift to fluorescent

## What this would look like on different clients

- **jimeng.jianying.com**: paste directly into the prompt field, set
  duration=10, ratio=9:16, model=seedance2.0fast, generate
- **dreamina.capcut.com** (international): same paste
- **Volcano Engine API**: pass as the `prompt` field to the doubao-
  seedance-1-0-pro endpoint
- **Third-party wrappers**: works without modification

## See also

- `../../modes/t2v.md`
- `../../templates/morning-routine.md`
