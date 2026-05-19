# Frames — First-and-Last-Frame Mode

Specify the opening frame and the closing frame; let the model interpolate
the motion between them.

`role_mode = frame` in API calls.

---

## When to use

- You have a precise idea of how the shot should open AND close
- You want a controlled reveal (start with a wide shot, end on a close-up)
- You want to build suspense by locking the final frame ("it ends with her
  looking up at the sky")
- Series shorts where every episode opens with the same look

## When NOT to use

- You don't have a specific end frame in mind (use I2V or T2V)
- You want to chain reference video / audio (Frames mode is **mutually
  exclusive** with `ref_video` / `ref_audio` — passing them returns 422)
- You want multiple anchored subjects (use R2V)

---

## Iron rule: NO ref_video / ref_audio in Frames mode

`role_mode=frame` cannot coexist with `ref_video` or `ref_audio`. The API
returns 422.

If you want pacing transfer AND a locked end frame, choose one:
1. Frames mode + locked end frame, no pacing reference
2. R2V mode + ref_video for pacing, with `@image_last` as a soft anchor
   (less precise than `frame` mode but allows audio/video refs)

---

## Prompt skeleton

```
{Motion description: how the scene evolves from frame A to frame B}. {Single camera move that justifies the transition}. {Lighting / mood consistency}.

Sound: {sfx}.

Shot on {named camera}. {3-5 specific negatives}.
```

The image inputs themselves carry the spatial information — don't
re-describe what's already in the frames.

---

## Worked examples

### Example 1 — Reveal shot

Inputs:
- `@frame_first` — wide shot of an empty street
- `@frame_last` — close-up of a single figure at the end of the street

```
The camera slowly tracks forward along the empty street, gradually revealing the figure standing at the far end. Dust catches the morning light. Subtle handheld bob. Sound: distant wind, slow piano builds. Shot on ARRI Alexa, anamorphic lens flare, slight film grain. No distortion, no exposure jump, no motion smear.
```

### Example 2 — Mood transition

Inputs:
- `@frame_first` — character looking out a window, daylight
- `@frame_last` — same character, head down, room darker

```
Light gradually fades from warm afternoon to soft dusk. The character lowers her head slowly, breath visible in the cooling air. Locked-off camera, just the light shifting. Sound: ambient room tone, distant clock ticking, no music. Shot on Sony A7S3, natural skin tone. No flicker, no plastic skin, no abrupt light jump.
```

### Example 3 — Series opener

Use the same `@frame_first` for every episode of a short series — the
opening frame becomes the brand. Each episode's `@frame_last` differs.

```
Opening frame establishes the location. The camera holds for the first second, then performs a single slow push-in as the title region (top third) clears. End on a tight composition framing the protagonist's eyes. Sound: signature sting. Shot on RED Komodo, sharp contrast. No on-screen text yet (added in post).
```

---

## Best practices

1. **Frame pair should suggest a natural transition** — wide to close,
   light to dark, empty to populated. Random pairs produce confused output.
2. **Keep the prompt focused on the BECOMING** — not the start, not the
   end, but how it changes
3. **Lighting consistency or deliberate shift** — declare which one
4. **Pick one camera move** that justifies the visual change
5. **Strong negatives against flicker** — Frames mode is more prone to
   flicker artifacts than R2V

---

## Limitations

- Cannot use ref_video / ref_audio (mutually exclusive)
- Cannot use more than 2 frame inputs (start + end only)
- Output duration: 4-15s (longer = more interpolation artifacts)
- Works best at 5-8s
