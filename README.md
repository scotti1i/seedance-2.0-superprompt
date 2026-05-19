# seedance-prompt

> A Claude Code skill that turns "I want a 10s cat vlog" into a
> production-grade Seedance 2.0 prompt that pastes cleanly into ANY
> Seedance client.

Zero CLI dependency. Zero API calls. Zero credentials.
Just engineered prompts, every time.

---

## What it does

```
You:    "10s vertical TikTok-style coffee shop POV in autumn"

Skill:  ## Recommended setup
        - Mode: T2V
        - Duration: 8-10s
        - Aspect ratio: 9:16
        - Model: seedance2.0fast
        - Paste into: jimeng / capcut / volcengine / byteplus / PiAPI

        ## Prompt

        Vertical video 9:16. Overall audio atmosphere: warm jazz piano...
        [0-3s] POV shot, eye-level walking pace, slight handheld bob...
        [3-6s] Camera tilts down to the barista's hands at the counter...
        [6-8s] Cut to a single ceramic cup of espresso on a walnut counter...
        Shot on Sony A7S3, natural skin tone, slight film grain...

        ## Engineering notes
        - Mode T2V because no anchor assets provided
        - 3-segment timeline (≥5 collapse — methodology rule R-T01)
        - Each segment has color + material + light triplet (R-S01)
        - One camera move per segment (R-C01)
        - Sony A7S3 named camera invokes documentary realism (R-J03)
        ...
```

Paste the prompt into [jimeng.jianying.com](https://jimeng.jianying.com),
[dreamina.capcut.com](https://dreamina.capcut.com), Volcano Engine API,
BytePlus ModelArk, or any third-party wrapper. Done.

---

## Why this exists

Seedance 2.0 by ByteDance is the strongest open multimodal video model
available — but writing good prompts for it is **a different skill** from
writing prompts for SD / Midjourney / Veo. The official guide is ~1100
lines of methodology. The reward for reading it is real (10× better
output) but the entry barrier is high.

This skill compresses that 1100-line SOT into a Claude-driven workflow:

| Problem | Fix |
|---|---|
| Junk tokens like `highly detailed`, `8k`, `masterpiece` hurt output | Lint catches them, replaces with named cameras (Sony A7S3, ARRI Alexa, iPhone 15 Pro, 35mm film) |
| Too many time segments (≥5) silently collapse | Skill forces 3-segment structure |
| I2V users re-describe the subject and cause identity drift | Skill enforces "motion only, never subject" |
| R2V users bind `@image1` once and get face swaps mid-shot | Skill rebinds in every segment |
| Multi-character prompts use `woman 3` and parser breaks | Skill uses letters A/B/C |
| Vague action verbs ("interacts with the product") produce vague output | Skill rewrites to concrete sequences ("rotates the bottle, places it on the table") |

---

## Install

### Option A — One-line install

```bash
curl -fsSL https://raw.githubusercontent.com/<your-username>/seedance-prompt/main/install.sh | bash
```

### Option B — Manual

```bash
git clone https://github.com/<your-username>/seedance-prompt.git
cp -r seedance-prompt/seedance ~/.claude/skills/seedance
```

### Option C — Symlink (for contributors)

```bash
git clone https://github.com/<your-username>/seedance-prompt.git
ln -s "$(pwd)/seedance-prompt/seedance" ~/.claude/skills/seedance
```

After install, restart Claude Code. The skill becomes available as
`/seedance` and is auto-triggered when you mention Seedance / video
generation / Dreamina / 即梦.

---

## Quick start

### Speed mode (one sentence)

```
/seedance 10s vertical cat playing with a ball in soft afternoon light
```

The skill auto-picks T2V, 9:16, 10s, seedance2.0fast, generates a 3-segment
engineered prompt, and lists where you can paste it.

### Precision mode (lock specific knobs)

```
/seedance product showcase 8s 16:9 cinematic, ARRI Alexa look, no subtitles
```

The skill respects every constraint you specify.

### Templates (pre-built scenarios)

```
/seedance use template pet-vlog, my pet is a tabby cat, product is a blue
collar from Petsmart
```

Substitutes variables in the verified `pet-vlog` template.

### Lint an existing prompt

```
/seedance lint <your prompt>
```

Runs 25 lint rules and reports a grade.

### Clone a reference video (advanced)

```
/seedance clone <video URL or local path>
```

Walks through asset extraction (frames + ref video + ref audio) + Gemini
VLM reverse-engineering + final R2V prompt.

---

## Features

### 🎯 Auto mode selection
Picks T2V / I2V / R2V / V2V / Frames based on what assets you have.

### 📐 Methodology enforcement
25 lint rules from the official ByteDance SOT + field tests.

### 📚 Template library
8 verified production templates: pet vlog, product showcase, morning
routine, city walk, food ASMR, ancient drama, unboxing, before/after.

### 🌍 Multi-client output
One prompt format works across:
- [jimeng.jianying.com](https://jimeng.jianying.com) (China web)
- [dreamina.capcut.com](https://dreamina.capcut.com) (Global web)
- Volcano Engine API (`doubao-seedance-1-0-pro-250528`)
- BytePlus ModelArk
- PiAPI, Coze, 即梦助手 (third-party wrappers)
- ByteDance internal CLI (if you have access)

### 🚫 Zero infrastructure
No API calls. No credentials. No payment. Pure prompt engineering.

### 🌐 Bilingual
Prompts in Chinese, English, or mixed. Engineering tags stay English
(industry standard), content language is your choice.

---

## Repository structure

```
seedance-prompt/
├── README.md            ← you are here
├── LICENSE              ← MIT
├── CONTRIBUTING.md      ← how to add templates / lint rules
├── install.sh           ← one-line installer
├── TESTING.md           ← end-to-end test scenarios
├── .github/             ← issue and PR templates
└── seedance/            ← the skill itself (symlink target)
    ├── SKILL.md         ← Claude entry point
    ├── methodology.md   ← 500-line distilled SOT
    ├── modes/           ← per-mode handbooks (t2v / i2v / r2v / v2v / frames)
    ├── decision-trees/  ← visual pickers (mode / duration / camera / safety)
    ├── templates/       ← verified production templates
    ├── examples/        ← good / bad prompt examples
    └── lint-rules.md    ← 25 anti-pattern catalog
```

---

## Template catalog

| Template | Mode | Duration | Use case |
|---|---|---|---|
| [pet-vlog](seedance/templates/pet-vlog.md) | R2V | 15s | Pet outdoor walk + product showcase (TikTok viral) |
| [product-showcase](seedance/templates/product-showcase.md) | R2V | 10s | Hero rotation + features + brand close-up |
| [morning-routine](seedance/templates/morning-routine.md) | T2V | 10s | Slow-cinematic lifestyle vignette |
| [city-walk](seedance/templates/city-walk.md) | T2V | 10s | POV travel through aesthetic district |
| [food-asmr](seedance/templates/food-asmr.md) | T2V | 8s | Food close-up with ASMR sound |
| [ancient-drama](seedance/templates/ancient-drama.md) | R2V | 15s | Wuxia two-character confrontation |
| [unboxing](seedance/templates/unboxing.md) | R2V | 10s | POV unboxing reveal |
| [before-after](seedance/templates/before-after.md) | R2V | 8s | Cosmetics / transformation reveal |

Add yours with a PR — see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Methodology summary

The skill enforces:

1. **Eight-element formula** — subject + action + scene + light + camera +
   style + quality + constraints, in that order
2. **Three-segment timeline** — `[0-Xs]` `[X-Ys]` `[Y-Zs]`. ≥5 collapses.
3. **Scene triplet** — color + material + light for every scene
4. **One camera move per segment** — no stacking
5. **Named camera, not "cinematic"** — Sony A7S3, ARRI Alexa, iPhone 15
   Pro, 35mm film
6. **R2V: `@image_N` rebound every segment** — pronouns lose anchor
7. **Multi-character: letters A/B/C** — numbers confuse the parser
8. **I2V: never re-describe subject** — image already has the info
9. **Audio atmosphere declared at top** — buried BGM gets ignored
10. **3-5 specific negatives** — more over-constrains

Full details: [methodology.md](seedance/methodology.md).

---

## What this skill is NOT

- ❌ A wrapper around the dreamina / volcengine CLI
- ❌ A video generator (it produces prompts, not videos)
- ❌ A paid service (no credits, no API keys)
- ❌ A guarantee — Seedance is non-deterministic; expect 2-5 retries for
  hero shots
- ❌ Affiliated with ByteDance / Volcano Engine / Dreamina / Jianying

---

## Contributing

The skill gets stronger every time someone:

- adds a new verified template
- finds a new anti-pattern and writes a lint rule
- updates methodology after a Seedance model version bump
- contributes a good / bad example

See [CONTRIBUTING.md](CONTRIBUTING.md) and the
[issue templates](.github/ISSUE_TEMPLATE/) to get started.

---

## Roadmap

- [ ] Add 12 more templates (target: 20 total)
- [ ] Cross-model adapters (when Veo / Sora prompts diverge)
- [ ] Auto-update when official ByteDance SOT changes
- [ ] Video-output benchmark suite (with anonymized eval samples)
- [ ] CLI companion (lint as a standalone binary)

---

## License

MIT. See [LICENSE](LICENSE).

---

## Acknowledgments

- ByteDance Seedance team for the official prompting guide
- Volcano Engine docs team for the API reference
- The community of creators who've shared field-tested prompts on
  Lark, WeChat, and small Discord servers — your write-ups made this
  possible
