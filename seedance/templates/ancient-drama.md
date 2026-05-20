---
name: ancient-drama
scenario: "Wuxia-style two-character confrontation on a mountain cliff"
mode: r2v
duration_s: 15
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [narrative, wuxia, ancient, premium]
variables:
  - name: "${heroine_a}"
    desc: "Description of character A (red robes)"
    example: "young woman in red robes, jade hairpin, calm expression"
  - name: "${heroine_b}"
    desc: "Description of character B (black robes)"
    example: "young woman in black robes, silver mask, intense gaze"
  - name: "${location}"
    desc: "Ancient setting"
    example: "cliff edge above a bamboo forest at dusk"
---

# Ancient Drama (Wuxia Confrontation)

## When to use

15s wuxia-style two-character moment. Premium cinematic look. Works for
historical drama trailers, short serial episodes, character introduction
shots.

## Required assets (R2V)

- `@image1` — character A (full appearance reference, headshot OR back/side
  full body)
- `@image2` — character B
- `@image3` — location reference (cliff / forest / temple)
- `@video1` (optional) — reference video for wuxia camera language

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: traditional Chinese guzheng melody with low bamboo flute, distant wind howling through a valley, no voiceover, intermittent percussion accents.

[0-5s] @image1 = woman A (${heroine_a}). @image3 = ${location}. Side-profile medium shot. Woman A stands at the cliff edge, holding a wine gourd, her robe billowing in the mountain wind. Camera orbits slowly from her side to her back. In the distance, woman B (${heroine_b}) appears as a barely visible figure among the bamboo. Sound: wind picks up, guzheng strikes a sustained note.

[5-10s] Cut to a drone aerial wide shot of @image3. Woman A and woman B stand at opposite ends of the cliff, robes whipping in the wind, dust kicked up between them. The camera holds, pacing matches @video1. Sound: percussion enters, bamboo flute carries the tension.

[10-15s] Cut to a tight close-up. Woman A slowly draws her sword, the blade catching the dusk light. Woman B mirrors the gesture. Cameras intercuts between their faces: woman A's expression goes from leisurely to cold, woman B's gaze sharpens. Sound: guzheng resolves, sword unsheath crack, then silence.

Shot on ARRI Alexa, 35mm film, anamorphic lens flare, deep contrast, cool desaturated palette, wuxia cinematic realism. Face stable, no distortion, body proportions natural, motion fluid, no plastic skin, no oversaturated colors, no on-screen text, no modern elements.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${heroine_a}` | Character A details | "young woman in red robes, jade hairpin, calm expression" |
| `${heroine_b}` | Character B details | "young woman in black robes, silver mask, intense gaze" |
| `${location}` | Ancient setting | "cliff edge above a bamboo forest at dusk" |

## Engineering notes

- **R2V** because two distinct characters need anchoring
- **Letters not numbers** for the multi-character disambiguation (rule
  from `r2v.md`)
- **Three escalating shots**: side-medium → drone aerial wide → intercut
  close-ups. Classic wuxia rhythm.
- **One camera move per segment**: slow orbit → locked aerial → intercut
- **ARRI Alexa + 35mm film + anamorphic** = premium drama look
- **Cool desaturated palette** specified explicitly because the model
  defaults to warm; wuxia is cooler

## Risks and badcases

- If characters in `@image1` and `@image2` are too similar (both in robes,
  similar hair), the model may swap them mid-shot. Use letters A/B
  consistently in every segment.
- Sword unsheath in segment 3 is a complex motion; if you see distortion,
  break it into two beats or remove the sword and just keep the gaze
  intensification
- "No modern elements" is a useful negative — without it the model may
  introduce subtle anachronisms

## Variants

- **10s tight** — drop segment 2 (drone aerial), keep cliff setup + close
  confrontation
- **Single character meditation** — only character A on the cliff, simpler,
  6-8s
- **Romance variant** — characters approach instead of confront

## See also

- `../modes/r2v.md`
- `../decision-trees/camera-selection.md`
- `../examples/good/wuxia-cliff.md`
