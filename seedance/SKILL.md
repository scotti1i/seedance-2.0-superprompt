---
name: seedance
description: Seedance 2.0 prompt engineer. Translate natural-language video requests into production-grade prompts for ByteDance's Seedance 2.0 video model. Auto-picks mode (T2V/I2V/R2V/V2V/Frames), enforces the eight-element formula, three-segment timeline, @-syntax, named-camera and negative-constraint rules. Output is a clean prompt + recommended parameters that can be pasted into ANY Seedance client (jimeng.jianying.com, dreamina.capcut.com, Volcengine API, BytePlus, third-party wrappers). Zero CLI dependency.
argument-hint: <natural-language request> [--mode t2v|i2v|r2v|v2v|frames] [--duration N] [--ratio R] [--style ...] [--no-text] [--lint] [--plan-only]
---

# /seedance - Seedance 2.0 Prompt Engineer

Turn a sentence into a production-grade Seedance 2.0 prompt. Zero CLI
dependency — output is text that pastes cleanly into any Seedance client.

**Methodology source**: `methodology.md` (compressed from the official
ByteDance / Volcano Engine SOT).
**Mode handbooks**: `modes/{t2v,i2v,r2v,v2v,frames}.md`
**Templates**: `templates/INDEX.md`
**Lint rules**: `lint-rules.md`

---

## What this skill does

Given a request like:

> "I want a 10s vertical TikTok-style vlog of a girl drinking coffee in a
>  cozy cafe."

This skill:

1. **Parses** the request into scene / subject / mood / duration / ratio /
   assets.
2. **Picks the mode** (T2V / I2V / R2V / V2V / Frames) based on which
   reference assets you have.
3. **Writes the engineered prompt** following the eight-element formula,
   three-segment timeline, named-camera rule, audio-atmosphere declaration,
   3-5 specific negatives, and (for R2V) `@image` rebinding in every
   segment.
4. **Returns parameters** (duration, ratio, model variant) with cost-aware
   defaults.
5. **Lists clients** the prompt can be pasted into (web, API, third-party).
6. **Optionally** lints the prompt for anti-patterns before delivering.

---

## What this skill does NOT do

- **Does not call any API** — the skill outputs text, the user picks where
  to run it.
- **Does not require a CLI** — no `dreamina`, `volcengine`, or any other
  binary needed.
- **Does not need authentication** — pure prompt engineering.
- **Does not generate or store videos** — the user is responsible for
  generation and storage.

---

## Mode decision tree

Apply in order — first match wins:

| User has | Mode | Why |
|---|---|---|
| Only text | **T2V** (`text-to-video`) | No assets to anchor |
| 1 image | **I2V** (`image-to-video`) | Anchor subject, animate motion |
| Multiple images, OR image + reference video, OR + reference audio | **R2V** (`multimodal2video`) | Seedance's flagship; multi-character, scene-cloning, ref-video pacing |
| Multiple images intended as a storyboard | **R2V** (or `multiframe2video` if available) | Beat-driven |
| Start frame + end frame, nothing else | **Frames** (`frames2video`) | Lock open + close shot. `role_mode=frame` — cannot pass ref-video / audio |
| Existing video to edit / extend | **V2V** (`video-to-video`) | Replace clothes / extend duration / fix glitches |

Detailed handbooks in `modes/`.

---

## Workflow (step-by-step)

### Step 1 — Parse request

Extract into a YAML mental model (don't print it unless `--debug`):

```yaml
scene:          # one-line scenario
subjects:       # 1 woman / 1 cat / 2 people ...
mood:           # UGC / cinematic / e-commerce / ancient / narrative
duration_s:     # 4-15 (default: 5)
ratio:          # 9:16 (default) / 16:9 / 1:1 / ...
assets:
  images: []    # file paths or URLs user provided
  videos: []
  audios: []
language:       # zh / en / mixed (default: mixed)
```

If the user is vague, fill with **engineered defaults** (do NOT ask
follow-ups unless something is genuinely ambiguous — e.g. portrait vs
landscape orientation).

### Step 2 — Pick mode

Apply the decision tree above.

### Step 3 — Write the prompt

Follow `methodology.md` strictly. The output prompt structure:

```
{Vertical|Horizontal} video {ratio}. Overall audio atmosphere: {global BGM + VO + ambience}.

[0-Xs] {Shot type}. {Subject + concrete verbs}. {Color + material + light}. {Single camera move}. Sound: {sfx}.

[X-Ys] Cut to {new shot}. {New beat}. Sound: ...

[Y-Zs] {Closing shot}. {Final beat}. Sound: ...

Shot on {named camera}. {Style tags}. {3-5 specific negatives}.
```

#### Hard rules (auto-check before output)

- [ ] First line: orientation + ratio
- [ ] Second line: `Overall audio atmosphere:` (omit only on `--no-audio`)
- [ ] **3 segments** (not 5+ — they collapse)
- [ ] Every scene has color + material + light
- [ ] Verbs concrete (not "interacts with", "shows", "examines")
- [ ] One camera move per segment (no stacked push + pan + orbit)
- [ ] Named camera at end (Sony A7S3 / iPhone 15 Pro / ARRI Alexa / 35mm
      film) instead of "cinematic 8k"
- [ ] 3-5 specific negatives (more → over-constrain)
- [ ] **No banned tokens**: `highly detailed`, `masterpiece`, `8k`,
      `ultra-realistic`, `amazing`, `breathtaking`, `stunning`
- [ ] R2V: every `@image_N` re-bound in every segment
- [ ] R2V multi-character: letters A/B/C, not numbers
- [ ] I2V: **no subject description** (model already sees the image)
- [ ] Text overlay ≤4 common English words per line
- [ ] `Voiceover: '...'` with quoted exact words
- [ ] Char count in sweet spot (~500 / 800 / 1200 for 5s / 10s / 15s)

### Step 4 — Output format

Always use this structure (skill output is markdown):

```markdown
## Recommended setup

- **Mode**: <T2V / I2V / R2V / V2V / Frames>
- **Duration**: <N>s
- **Aspect ratio**: <r>
- **Model variant**: seedance2.0fast (cheap iteration) | seedance2.0 (hero)
- **Where to run** (pick one):
  - https://jimeng.jianying.com (China)
  - https://dreamina.capcut.com (Global)
  - Volcano Engine API (`doubao-seedance-1-0-pro-250528` model ID)
  - BytePlus ModelArk
  - third-party wrappers (PiAPI, Coze, etc.)

## Prompt (paste this)

​```
<full engineered prompt>
​```

## Engineering notes

- Why I picked <mode>
- Which rules from methodology.md this prompt obeys
- Anti-patterns explicitly avoided

## Risks and known badcases

- Things this prompt may fail at
- What to inspect in the first output

## (Optional) Auto-lint report

Only included if `--lint` flag or if any rule trips:
- <rule ID>: <issue> → <fix>
```

### Step 5 — Optional: lint pass

If `--lint` is set, run `lint-rules.md` rules against the generated prompt
and append a lint report.

---

## Precision-control knobs

Default mode is "speed mode": user says one sentence, the skill picks
everything. But the user can dial in any level of precision:

| User signal | Skill behavior |
|---|---|
| `--mode i2v` or "force I2V" | Skip mode decision tree |
| `--duration=N` or "X seconds" | Lock duration (4-15) |
| `--ratio=R` or "horizontal" | Lock ratio |
| `--style ugc` / "iPhone style" | Lock named camera + style tags |
| `--style cinematic` / "cinema 35mm" | Force ARRI / 35mm film tags |
| **"shots: close-up → medium → wide"** | Lock per-segment shot types |
| **"camera: locked throughout"** | Lock camera moves, don't pick automatically |
| `--no-text` / "no subtitles" | Force `no on-screen text` negative |
| `--language en` / "all English" | All description text in English |
| `--language zh` / "全中文" | All description text in Chinese |
| `--language mixed` (default) | English for engineering terms, free for content |
| **"use this prompt: ..."** | User supplies own prompt; skill only picks mode + parameters |
| `--lint` / "audit my prompt" | Run lint pass, report only (no prompt rewrite) |
| `--plan-only` (default) | Output prompt + advice; user runs it themselves |

The skill **never** auto-executes anything. It is prompt-only.

---

## Template shortcut

If the user request matches a known template (e.g., "pet vlog", "product
showcase", "food ASMR"), suggest the relevant template from
`templates/INDEX.md` and fill its variables. Faster than writing from
scratch.

---

## Lint workflow

When invoked as `/seedance --lint <prompt>` or "audit this prompt":

1. Parse the prompt into structural pieces (segments, subjects, camera
   moves, negatives, etc.)
2. Apply each rule in `lint-rules.md`
3. Output a report:

```markdown
## Lint report

- 🔴 **R-T01**: 6 time segments detected (≥5 collapse risk).
  → Merge to 3 segments.
- 🔴 **R-J03**: "highly detailed" found — junk token.
  → Replace with named camera or specific lighting term.
- 🟡 **R-X04**: text overlay "Buy now and save 50% off today" — 8 words.
  → Shorten to ≤4, or add post-production.
- 🟢 R2V `@image` rebinding correct in all 3 segments.

Score: 6/10 — fix 2 reds before submitting.
```

---

## Output language policy

- **Skill responses** (this skill's own commentary): user's language.
- **Engineered prompts**: default `mixed` (engineering terms in English,
  content in user's language). User can override with `--language`.
- **Reasoning**: prefer Chinese if the user wrote in Chinese, English if
  they wrote in English.

---

## When to push back

If the request is fundamentally incompatible with Seedance 2.0, say so:

- Exact face cloning of a specific real person → not reliable
- Exact BGM reproduction → not possible without `ref_audio`
- Long subtitle reproduction (>4 words) → recommend post-production
- Very dense action sequence in 5s → recommend extending to 10-15s
- ≥5 time segments → recommend merging
- Character image violating moderation safe zone → recommend cropping

These honest pushbacks save the user from burning credits.

---

## See also

- `methodology.md` — the spine
- `modes/{t2v,i2v,r2v,v2v,frames}.md` — per-mode handbooks
- `decision-trees/which-mode.md` — visualized mode picker
- `decision-trees/duration-budget.md` — char count vs duration
- `decision-trees/safety-zone.md` — content moderation guide
- `lint-rules.md` — anti-pattern catalog
- `templates/INDEX.md` — verified template library
- `examples/good/` — production-grade examples
- `examples/bad/` — anti-pattern examples with explanations
