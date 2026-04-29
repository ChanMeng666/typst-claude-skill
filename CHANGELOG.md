# Changelog

All notable changes to this project will be documented in this file. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
