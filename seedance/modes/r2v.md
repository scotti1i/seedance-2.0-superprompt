# R2V — Multimodal Reference (Flagship Mode)

Seedance 2.0's strongest mode. Accepts up to 9 images, 3 reference videos,
and 3 reference audios. This is where Seedance pulls ahead of competitors.

---

## When to use

- Multiple characters in one scene
- Multiple scenes you want to anchor (interior + exterior + product
  close-up)
- Cloning a reference video's pacing / camera style
- Cloning a BGM's energy via reference audio
- Production-grade content where you need maximum control

## When NOT to use

- You have only one image and one subject (use I2V — simpler, less
  identity drift)
- You only need style mood, not exact subjects (use T2V with named camera)
- Your input violates the moderation safe zone

---

## Asset role allocation (4-asset sweet spot)

Don't max out at 9 images. Recommended distribution:

| Slot | Role | What it does |
|---|---|---|
| `@image1` | **Character anchor** | Locks who the subject is |
| `@image2` | **Scene anchor** | Locks the setting |
| `@image3` | **Product / detail anchor** | Locks the product or hero detail |
| `@image4` | **Optional: second scene or second character** | When the story moves |
| `@video1` | **Pacing / camera reference** | Transfers cut rhythm and camera style |
| `@audio1` | **BGM / VO style reference** | Transfers music energy and voice character |

4 images + 1 video + 1 audio = 6 assets. **More than this hurts coherence.**

---

## Iron rule #1: Re-bind `@image_N` in EVERY segment

The most common R2V failure: binding `@image1` only in the first segment,
then writing the rest with pronouns ("she walks ..."). Result: face swap,
subject drift, scene jump in later segments.

❌ Single binding:
```
[0-3s] @image1 sits at the table holding a coffee.
[3-7s] She lifts the mug ...     ← "she" loses anchor
[7-10s] She smiles at the camera ... ← drift
```

✅ Every-segment rebinding:
```
[0-3s] @image1 sits at the table holding a coffee.
[3-7s] @image1 lifts the mug ...
[7-10s] @image1 smiles at the camera, light from @image2 ...
```

---

## Iron rule #2: Multi-character disambiguation

When the prompt has multiple characters, use **letters** (A/B/C/D), not
numbers. Parser confusion is real.

❌ Number ambiguity:
```
@image3 is woman 3. Woman 3 stands at the left, woman 4 enters from the right.
```
The parser may read "woman 3" as "the 3rd one" and pick a different person.

✅ Letters:
```
@image3 is woman C. Woman C stands at the left, woman D enters from the right.
```

---

## Iron rule #3: Asset IDs are NOT bindings

If you're calling the API directly with `asset-xxxx-yyyy` style IDs, the
model does NOT map asset IDs to characters by itself.

❌ Hoping the model figures it out:
```
text: "Li Wu sits, Su Yinxi enters."
images: [asset-001 (Li Wu), asset-002 (Su Yinxi)]
```

✅ Explicit mapping:
```
text: "Image 1 is Li Wu. Image 2 is Su Yinxi. @image1 sits, @image2 enters."
images: [asset-001, asset-002]
```

---

## Iron rule #4: Don't 9-grid

If you have a character with multiple poses, **pass each pose as a
separate image**. Do NOT make a 9-grid collage and expect the model to
parse it. 9-grid character sheets also reliably trigger content moderation.

---

## Prompt skeleton

```
{Vertical|Horizontal} video {ratio}. Overall audio atmosphere: {description} — match energy of @audio1.

[0-Xs] @image1 = {role description if helpful}. @image2 = {scene description if helpful}. {Shot type}. {Verbs involving @image1 in @image2}. {Camera move}. Sound: {sfx}.

[X-Ys] @image1 {action} in @image3 = {new scene}. {Camera follows the cut style of @video1}. Sound: ...

[Y-Zs] Cut to extreme close-up of @image4 = {product / detail}. {Final beat}. Sound: ...

Shot on {named camera}. {Style}. Follow the pacing of @video1, BGM energy of @audio1.
{3-5 specific negatives}.
```

---

## What `ref_video` transfers (and what it doesn't)

| Transfers | Does NOT transfer |
|---|---|
| Camera motion style (handheld vs locked vs gimbal) | Specific subjects or identities |
| Edit pacing (fast jump cut vs long take) | Dialogue or overlay text |
| Color grading mood | Specific scene content |
| Jump-cut timing | Brand / logo |

So: use `@video1` for **style transfer**, not for content copy.

---

## Hard limits

| Item | Value |
|---|---|
| Max images | 9 |
| Max reference videos | 3 |
| Total reference video duration | ≤ 15s |
| Max reference audios | 3 |
| Total reference audio duration | ≤ 15s |
| Ref video size | ≤ 50MB each |
| Ref audio size | ≤ 15MB each |
| Video format | mp4, mov |
| Video resolution | 480p / 720p |
| Video FPS | [24, 60] |

If your reference video is >15s, trim it:
```
ffmpeg -ss 0 -t 15 -i source.mp4 -c copy ref.mp4
```

---

## First-time compliance gate

Some clients flag R2V as a "high content-safety risk model" and require a
one-time agreement signature on the web client before API/CLI calls work.
Error: `AigcComplianceConfirmationRequired (ret=4010)`.

Fix: go to https://jimeng.jianying.com or https://dreamina.capcut.com, run
any multimodal generation once, accept the agreement, then return.

---

## Worked example — "Pet vlog clone"

Goal: clone a Tiktok pet vlog (cat in a pink harness goes outside,
product showcase at the end).

Assets prepped:
- `@image1` — anchor frame of the cat (silver shaded British Shorthair,
  pink mesh harness)
- `@image2` — indoor scene (wood floor + white door)
- `@image3` — outdoor scene (street + cow statues + flowers)
- `@image4` — product close-up (pink mesh harness detail)
- `@video1` — first 15s of the reference TikTok (transfers cut pacing)
- `@audio1` — first 15s of the audio (transfers BGM energy)

```
Vertical video 9:16. Overall audio atmosphere: cheerful kawaii synth at 115 BPM with marimba and pizzicato, fast bouncy female voiceover, occasional 'boop' percussion — match the energy and instrumentation of @audio1.

[0-5s] @image1 = white British Shorthair silver shaded with light blue eyes, wearing a pink mesh harness. @image2 = indoor scene (light wood-grain floor, white door frame, warm window light). Close-up handheld shot. Two human hands carefully slip @image1's front legs into the pink mesh harness, click the black plastic buckle, attach the silver metal D-ring leash clip. @image1 sits patient on the wooden floor, slight tail flick. Sound: gentle fabric rustle, soft plastic click, marimba opens.

[5-11s] @image1 wears the same pink mesh harness, now in @image3 = outdoor scene (gray sidewalk, red brick planter, black-and-white cow statues, yellow wildflowers, european-style buildings in the distance). Medium handheld follow shot, low-angle, walking pace. @image1 trots forward, stops, looks up curiously at the cow statues, then steps sideways onto sun-warm path. Camera follows from waist height. Sound: pizzicato bounces, ambient street air, soft paw steps.

[11-15s] Cut to extreme close-up of @image4 = pink mesh harness held in a hand, fingers gently tilt the fabric to show breathable grid texture and reflective trim. Very shallow depth of field, blurred green leaves behind. Locked handheld wobble. Sound: marimba lifts into final note, voiceover settles.

Shot on iPhone 15 Pro. Natural color, slight handheld bobbing, warm color grading with boosted reds and greens, documentary UGC realism. Follow the cut pacing and tracking style of @video1, BGM energy of @audio1.

Constraints: face stable, no distortion, body proportions natural, motion fluid, no plastic skin, no oversaturated colors beyond reference, no on-screen text, no subtitles.
```

This prompt:
- Re-binds `@image1` in every segment (rule #1)
- Calls out role of each asset early
- One camera move per segment
- Asks `@video1` for pacing transfer explicitly
- 5 specific negatives
- ~1100 chars (sweet spot for 15s)

Expected fidelity (based on field tests):
- Vibe / color grading: 90%
- Cut pacing: 85%
- Cat breed match: 85% (but not the *specific* cat)
- Outdoor scene props: 70%
- Original BGM melody: 5% (only style transfers, not the actual track)
