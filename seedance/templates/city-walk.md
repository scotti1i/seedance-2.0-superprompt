---
name: city-walk
scenario: "10s POV city walk through aesthetic district"
mode: t2v
duration_s: 10
ratio: 9:16
model_variant: seedance2.0fast
last_reviewed: 2026-05
tags: [lifestyle, travel, vlog, pov]
variables:
  - name: "${city_vibe}"
    desc: "City name or aesthetic"
    example: "tokyo shimokitazawa side street / kyoto temple lane / brooklyn williamsburg"
  - name: "${time_of_day}"
    desc: "Lighting context"
    example: "golden hour late afternoon / blue hour just after sunset / overcast diffuse noon"
---

# City Walk POV

## When to use

10s aesthetic travel content: POV walk through an interesting district.
Works for travel creators, local recommendations, "a day in [city]"
content.

## Required assets

None — pure T2V.

## Prompt (paste this)

```
Vertical video 9:16. Overall audio atmosphere: ambient city sounds with distant chatter, footsteps on pavement, faint music drifting from a nearby cafe, no voiceover, soft warm tonal music underscore.

[0-3s] POV shot, eye-level walking pace, slight handheld bob. Walking down a ${city_vibe} during ${time_of_day}. Foreground: cobblestone or pavement texture, slight shadow play. Middle ground: a single colorful storefront with hand-painted signage. Sound: footsteps on pavement, distant chatter.

[3-7s] Camera tilts up slightly to take in the architecture: brick walls, ivy crawling up, vintage lampposts just beginning to glow. A few passersby cross frame in soft focus. Pull back slightly to reveal a wider corridor of the street. Sound: nearby cafe music swells subtly, a bicycle bell rings in the distance.

[7-10s] The camera pauses, turns its gaze toward a single hero detail: a cat sunning on a window ledge, or a delicate hanging sign, or steam rising from a vendor. Sharp focus on the detail, background blurs softly. Sound: a final ambient resolve, music gently fades.

Shot on iPhone 15 Pro, handheld follow style, natural color, slight film grain, TikTok-style. Face stable (if any people visible), no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

## Variable substitution

| Variable | What to replace with | Example |
|---|---|---|
| `${city_vibe}` | District + aesthetic descriptor | "tokyo shimokitazawa side street" / "kyoto temple lane" |
| `${time_of_day}` | Lighting + time context | "golden hour late afternoon" / "blue hour just after sunset" |

## Engineering notes

- **T2V** because the location aesthetic is the subject; no specific
  identities to anchor
- **POV walking pace** gives travel-vlog feel
- **3 segments**: ground level → architecture tilt up → hero detail. Each
  zooms attention finer.
- **iPhone 15 Pro + handheld follow** = TikTok-native look
- **Audio layered**: footsteps → cafe music → ambient resolve. Creates
  spatial depth.

## Risks and badcases

- Generic "city" without specific vibe → output looks like AI-generic
  street stock
- Avoid naming famous landmarks (Eiffel Tower, etc.) — the model may
  refuse or generate inaccurate landmarks. Stay with district-level vibe.
- People in frame may look uncanny if too detailed — keep them in soft
  focus / partial occlusion

## Variants

- **5s** — segment 1 only (POV ground level walk)
- **15s** — add a 4th beat of crossing the street or entering a doorway
- **Nighttime** — replace `${time_of_day}` with "night, neon-lit streets,
  rain reflections on pavement"

## See also

- `../modes/t2v.md`
- `../decision-trees/camera-selection.md`
