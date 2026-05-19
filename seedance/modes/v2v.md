# V2V — Video-to-Video

Edit, extend, or fix an existing video. Three sub-modes:
1. Local edits (replace clothes, change props)
2. Forward/backward extension
3. Glitch repair (face distortion, limb deformation, light jumps)

---

## When to use

- You have an existing video that's "almost right" but needs targeted fixes
- You want to extend a clip beyond its current end (or before its start)
- You want to fix subtle artifacts without re-generating from scratch
- You want to swap a character / product / background while keeping motion
  intact

## When NOT to use

- Major redesign (re-generate from R2V instead)
- The source video is below 480p (model can't work with it)
- The source video is longer than 15s (trim first)

---

## Iron rule: bind time + space together

V2V edits work by anchoring **what stays unchanged** AND **what changes**.

❌ Vague:
```
Change her jacket to red.
```

✅ Time + space binding:
```
Based on @video1. Throughout the 0-10s timeline, replace the blue jacket on the main character with a red jacket. Keep the face, hair, motion, background, and lighting completely unchanged. Final result should have natural color transition, no flicker or edge artifacts.
```

The structure:
1. Anchor: `Based on @video1`
2. Time scope: `Throughout 0-10s` or `From 3s to 7s`
3. What changes: the specific edit
4. What stays: explicitly list (face, motion, background, lighting)
5. Quality target: "natural color transition, no flicker"

---

## Sub-mode 1: Local edits

### Character replacement (scene stays)

```
Based on @video1. Throughout 0-10s, replace the woman in the scene with @image1 (a different east-asian woman in cream sweater). Keep the camera moves, background, lighting, and all motion sequences identical to @video1. The new character should perform the same actions: walking to the counter, lifting the mug, smiling.
```

### Product / prop swap

```
Based on @video1. From 3s onwards, replace the white ceramic mug in the character's hand with a black ceramic mug. Keep the hand position, the steam, the lighting, and all camera moves unchanged.
```

### Glitch repair

```
Based on @video1. Repair the face distortion visible at 4-6s on the main character. Keep the overall motion, scene, and lighting unchanged. Output should have a stable, undistorted face matching the appearance in the 0-3s portion of @video1.
```

---

## Sub-mode 2: Forward / backward extension

### Forward extension

```
Extend @video1 forward by 5 seconds. Keep the character's appearance, clothing, hairstyle, the scene, lighting, and color grading completely consistent with @video1. The extended segment should show the character {action that naturally follows}.
```

### Backward extension

```
Generate the 5 seconds that lead up to @video1. The character, scene, and lighting must match @video1 exactly at the point of join. Show the character {action that naturally precedes}.
```

### Use case: build longer narratives from chained 10s clips

Generate 10s with R2V → use V2V to extend forward another 5s → repeat.
Each pass anchors on the previous output, so identity stays consistent.

Caveat: BGM and voice continuity is hard across V2V extensions. Common
production strategy: generate video silent, add BGM/voice in post.

---

## Sub-mode 3: Track stitching

Stitch multiple independent shots together. Max **3 segments, total
duration ≤15s**.

```
Stitch the following clips seamlessly:
@video1 (0-5s) → @video2 (5-10s) → @video3 (10-15s)

Each clip features the same character (anchored by @image1) in different
locations. Maintain consistent color grading, character appearance, and
audio atmosphere across all three. Use natural cut transitions.
```

---

## Hard limits

| Item | Value |
|---|---|
| Max input videos | 3 (for stitching) |
| Total input duration | ≤ 15s |
| Output duration | 4-15s |
| Single input video | ≤ 50MB |

---

## Common pitfalls

| Pitfall | Fix |
|---|---|
| Editing fails silently (output looks unchanged) | Be more explicit about what changes vs stays. Use named regions ("the blue jacket") not vague references ("her clothes") |
| Edge flicker around edited region | Add "natural color transition, no flicker, no edge artifacts" to constraints |
| Extension introduces drift | Include a strong @image1 anchor + explicit "match @video1 at the join point" |
| BGM glitches across extension | Generate silent, add audio in post |
