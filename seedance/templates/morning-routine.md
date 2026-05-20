---
name: morning-routine
scenario: "Slow-cinematic morning routine vignette"
mode: t2v
duration_s: 10
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [lifestyle, vlog, slow-cinema]
variables:
  - name: "${subject}"
    desc: "Brief subject description"
    example: "a young east-asian woman in cream pajamas"
  - name: "${room_palette}"
    desc: "Room color palette + materials"
    example: "beige walls, cream linen, warm wood"
---

# Morning Routine (Slow Cinema)

## When to use

10s slow-cinematic vignette: waking up, breakfast prep, or quiet moments.
Soft / aspirational lifestyle content. Works for wellness, skincare,
mattress, coffee brands.

## Required assets

None — pure T2V.

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: warm lo-fi piano with gentle female humming, soft morning ambience with distant birdsong, no voiceover.

[0-3s] Extreme close-up on a cream linen pillow, soft golden sunlight from camera-right, slight handheld micro-shake. ${subject}'s hand slowly drifts into frame and brushes a strand of hair off her cheek. ${room_palette}. Sound: faint fabric rustle, distant birdsong.

[3-7s] Cut to medium shot, low angle from the bedside. She lifts her head off the pillow, eyes barely open, exhales slowly, then pushes herself up with one elbow. A single ceramic mug on the nightstand catches a rim of light. Camera holds still. Sound: bedding swoosh, mug clinks softly.

[7-10s] Cut to close-up on her face from the side. She tilts her head toward the window, eyes squint at the brightness, the corner of her mouth lifts into a small private smile. Warm sunlight crosses her cheekbone. Sound: lo-fi piano swells gently.

Shot on Sony A7S3, natural skin tone, slight film grain, documentary realism. Face stable, no distortion, body proportions natural, motion fluid, no flicker, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${subject}` | Detailed person description (1-2 attributes) | "a young east-asian woman in cream pajamas" |
| `${room_palette}` | Room color + 2 materials | "beige walls, cream linen, warm wood" |

## Engineering notes

- **T2V** because no specific person identity required (lifestyle content
  is interchangeable)
- **3 segments** for slow-cinematic feel: pillow → rise → window
- **Camera variety**: handheld micro-shake → locked → locked
- **Subject described once at top of segment 1**, then "she" continues
- **Named camera (Sony A7S3)** for cinematic realism without "cinematic
  8k" junk
- **No voiceover** — slow cinema doesn't need it. Sound design instead.

## Risks and badcases

- If `${subject}` is too vague, the model invents generic AI-pretty face
- If `${room_palette}` lacks lighting cue ("morning sunlight from right"),
  output may look fluorescent / flat
- This is a heavy-realism prompt; lighter models or non-Seedance video
  generators may need more conservative phrasing

## Variants

- **5s** — only segment 1 (pillow close-up + hand reveal)
- **15s** — add a 4th beat of getting out of bed walking toward window
- **Different time of day** — replace "morning" with "afternoon golden
  hour" / "dusk blue hour" / "evening tungsten warm"

## See also

- `../modes/t2v.md`
- `../decision-trees/camera-selection.md`
