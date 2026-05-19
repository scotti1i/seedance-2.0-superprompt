# Contributing

Thanks for wanting to help — this skill gets stronger every time someone
contributes a new template, lint rule, or fixes a bad pattern.

## Three ways to contribute

### 1. Add a template (highest leverage)

Each template = one viral video scenario others can reuse.

1. Copy `seedance/templates/TEMPLATE.md` as a starting point
2. Fill in the YAML front matter
3. Write the engineered prompt following `seedance/methodology.md`
4. **Verify it works** by running the prompt on at least one Seedance client
   (jimeng.jianying.com, dreamina.capcut.com, BytePlus, Volcengine API, etc.)
5. Note the verified date, model variant, and observed success rate
6. (Optional) Link to a demo video — boosts trust massively
7. Open a PR with title `template: <scenario name>`

### 2. Add or fix a lint rule

If you've discovered an anti-pattern that hurts Seedance output:

1. Add a rule to `seedance/lint-rules.md` following the existing format
2. Include: rule ID, detection pattern, why it's bad, how to fix
3. Cite a source if possible (official docs, your own test, community report)
4. Open a PR with title `lint: <rule ID> - <brief description>`

### 3. Improve methodology / mode handbooks

Found a better way to write camera moves? A new failure mode? An updated
official guideline?

1. Edit the relevant file under `seedance/`
2. Add `Last verified: YYYY-MM` date stamp at the bottom
3. Open a PR with title `docs: <what changed>`

## PR checklist

- [ ] No personal file paths (no `~/Documents/...`, `~/Vault/...`)
- [ ] No CLI-specific code (the skill stays prompt-only)
- [ ] Examples include the verification date and Seedance version
- [ ] No emojis in code or front matter (UX choice — keep things grep-able)
- [ ] Markdown lints cleanly

## Style

- **Engineered prompts go in fenced code blocks** — no narrative formatting
- **Why before what** — explain the reasoning, not just the rule
- **One claim, one source** — if you cite official Bytedance docs, link them
- **Chinese OR English** content is fine; tags stay lowercase English

## Reporting bad outputs

Found a case where a "good" template produces a bad video? File an issue
with:
- Which template you used
- Which client / model / version
- The actual output (screenshot or video link)
- What you expected

We use this to update the verified success rates and warn users about
edge cases.
