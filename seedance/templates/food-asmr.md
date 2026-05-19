---
name: food-asmr
scenario: "8s food close-up with ASMR sound design"
mode: t2v
duration_s: 8
ratio: 9:16
model_variant: seedance2.0fast
verified_on: 2026-05
tags: [food, asmr, lifestyle]
variables:
  - name: "${food_item}"
    desc: "Specific dish + key visual detail"
    example: "freshly cracked egg yolk on rice / steaming dumplings / sliced sourdough"
  - name: "${sound_descriptor}"
    desc: "The hero ASMR sound to emphasize"
    example: "yolk rupture and slow ooze / steam hiss and chopstick clink / crust crunch and butter sizzle"
---

# Food ASMR

## When to use

8s mouth-watering food content. ASMR is the hook — sound design is as
important as visual. Works for recipe accounts, restaurant promo,
ingredient brands.

## Required assets

None — pure T2V.

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: pure ASMR — no music, only the natural sounds of the food preparation amplified slightly. Soft ambient kitchen texture.

[0-3s] Extreme close-up on ${food_item}, shot from a low angle to emphasize texture and steam. Warm overhead tungsten light, soft falloff. Slow push-in. Sound: ${sound_descriptor} — primary hero sound — captured close and intimate.

[3-6s] A pair of hands enters frame: chopsticks / fork / fingers / spoon — depending on the food. Single deliberate action: rupture / fold / lift / press. The texture transformation is the focus. Sound: the texture sound continues, slight enhanced foley, subtle ambient kitchen tone in the background.

[6-8s] Final beat: the food is brought toward the camera (toward the implied eater). Light catches the surface, glisten visible. Soft focus pull as the food approaches. Sound: the resolution sound — a sigh of satisfaction, a final delicate clink, or simply the ASMR fading naturally.

Shot on Sony A7S3, macro lens, natural color, slight film grain, food-blog realism. Face stable (if hand visible), no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${food_item}` | Specific dish + texture detail | "freshly cracked egg yolk on white rice" |
| `${sound_descriptor}` | The hero ASMR sound | "yolk rupture and slow ooze" |

## Engineering notes

- **T2V** because the food is anonymous (no brand needed)
- **No music** — ASMR works because the texture sound is the music
- **Macro lens** named in the camera tag for shallow DoF
- **Single deliberate action** in segment 2 — the texture transformation
  is the wow moment
- **3 segments**: close-up establish → texture transform → bring to camera

## Risks and badcases

- Generic "delicious food" → AI generic gourmet image. Be specific about
  texture and material.
- Sound descriptor is critical — if too vague ("food sounds"), the model
  generates generic chewy soundscape. Use specific physical-sensation
  words (rupture, ooze, crunch, sizzle, clink).
- 8s is tight for 3 segments — if you want more breathing room, extend
  to 10s.

## Variants

- **5s** — segment 1 only (close-up establishing shot with hero sound)
- **10s** — add a 4th beat of the eater's first taste reaction (handle
  identity drift if you want a specific person)
- **Cooking process** — replace the eating beat with cooking action
  (chopping, stirring, pouring)

## See also

- `../modes/t2v.md`
- `../methodology.md` § 9 (Audio writing)
