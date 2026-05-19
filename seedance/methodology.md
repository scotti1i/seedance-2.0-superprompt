# Seedance 2.0 Prompt Engineering Methodology

> Distilled from the official ByteDance / Volcano Engine guides + ~100 verified
> production runs. Read this once. It becomes the spine of every prompt you write.

---

## 0. The mental model

Seedance 2.0 is a **multimodal AI director**. Internally it parses your input
into two layers:

| Layer | What it handles | What you should write |
|---|---|---|
| **Spatial** | Subject, scene, composition, color, lighting, camera params | Subject description, scene triplet (color + material + light), shot type, named camera, `@image` bindings |
| **Temporal** | Action sequence, edit pacing, camera motion path | Time segments `[0-Xs]`, motion verbs, jump-cut signals, reference video pacing |

**Implication**: a good prompt is an **engineering instruction**, not a stack
of adjectives. Feed both layers explicitly.

---

## 1. The eight-element formula

Write in **this order**:

```
Precise subject + action detail + scene + light/color + camera + style + quality + constraints
```

Logic: lock "who / doing what" → "where / what mood" → "how it's shot" →
finally style, quality, and constraints to tighten.

### Lightweight version

```
Subject + motion + (environment) + (camera) + (aesthetic) + (audio)
```

### Director structure (best for cinematic / narrative)

```
Subject + action + camera + scene + style + constraints
```

The first 10-15 tokens carry the most attention weight. **Subject + action go
first**.

---

## 2. Time-axis storyboard (highest-leverage technique)

### Three-segment template (most reliable)

```
Vertical/Horizontal video <ratio>. Overall audio atmosphere: <BGM + voice + ambience>.

[0-Xs] <Shot type>. <Subject + concrete verbs>. <Scene: color + material + light>. <Single camera move>. Sound: <sfx>.

[X-Ys] Cut to <new shot>. <New beat>. Sound: ...

[Y-Zs] <Closing shot>. <Final beat>. Sound: ...

Shot on <named camera>. <Style tags>. <3-5 specific negatives>.
```

### Segment count

| Segments | Verdict |
|---|---|
| **3 segments** | Most stable — hook [0-3s] + body [3-7s] + cta [7-10s] |
| 4 segments | OK for multi-step demos |
| ≥5 segments | Model collapses or drops segments — **avoid** |

### Prompt-length sweet spot

| Chars | Verdict |
|---|---|
| <500 | Too short |
| 500-800 | Simple scenes OK |
| **800-1200** | **Sweet spot** |
| 1200-1800 | Complex narrative OK, no guaranteed gain |

By duration:
- 5s → ~500 chars
- 10s → ~800 chars
- 15s → ~1200 chars

### Hard limits

- 500 Chinese chars / 1000 English words
- Recommended ≤ 2000 bytes UTF-8

---

## 3. Action writing — three rules

1. **Prefer slow, continuous micro-actions** (slow walk, gentle hand lift,
   slight head tilt). Violent actions wreck consistency.
2. **Write transitions between actions** ("riding the momentum of her turn,
   she lifts the cup"; "the pause naturally flows into a raised hand").
3. **Externalize emotion** with body signals, not adjectives:
   - ❌ "very sad"
   - ✅ "lip trembles, eyes redden, shoulders shake slightly"

### Concrete verb > vague description

| ❌ Vague | ✅ Engineered |
|---|---|
| "interacts with the product" | "rotates the bottle slowly, places it on the table" |
| "shows the item" | "lifts the lid, leans in, smiles" |
| "the car turns" | "tires smoke as the car drifts 90 degrees" |

### Physical-sensation vocabulary

Use words that imply weight, friction, momentum, inertia, splash, ripple,
drag, settle, collapse, bounce, sway, drift. The model has strong physics
priors — invoke them.

---

## 4. Scene and lighting — the triplet rule

Every scene description needs **color + material + light**. Anything less
collapses to AI generic.

- ❌ "bright bedroom"
- ✅ "beige walls, cream linen sheets, natural sunlight from the right window"

### Lighting vocabulary

| Type | Keywords |
|---|---|
| Natural | natural sunlight, golden hour, blue hour, overcast diffuse, dawn, dusk |
| Artificial | tungsten warm, neon glow, fluorescent flicker, candlelight, ring light |
| Cinematic | rim light, volumetric god rays, hard key, soft fill, chiaroscuro |
| Atmospheric | foggy, misty, hazy, smoky, steam, dust particles |

Always prefer specific physical-light terms over junk like "cinematic" or
"highly detailed".

---

## 5. Camera language — one move per segment

### Camera-move vocabulary

| Type | Token |
|---|---|
| Push | `slow push-in`, `dolly forward` |
| Pull | `pull back`, `dolly back` |
| Pan | `pan left/right` |
| Track | `tracking shot`, `lateral slide` |
| Follow | `handheld follow` |
| Crane | `crane up/down` |
| Orbit | `orbit around`, `360 rotation` |
| Locked | `locked-off`, `static`, `fixed camera` |
| Aerial | `drone aerial`, `top-down aerial` |

**Iron rule**: one camera move per segment. Don't stack push + pan + orbit —
the model gets confused or silently drops some.

### Named-camera trick

Real camera/lens names invoke the model's implicit knowledge of that
aesthetic — beats abstract "cinematic / 8k":

- `Shot on Sony A7S3` — clean low-light, natural skin
- `Shot on ARRI Alexa` — cinematic latitude
- `Shot on iPhone 15 Pro` — UGC realism, vertical-native
- `Shot on RED Komodo` — sharp, high contrast
- `35mm film` / `anamorphic lens flare` — vintage cinematic

### Jump-cut signals

Jump cuts work, but the prompt must explicitly signal:
- "Cut on the beat to ..."
- "Smash cut to ..."
- "Instantly, the scene changes to ..."
- "On the music drop, ..."

---

## 6. Multimodal @-syntax (R2V mode)

When you pass multiple reference images / videos / audio:

### Iron rule: re-bind in every segment

❌ Only binding `@image1` in the first segment → face swaps, character drift,
scene jumps in later segments.

✅ Re-write `@image1` `@image2` etc. in every `[time]` segment.

### Multi-character disambiguation

Use **letters A/B/C**, not numbers, to avoid parser ambiguity:

- ❌ `@image3 is woman 3, woman 3 stands at left, woman 4 ...` — parser may
  read "woman 3" as "the 3rd one is at...".
- ✅ `@image3 is woman C. Woman C stands at left, woman D ...`

### Asset ID is NOT the binding

When calling the API directly with asset IDs:

- ❌ Telling the model `asset-xxxx is Li Wu` and hoping the model maps
  asset-IDs to characters — it doesn't.
- ✅ Explicitly write "image 1 is Li Wu, image 2 is Su Yinxi", then pass
  images in that order.

### Pronouns must be re-bound

In Chinese, "she / he / it" needs `@image1` glue. In English the same:
"she walks forward" → "@image1 walks forward" when there are multiple
characters in a scene.

### Sweet-spot count

Max: 9 images / 3 videos / 3 audios. **Recommended: 4-5 total assets**
(1 character + 1 scene + 1 ref video + 1 audio + maybe 1 more). Filling all
9 slots actually hurts coherence.

---

## 7. I2V — never re-describe the subject

When you pass a single image to image-to-video, **the model already sees the
subject**. Re-describing causes identity drift.

- ❌ `the same young woman in red ...`
- ✅ `Natural micro-movement, gentle background depth, slow push-in`

Write **only motion + camera + audio + style + negatives**. Skip subject
entirely.

---

## 8. Text rendering

| Text type | Success rate | Verdict |
|---|---|---|
| ≤4 common English words | ~90% | Safe — let model render |
| 5-8 words | ~50% | Risky |
| Long phrases, brand names, proper nouns, Chinese long subtitles | <20% | **Add in post** |

Format: `On-screen text: 'Short line'`. Avoid em-dash `—` (model truncates
after it).

To disable subtitles, add `no on-screen text` or `不要生成字幕` to
constraints.

---

## 9. Audio writing

### Symbols

| Symbol | Use |
|---|---|
| `()` | BGM / music |
| `{}` | Dialogue / lines |
| `Voiceover: '...'` | Literal voiceover (quote the exact words) |
| `Sound: ...` | SFX |

### Iron rule: declare audio atmosphere at the top

❌ "BGM plays" buried inside `[3-7s]` segment — likely ignored.
✅ First line after the ratio:
```
Overall audio atmosphere: warm lo-fi piano, gentle female voiceover, soft morning ambience.
```

### Voiceover format

- ❌ "A woman speaks softly about life" — model has no script
- ✅ `Voiceover: 'I finally found the one.'`

### Pacing test

Mentally read voiceover lines aloud. If they don't fit the segment time, the
model will compress to 2× speed → robot voice.

---

## 10. Reference video / audio strategy

### What ref-video transfers

| Transfers | Does NOT transfer |
|---|---|
| Camera motion style (handheld vs locked) | Specific subjects / identities |
| Edit pacing (fast cuts vs long takes) | Dialogue / overlay text |
| Color grading mood | Specific scene content |
| Jump-cut timing | Brand / logo |

### When to use ref-video

- UGC / e-commerce: **mandatory** for authentic feel
- Brand commercial: skip — "too clean" = premium look

### Hard limits

| Item | Value |
|---|---|
| Max ref videos | 3 |
| Single video duration | [2, 15]s |
| Total video duration | ≤ 15s |
| Single file size | ≤ 50MB |
| Format | mp4, mov |
| Resolution | 480p, 720p |
| Frame rate | [24, 60] FPS |

| Item | Audio value |
|---|---|
| Max ref audios | 3 |
| Single audio duration | [2, 15]s |
| Single file size | ≤ 15MB |

---

## 11. Constraints — the negative list

### Universal Chinese suffix

```
面部稳定不变形、五官清晰、人体结构正常、动作自然流畅、不僵硬、画面无卡顿、无闪烁
```

### Universal English suffix (3-5 specific negatives)

```
Face stable, no distortion, body proportions natural, motion fluid,
no plastic skin, no oversaturated colors, no on-screen text.
```

### Iron rule: 3-5 specific negatives

More than 5 → model over-constrains → output goes stiff or fails. Pick the
most relevant 3-5 for your use case.

### Banned tokens (junk — known to hurt)

```
highly detailed · masterpiece · 8k · ultra-realistic · award-winning
amazing · breathtaking · stunning · incredible
cinematic (when used alone, no other context)
```

Replace with specific camera / film stock / lighting terms.

---

## 12. Content moderation safe zone (character reference images)

> **Iron rule**: "Face OR legs visible, never both."

A face-recognizable shot + body visible ≥ ¾ = blocked 100% of the time.

| ✅ Safe (passes) | ❌ Blocked (100% reject) |
|---|---|
| Headshot (shoulders up) | Full body + face |
| Half-body (waist up) | ¾ body + face |
| Back / side full-body | Multi-face photos |
| Distant figure (<20% frame) | 9-grid character sheets |
| Cartoon / illustration | Selfie with bystanders |
| Product-only | Group photos |

Error codes:
- `CONTENT_MODERATION` — review layer
- `VG_E000` — model-layer refusal
- `OutputAudioSensitiveContentDetected` — audio review

---

## 13. Five generation modes

| Mode | Input | Best for | Key rule |
|---|---|---|---|
| **T2V** | Text only | Concept tests, no assets | Full 8-element formula |
| **I2V** | 1 image + text | Lock subject look | **Never re-describe subject** |
| **R2V (Multimodal)** | Multi-image + video + audio | Multi-character / scene-cloning | Re-bind `@image` every segment |
| **V2V** | Existing video | Edit / extend | Bind time + space; describe what stays + what changes |
| **Frames** | Start + end frame | Lock open + close shot | `role_mode=frame`; **no** ref-video / audio |

---

## 14. API constraints summary

| Model | Duration | Resolution | Aspect ratios |
|---|---|---|---|
| `seedance2.0` (Pro) | 4-15s | 720p | 1:1 / 3:4 / 16:9 / 4:3 / 9:16 / 21:9 |
| `seedance2.0fast` | 4-15s | 720p | same |

Duration: continuous integers 4-15. **5 and 10 are the most stable
archetypes**.

### Mutual exclusion

| role_mode | Images | Reference video | Reference audio |
|---|---|---|---|
| `reference` (97% of uses) | Style reference | ✅ Can pass | ✅ Can pass |
| `frame` (3% of uses) | First / last frame | ❌ 422 error | ❌ 422 error |

---

## 15. Pre-submit checklist (copy verbatim before sending)

- [ ] First line states orientation + ratio
- [ ] Line 2 declares `Overall audio atmosphere:`
- [ ] 3 time segments (not ≥5)
- [ ] Each scene has color + material + light
- [ ] Verbs are concrete (no "interacts with", "examines")
- [ ] One camera move per segment
- [ ] No banned tokens (`highly detailed`, `8k`, etc.)
- [ ] Named camera at end
- [ ] 3-5 specific negatives
- [ ] Text overlay ≤4 words/line
- [ ] Audio uses `Voiceover: '...'` with quoted lines
- [ ] R2V: every `@image` re-bound in every segment
- [ ] Multi-character: letters A/B/C, not numbers
- [ ] Product color: let the image decide, don't hard-code in prompt
- [ ] Duration 5 / 10 / 15 (most stable)
- [ ] If `role_mode=frame`: no ref-videos / audios
- [ ] Jump cuts have explicit signal words
- [ ] Character reference images in the safe zone

---

## Sources

- ByteDance official Larksuite SOT (Seedance 2.0 prompting guide)
- ByteDance Volcano Engine official docs: https://docs.byteplus.com/en/docs/ModelArk/2222480
- ByteDance Volcengine docs: https://www.volcengine.com/docs/82379/2222480
- Field tests: 100+ verified production prompts (2026-03 to 2026-05)

Last verified: 2026-05
