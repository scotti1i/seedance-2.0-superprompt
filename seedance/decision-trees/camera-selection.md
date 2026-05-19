# Decision Tree: Named Camera Selection

Real camera and lens names invoke the model's implicit knowledge of that
aesthetic. They beat abstract junk tokens like `cinematic` or `8k` every
time.

---

## The shortlist

| Camera | Aesthetic | Best for |
|---|---|---|
| **iPhone 15 Pro** | UGC, vertical-native, slight handheld bob, mobile-flat color | TikTok, Reels, vlogs, lifestyle, product reviews |
| **Sony A7S3** | Clean low-light, natural skin tone, mirrorless realism | Documentary, indie cinema, soft narrative, e-commerce |
| **ARRI Alexa** | Cinematic latitude, deep blacks, painterly highlights | Drama, hero shots, premium commercials |
| **RED Komodo** | Sharp, high contrast, modern digital | Action, fashion, sports, music videos |
| **35mm film** | Vintage cinematic, organic grain | Period drama, nostalgia, mood |
| **16mm film** | Grainier vintage, indie | Throwback / Wes-Anderson feel |
| **Anamorphic lens flare** | Letterbox flares, oval bokeh | Sci-fi, dramatic establishing shots |
| **GoPro Hero** | Action wide-angle, fisheye distortion | Sports, POV adventure |
| **Drone aerial** | Top-down or sweeping aerial | Establishing, scenic |

---

## Selection flow

```
What's the brand voice?
│
├─ UGC / casual / TikTok native?
│      → iPhone 15 Pro
│
├─ Documentary / realistic / clean?
│      → Sony A7S3
│
├─ Premium commercial / drama / story?
│      → ARRI Alexa
│
├─ Vintage / retro / nostalgic?
│      → 35mm film (or 16mm film)
│
├─ Action / sport / energy?
│      → RED Komodo (or GoPro Hero)
│
├─ Sci-fi / surreal / dramatic establishing?
│      → ARRI Alexa + anamorphic lens flare
│
└─ Bird's eye / scenic?
       → drone aerial
```

---

## Stacking tags

You can layer multiple style cues:

```
Shot on Sony A7S3, natural skin tone, slight film grain, documentary realism.
Shot on ARRI Alexa, 35mm film, anamorphic lens flare, deep contrast.
Shot on iPhone 15 Pro, handheld follow, natural color, TikTok-style.
```

But keep it ≤ 4 style tags. More overwhelms the camera signal.

---

## Banned alternatives (do not use)

These look professional but the model has been trained AWAY from
prioritizing them:

```
highly detailed
masterpiece
8k
4k
ultra-realistic
photorealistic
award-winning
amazing quality
breathtaking
incredible detail
stunning
cinematic (when used alone, no other context)
```

Replace each with one specific term:
- "highly detailed" → "slight film grain" / "sharp focus on subject"
- "8k" → specific camera ("Shot on Sony A7S3") + "natural color"
- "cinematic" → "ARRI Alexa" or "35mm film" or specific lighting term
- "amazing" → describe what's amazing

---

## Match the camera to the named lighting

Cameras and lighting are paired in cinema:

| Camera | Goes with |
|---|---|
| iPhone 15 Pro | Natural window light, fluorescent indoor, mobile-flat color |
| Sony A7S3 | Golden hour, tungsten warm, soft documentary light |
| ARRI Alexa | Chiaroscuro, rim light, volumetric god rays, hard key light |
| RED Komodo | Hard key light, neon, sharp shadows |
| 35mm film | Warm color grading, slight bloom, soft falloff |

Mismatched (e.g., "iPhone 15 Pro + volumetric god rays") still works but
loses the cohesion.

---

## See also

- `../methodology.md` § 5 (Camera language)
