# T2V — Text-to-Video

Pure text input, no reference assets. Most flexible, least controllable.

---

## When to use

- Concept tests and rapid iteration (no asset prep)
- Generic scenes ("a city skyline at sunset")
- Style exploration (try 5 lighting moods cheaply)
- When you don't yet have anchor images

## When NOT to use

- You need a specific person / pet / product (use I2V or R2V)
- You need consistent characters across multiple shots (use R2V)
- You're cloning a reference video's pacing (use R2V with `ref_video`)

---

## Prompt skeleton

```
{Vertical|Horizontal} video {ratio}. Overall audio atmosphere: {BGM + VO + ambience}.

[0-Xs] {Shot type}. {Detailed subject description}. {Scene: color + material + light}. {Single camera move}. Sound: {sfx}.

[X-Ys] Cut to {new shot}. {New beat}. Sound: ...

[Y-Zs] {Closing shot}. {Final beat}. Sound: ...

Shot on {named camera}. {Style}. {3-5 specific negatives}.
```

---

## Iron rules

1. **Subject description is critical** — model has nothing else to anchor
   on. Be specific: "young east-asian woman in cream linen pajamas, dark
   shoulder-length hair, natural skin, no makeup"
2. **Scene triplet every segment** — color + material + light
3. **First 10-15 tokens get most attention** — put subject + action first
4. **3 segments only** — ≥5 collapse
5. **Named camera ≠ "cinematic"**

---

## Common pitfalls

| ❌ | ✅ |
|---|---|
| `a girl in a coffee shop, very pretty, masterpiece` | `young woman with shoulder-length dark hair, beige sweater, sitting at a marble coffee bar` |
| `cinematic, highly detailed, 8k` | `Shot on Sony A7S3, natural skin tone, slight film grain` |
| `she does product demo` | `she rotates the bottle slowly, lifts it to eye level, smiles` |
| All 5 segments | 3 segments with the most important beats |

---

## Worked example — "10s vertical coffee-shop vlog"

```
Vertical video 9:16. Overall audio atmosphere: warm lo-fi piano with gentle female voiceover, soft cafe ambience with distant chatter and espresso machine hiss.

[0-3s] Medium close-up shot, handheld. A young east-asian woman with shoulder-length dark hair, cream linen sweater, sits at a marble coffee bar. Warm tungsten pendant light above, dark walnut shelves behind, single ceramic mug with steam rising. Slight push-in toward the mug. Sound: porcelain settles on marble, espresso machine hisses softly.

[3-7s] Cut to extreme close-up of the mug. Her fingers wrap around the ceramic, condensation traces the rim, golden window light catches the foam ripples. She tilts the mug slowly. Sound: gentle slosh, lo-fi piano swells.

[7-10s] Pull back to medium shot. She lifts the mug, takes a slow sip, eyes drift to the window, the corner of her mouth lifts into a small private smile. Sound: lo-fi piano resolves into a soft chime.

Shot on Sony A7S3, natural skin tone, warm color grading, documentary realism. Face stable, no distortion, motion fluid, no plastic skin, no oversaturated colors, no on-screen text.
```

Why this works:
- Subject described once at the top, then continuity via "she" + scene
  consistency
- 3 segments, each with color + material + light triplet
- One camera move per segment (push-in → locked → pull back)
- Named camera + 5 specific negatives at the end

---

## Cost / time

- 5s: fastest iteration, ~500 chars prompt
- 10s: sweet spot, ~800 chars
- 15s: complex narrative, ~1200 chars

Use `seedance2.0fast` for iteration. Switch to `seedance2.0` Pro for hero
shots once the prompt is locked.
