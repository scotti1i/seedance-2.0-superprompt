# Decision Tree: Duration & Prompt-Length Budget

Seedance 2.0 has a sweet spot. Outside it, the model either runs out of
budget or runs short on instruction.

---

## Duration sweet spots

| Duration | Use case | Stability |
|---|---|---|
| **4s** | A/B testing, prompt iteration | Stable, cheapest |
| **5s** | Single-shot hook, micro-narrative | **Most stable** |
| **6-7s** | 2-beat narrative | Stable |
| **8s** | 2-3 segment narrative | Stable |
| **10s** | 3-segment narrative | **Most stable** (sweet spot) |
| **11-14s** | Longer 3-segment narrative | Slight drift risk |
| **15s** | 3-segment narrative, max single-call | Hard cap |

Anything beyond 15s needs V2V extension (chained generations).

---

## Char count by duration

| Duration | Prompt sweet spot |
|---|---|
| 4-5s | ~500 chars |
| 8s | ~700 chars |
| 10s | ~800 chars |
| 12-15s | ~1000-1200 chars |

Hard limits: 500 Chinese chars / 1000 English words / ≤ 2000 bytes UTF-8.

If you exceed, the model truncates silently — usually loses the
last segment.

---

## Segment count

| Segments | Verdict |
|---|---|
| 1 | OK for I2V short clips (4-5s) |
| 2 | OK for 6-8s |
| **3** | **Sweet spot** for 8-15s |
| 4 | Risk segments collapse |
| ≥5 | Model drops segments — DO NOT USE |

---

## Char budget formula

```
prompt_chars ≈ 200 (header overhead)
             + duration_s × 50-80 (scene/segment content)
             + 100 (footer: camera + style + negatives)
```

So:
- 5s prompt ≈ 200 + 5×60 + 100 = 600 chars
- 10s prompt ≈ 200 + 10×60 + 100 = 900 chars
- 15s prompt ≈ 200 + 15×60 + 100 = 1200 chars

If your prompt is way over this, you're being too verbose. If way under,
you're being too sparse.

---

## When to extend vs split

You want a 20s video. Options:

| Option | Pros | Cons |
|---|---|---|
| **V2V forward extension** (10s base + extend 10s) | Single character / scene continuity | BGM rarely continuous |
| **Two R2V clips, edit together** (10s + 10s) | Cleaner, parallel generation | Need post-edit alignment |
| **Single 15s + 5s V2V extension** | Closest to single-call quality | Still BGM seam |

Pro tip from field tests: generate **silent video**, add audio in post. The
audio-continuity problem disappears.

---

## Cost-aware duration picking

If you're A/B testing prompts:
- Start at 4-5s (cheapest, ~20-25 credits per shot)
- Lock the prompt
- Re-run at 10-15s for hero shots

If you're producing for a TikTok / Reel post:
- 10s is the sweet spot (also matches average UGC short length)
- 15s only if your story genuinely needs the time

---

## See also

- `../methodology.md` § 2 (Time-axis storyboard)
