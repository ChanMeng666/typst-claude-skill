# Changelog

All notable changes to this project will be documented in this file. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] — 2026-04-29

### Changed (breaking for direct-clone users)
- **Repository restructured**: skill content moved from repo root into `skills/typst/`. The plugin manifest now relies on Claude Code's default skill auto-discovery (which expects `skills/<name>/SKILL.md`) instead of the previously documented but unimplemented `"skills": ["./"]` form.
- **Direct git-clone install command changed**: `git clone … ~/.claude/skills/typst` no longer puts `SKILL.md` at the right place; the canonical clone now needs `mv` after clone (or sparse-checkout). The plugin marketplace install path (`/plugin marketplace add` → `/plugin install typst@chan-typst`) is now the recommended primary route.

### Why
Live-tested the v0.2.1 plugin install on Claude Code 2.1.123: the install succeeded but the plugin failed to load with `Error: Path escapes plugin directory: ./ (skills)`. The docs at <https://code.claude.com/docs/en/plugins-reference#path-behavior-rules> document `"skills": ["./"]` as a supported pattern ("the frontmatter `name` field in `SKILL.md` determines the skill's invocation name"), but the runtime path-traversal guard in 2.1.123 rejects `./` as an escape attempt. Until that runtime issue is fixed upstream, we ship the canonical layout (`skills/<name>/SKILL.md`) that every documentation example demonstrates.

### Migration for existing direct-clone users
If you already installed v0.1.0 / 0.2.x via `git clone … ~/.claude/skills/typst`, **do NOT `git pull`** — that would replace your `SKILL.md` with the new directory layout and break the skill. Instead, re-do the install from scratch:

```bash
rm -rf ~/.claude/skills/typst
# Then follow the new Method 1 in the README (clone-and-move).
```

Or switch to the plugin marketplace path, which is now the simpler option.

## [0.2.1] — 2026-04-29

### Changed
- `examples/cjk-document.typ` font fallback chain reordered to put `SimSun` (Windows native) first, with `Microsoft YaHei`, `Source Han Serif SC`, and `Noto Serif CJK SC` as the rest of the chain. Same four fonts as before — but Windows students now see their OS's pre-installed font used as the actual rendered glyphs.
- `examples/cjk-document.typ` Chinese explanatory paragraph rewritten to clarify that `unknown font family` warnings from Typst are informational ("this font is missing, trying the next one") rather than errors; the PDF is valid as long as one name in the chain matches.

### Why
Caught during the v0.2.0 acceptance run on Windows: the original chain put `Source Han Serif SC` first, which Typst tries first, fails to find on a stock Windows install, warns, then falls back to `SimSun` and renders fine. The PDF was always correct, but a first-time student facing 2 warning lines on their first compile understandably wondered if something was broken. The reorder doesn't eliminate the warnings — Typst warns once per missing font name regardless of fallback success — but it puts the OS-native font at the head of the chain so the student's mental model ("font I have at home is the one being used") matches reality.

## [0.2.0] — 2026-04-29

### Added
- **Plugin packaging.** `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` make the skill installable via `/plugin marketplace add ChanMeng666/typst-claude-skill` and `/plugin install typst@chan-typst`, in addition to the existing `git clone ~/.claude/skills/typst` pattern.
- **Decision Tree** at the top of `SKILL.md` — Claude now picks a template (resume / letter / paper / report / slides / invoice / general) and applies CJK font setup deterministically before writing any `.typ`.
- **Recovery Recipes** table in `SKILL.md` — first-line stderr → likely cause → first action lookup, covering the five most common compile failures.
- **Trigger cheat-sheet** block-quote immediately after the H1 in `SKILL.md`, so the skill activates reliably when the user says "PDF / CV / 简历" without naming Typst.
- **Vercel / serverless gotcha** row added to the Gotchas table — calls out that the Vercel runtime ships no Typst CLI by default.
- **GitHub Actions CI** at `.github/workflows/validate.yml` — every push validates SKILL.md frontmatter, compiles every example `.typ`, and runs `verify-typst.sh`.
- **README troubleshooting** section, badges (license / Typst version / Claude Code skill / CI status), Method 2 (plugin marketplace) and Method 4 (project-level) install instructions, and a "Verify your installation" walkthrough.

### Changed
- **SKILL.md description** tightened and expanded with explicit trigger keywords (CV, résumé, cover letter, CJK, thesis, slides, invoice) and CJK examples — addresses the most common cause of the skill not firing when it should.
- **README installation** rewritten from two options to four clearly labelled methods (git clone / plugin marketplace / manual ZIP / project-level), with an explicit "pick one" framing.
- **Workflow Step 1** in `SKILL.md` now points at `scripts/verify-typst.sh` for a deeper environment check (CJK fonts, write permissions, version ≥ 0.14) on top of the bare `typst --version`.

### Why
Driven by a real student incident: a learner asked Claude Code to "install the Typst skill from the Anthropic skills registry", which doesn't exist. The plugin metadata + the four-method install story remove every step where a student might guess wrong about how to acquire this skill.

## [0.1.0] — initial release

### Added
- `SKILL.md` with progressive disclosure (workflow + quick reference, with deep references loaded on demand)
- Four reference files: `typst-cli-reference.md`, `typst-language-reference.md`, `typst-templates.md`, `typst-design-patterns.md`
- Three example `.typ` files: `hello-world.typ`, `cjk-document.typ`, `resume-basic.typ`
- `scripts/verify-typst.sh` environment checker
- README, LICENSE (MIT), `.gitignore`
