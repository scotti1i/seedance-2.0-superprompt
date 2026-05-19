# Decision Tree: Content Moderation Safe Zone

> **Iron rule**: face OR legs visible, never both.

When you provide character reference images, Seedance applies content
moderation. Certain image compositions are blocked 100% of the time.

---

## Quick test

For your character reference image:

```
Is the face recognizable AND the body visible from > ¾ down?
│
├─ YES → BLOCKED (will reject 100%)
│        Fix: crop tighter (headshot or half-body), or use back/side angle
│
└─ NO → Safe
```

---

## Safe compositions

| Composition | Status |
|---|---|
| Headshot (shoulders up) | ✅ Pass |
| Half-body (waist up) | ✅ Pass |
| Back-view full body | ✅ Pass |
| Side-profile full body | ✅ Pass |
| Distant figure (<20% of frame) | ✅ Pass |
| Cartoon / illustrated character | ✅ Pass |
| Product-only (no person) | ✅ Pass |

---

## Blocked compositions

| Composition | Status | Why |
|---|---|---|
| Full body + recognizable face | ❌ Block | Risk profile |
| ¾ body + recognizable face | ❌ Block | Risk profile |
| Selfie with bystanders in background | ❌ Block | Multi-face |
| Group photo (≥ 2 faces) | ❌ Block | Multi-face |
| 9-grid character sheet (multiple angles) | ❌ Block | Multi-face + risk |
| Image with text near face | ⚠️ Sometimes block | OCR triggers |

---

## Error codes

| Code | Meaning |
|---|---|
| `CONTENT_MODERATION` | Review-layer rejection (Seedance moderation) |
| `VG_E000` | Model-layer refusal (no specific reason returned) |
| `OutputAudioSensitiveContentDetected` | Audio review triggered |
| `AigcComplianceConfirmationRequired (ret=4010)` | First-time R2V use; sign agreement on web client |

---

## Fix recipes

### "My character image is full-body, what now?"

1. **Crop to half-body** (waist-up) in any image editor — usually solves it
2. **Use back / side angle** instead of frontal
3. **Use a separate headshot** as `@image1` + a separate full-body
   silhouette as `@image2` (split anatomy across two safe images)

### "My image has multiple people"

1. **Crop to single person**
2. **Blur or mask bystander faces** before upload
3. **Take a different reference photo**

### "It got rejected and I don't know why"

The error code is your first clue:
- `CONTENT_MODERATION` → re-examine your image's face/body composition
- `VG_E000` → could be anything (model layer is opaque). Try: simplify
  prompt, swap image, retry
- `AigcComplianceConfirmationRequired` → go to web client, accept terms

---

## Pre-upload checklist

Before passing character images to Seedance:

- [ ] Single recognizable face (no group)
- [ ] Body shown ≤ half-body OR face not visible (one of these)
- [ ] No text overlay on the image
- [ ] No 9-grid character sheet
- [ ] No watermarks or logos in unrelated regions
- [ ] No NSFW elements (will be blocked harder than face+body)

---

## When in doubt

**Cartoon / illustration of your character** bypasses most rules. If you're
working on a story with sensitive faces, generate an illustrated version
first (Stable Diffusion / DALL-E / Midjourney), use that as `@image1`.

---

## See also

- `../methodology.md` § 12 (Content moderation safe zone)
