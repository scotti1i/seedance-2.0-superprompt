# I2V — Image-to-Video

One image as the visual anchor, prompt drives motion only.

---

## When to use

- You have a clear hero image of your subject (person, pet, product)
- You want the **exact subject from the image**, animated
- You want to lock the opening frame composition
- You want UGC realism (image is already in your style)

## When NOT to use

- You need multiple characters (use R2V)
- You need scene + character separately (use R2V)
- You need to traverse multiple scenes (use R2V or chain T2Vs)
- Your image violates the moderation safe zone (full body + face) — crop
  first

---

## Iron rule: NEVER re-describe the subject

The model already sees the image. Re-describing the subject causes
**identity drift** — the face in the output won't match the image.

| ❌ Identity drift | ✅ Locked subject |
|---|---|
| `The same young woman in red lifts her arms ...` | `Slow handheld push-in. Subject lifts both arms above her head, exhales gently.` |
| `An east-asian girl with long hair sits in bed and smiles` | `Natural micro-movement: eyes slowly open, mouth corners lift into soft smile.` |

The prompt should only describe:
- **Motion** (subtle, continuous verbs)
- **Camera** (one move, named camera at the end)
- **Audio** (Overall atmosphere + Sound: ...)
- **Style** (named camera, film grain, etc.)
- **Negatives** (3-5)

**Never the subject's appearance.**

---

## Prompt skeleton

```
{Motion verbs: subtle, continuous, layered}. {Single camera move}. {Optional: lighting that wasn't in the original frame, e.g., "warm window light intensifies"}.

Sound: {sfx and BGM cues}.

Shot on {named camera}. {Style}. {3-5 specific negatives}.
```

Note: I2V prompts are usually **shorter** than T2V (300-600 chars). The
image carries most of the spatial information.

---

## Camera moves that work well for I2V

| Move | When to use |
|---|---|
| `slow push-in` | Build intimacy / suspense |
| `pull back` | Reveal context |
| `locked-off` | Let the subject's motion lead |
| `slight handheld bob` | UGC realism |
| `subtle orbit` | Show subject in 3D space |

Avoid stacked moves. One per shot.

---

## Worked example — "the girl in the image wakes up"

Input image: a young woman, side view, lying on a pillow, eyes barely open,
warm golden window light.

❌ Bad prompt:
```
The same young woman with long hair lies on the pillow. She opens her eyes
slowly and smiles. Warm sunlight, cozy bed. Cinematic, highly detailed, 8k.
```

✅ Good prompt:
```
Natural micro-movement: eyes are barely closed, slowly open as she lifts her gaze toward the bright window, the corner of her mouth lifts into a soft private smile. Subtle breathing rises and falls. Slight handheld shake. Slow push-in toward her face. Warm golden window light catches her cheekbone. Sound: faint fabric rustle, distant birdsong, warm lo-fi piano swells gently. Shot on iPhone 15 Pro, natural skin tone, slight film grain, documentary realism. No distortion, no plastic skin, no waxy face, no oversaturated colors.
```

Why this works:
- Zero subject description ("young woman", "long hair", "side view" all
  absent)
- Layered motion: eyes opening → gaze shifting → smile forming → breathing
- One camera move (slow push-in)
- Named camera (iPhone 15 Pro) implies UGC look
- 4 specific negatives

---

## Audio in I2V

Same rules as T2V: declare `Overall audio atmosphere` if you want BGM.
For very short I2V clips (4-5s), the audio declaration can be merged into
the main paragraph.

---

## Duration sweet spot

I2V works best at **4-6s**. Beyond 8s you may see subtle drift (subject
slowly morphing). For longer than 8s, consider:

1. Generate two 4-6s I2V clips, edit together (drift contained per clip)
2. Switch to R2V with a `ref_video` for pacing
