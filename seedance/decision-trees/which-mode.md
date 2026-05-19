# Decision Tree: Which Mode to Use

Pick the mode in this order — first match wins.

```
START
│
├─ Do you have a precise opening AND closing frame?
│      └─ YES → Frames mode
│              (cannot use ref_video / ref_audio)
│
├─ Do you have an existing video you want to edit, extend, or fix?
│      └─ YES → V2V mode
│
├─ Do you have multiple reference assets?
│      (multiple images, OR image + ref_video, OR + ref_audio,
│       OR multiple characters, OR scene-cloning intent)
│      └─ YES → R2V (multimodal) mode
│
├─ Do you have exactly one reference image you want to animate?
│      └─ YES → I2V mode
│              (never re-describe the subject)
│
└─ No assets, just an idea?
       └─ T2V mode
```

---

## Quick rules of thumb

| You have... | Use |
|---|---|
| Just an idea | T2V |
| One hero image | I2V |
| One character + scene image | R2V |
| One character + reference video pacing | R2V |
| Multiple characters | R2V (use letters A/B/C) |
| Reference TikTok / Reel to clone | R2V (+ extracted frames + trimmed ref_video) |
| First + last frame locked, nothing else | Frames |
| Existing 10s clip that needs to become 15s | V2V (forward extension) |
| Existing clip with face glitch at 4-6s | V2V (glitch repair) |

---

## Why mode picking matters

Each mode has different iron rules, and breaking them wastes credits:

- **T2V** without enough detail → generic AI-looking output
- **I2V** with subject redescription → identity drift
- **R2V** with only first-segment `@image` binding → face swap mid-shot
- **Frames** with `ref_video` → API returns 422
- **V2V** without explicit "what stays" → unintended changes

The decision tree forces you to match the input shape to the mode that
respects it.

---

## When multiple modes could work

Sometimes both I2V and R2V are technically valid. Tie-breakers:

| Tie | Pick |
|---|---|
| 1 image + need pacing transfer | **R2V** (only mode that takes ref_video) |
| 1 image, very short clip (≤5s) | **I2V** (simpler, less to go wrong) |
| 1 image, want jump cuts | **R2V** (ref_video transfers cut style; I2V is single-shot) |
| Multiple poses of same character | **R2V** (do NOT 9-grid for I2V) |
| Brand commercial, clean look | **T2V** ("too clean" = premium; ref_video adds UGC vibe you don't want) |
| TikTok / UGC aesthetic | **R2V** with `@ref_video` (clean shots feel too sterile) |

---

## See also

- `../modes/t2v.md`, `i2v.md`, `r2v.md`, `v2v.md`, `frames.md`
- `../methodology.md` § 13 (Five generation modes summary)
