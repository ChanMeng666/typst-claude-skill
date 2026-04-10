# Typst CLI Reference (v0.14.2)

Complete reference for the Typst command-line interface.

## Global Options

| Option | Env Variable | Description |
|--------|-------------|-------------|
| `--color <auto\|always\|never>` | — | Color output control |
| `--cert <PATH>` | `TYPST_CERT` | Custom CA certificate for network requests |

---

## `typst compile` (alias: `c`)

Compile a `.typ` file into PDF, PNG, SVG, or HTML.

```bash
typst compile [OPTIONS] <INPUT> [OUTPUT]
```

- `<INPUT>` — Path to `.typ` file. Use `-` for stdin.
- `[OUTPUT]` — Output path. Use `-` for stdout. For multi-page PNG/SVG, use `{p}` (page number), `{0p}` (zero-padded), `{t}` (total pages).

### Options

| Option | Env Variable | Description |
|--------|-------------|-------------|
| `-f, --format <FORMAT>` | — | Output format: `pdf`, `png`, `svg`, `html` |
| `--root <DIR>` | `TYPST_ROOT` | Project root for absolute paths |
| `--input <key=value>` | — | Key-value pairs accessible via `sys.inputs` |
| `--font-path <DIR>` | `TYPST_FONT_PATHS` | Additional font directories |
| `--ignore-system-fonts` | `TYPST_IGNORE_SYSTEM_FONTS` | Skip system fonts |
| `--ignore-embedded-fonts` | `TYPST_IGNORE_EMBEDDED_FONTS` | Skip Typst's bundled fonts |
| `--package-path <DIR>` | `TYPST_PACKAGE_PATH` | Custom local packages path |
| `--package-cache-path <DIR>` | `TYPST_PACKAGE_CACHE_PATH` | Custom package cache path |
| `--creation-timestamp <UNIX>` | `SOURCE_DATE_EPOCH` | Document creation date (UNIX timestamp) |
| `--pages <PAGES>` | — | Pages to export: `1,3-6,8-` |
| `--pdf-standard <STD>` | — | PDF standard conformance (see below) |
| `--no-pdf-tags` | — | Disable tagged PDF for smaller file size |
| `--ppi <PPI>` | — | PNG resolution (default: 144) |
| `--deps <PATH>` | — | Write compilation dependencies |
| `--deps-format <FMT>` | — | Dependencies format: `json`, `zero`, `make` |
| `-j, --jobs <N>` | — | Parallel compilation jobs |
| `--features <FEAT>` | `TYPST_FEATURES` | Enable experimental features: `html`, `a11y-extras` |
| `--diagnostic-format <FMT>` | — | Diagnostic format: `human`, `short` |
| `--open [VIEWER]` | — | Open output after compilation |
| `--timings [PATH]` | — | Export performance timings as JSON |

### PDF Standards

Supports: `1.4`, `1.5`, `1.6`, `1.7`, `2.0`, `a-1b`, `a-1a`, `a-2b`, `a-2u`, `a-2a`, `a-3b`, `a-3u`, `a-3a`, `a-4`, `a-4f`, `a-4e`, `ua-1`

### Examples

```bash
# Basic PDF compilation
typst compile paper.typ

# High-resolution PNG export
typst compile paper.typ paper.png --ppi 300

# Export specific pages
typst compile paper.typ --pages 1,3-5

# PDF/A-2b compliance
typst compile paper.typ --pdf-standard a-2b

# Multi-page PNG with zero-padded names
typst compile paper.typ "page-{0p}-of-{t}.png"

# Compile with custom inputs
typst compile paper.typ --input version=1.0 --input draft=true

# Compile and open
typst compile paper.typ --open

# Compile from stdin to stdout
cat paper.typ | typst compile - -f pdf - > output.pdf
```

---

## `typst watch` (alias: `w`)

Watch a file and recompile on changes. Supports all `compile` options plus:

```bash
typst watch [OPTIONS] <INPUT> [OUTPUT]
```

### Additional watch-specific options

| Option | Description |
|--------|-------------|
| `--no-serve` | Disable built-in HTTP server (HTML export) |
| `--no-reload` | Disable live reload script injection (HTML) |
| `--port <PORT>` | HTTP server port (default: 3000-3005) |

### Examples

```bash
# Watch and auto-recompile
typst watch paper.typ

# Watch with live HTML preview
typst watch paper.typ output.html --features html

# Watch with HTTP server and auto-open browser
typst watch paper.typ --open
```

---

## `typst eval`

Evaluate a Typst expression and print the result.

```bash
typst eval [OPTIONS] <INPUT>
```

- `<INPUT>` — Expression string or path to `.typ` file.

| Option | Description |
|--------|-------------|
| `--format <json\|yaml>` | Output format |
| `--pretty` | Pretty-print output |
| `--mode <code\|markup\|math>` | Expression mode (default: code) |

Plus all shared compilation options (`--root`, `--input`, `--font-path`, etc.)

### Examples

```bash
# Evaluate an expression
typst eval "1 + 2"

# Evaluate markup
typst eval --mode markup "= Hello"

# Evaluate from a file
typst eval expressions.typ

# Pretty-print JSON output
typst eval --pretty --format json "range(5)"
```

---

## `typst init`

Initialize a new project from a template.

```bash
typst init [OPTIONS] <TEMPLATE> [DIR]
```

- `<TEMPLATE>` — Template name, e.g. `@preview/charged-ieee`. Append `:version` for specific version.
- `[DIR]` — Project directory (defaults to template name).

### Options

| Option | Env Variable | Description |
|--------|-------------|-------------|
| `--package-path <DIR>` | `TYPST_PACKAGE_PATH` | Custom local packages path |
| `--package-cache-path <DIR>` | `TYPST_PACKAGE_CACHE_PATH` | Custom package cache path |

### Examples

```bash
# Initialize IEEE paper
typst init @preview/charged-ieee my-paper

# Initialize with specific version
typst init @preview/modern-cv:0.7.0 my-resume
```

---

## `typst query`

Extract metadata from a document as JSON or YAML.

```bash
typst query [OPTIONS] <INPUT> <SELECTOR>
```

- `<SELECTOR>` — Element selector (e.g., `"<my-label>"`, `heading`)

### Options

| Option | Description |
|--------|-------------|
| `--field <FIELD>` | Extract a specific field from elements |
| `--one` | Expect exactly one result |
| `--format <json\|yaml>` | Output format (default: json) |
| `--pretty` | Pretty-print JSON output |
| `--target <paged\|html>` | Compilation target (default: paged) |

Plus all shared compilation options (`--root`, `--input`, `--font-path`, etc.)

### Examples

```bash
# Query all headings
typst query paper.typ heading

# Query a specific labeled element
typst query paper.typ "<abstract>" --one --pretty

# Extract title field from metadata
typst query paper.typ "metadata" --field value --one
```

---

## `typst packages`

List installed packages and manage the package cache.

```bash
typst packages list [OPTIONS]
typst packages clean [OPTIONS]
```

| Option | Description |
|--------|-------------|
| `--package-path <DIR>` | Custom local packages path |
| `--package-cache-path <DIR>` | Custom package cache path |

### Examples

```bash
# List all installed packages
typst packages list

# Clean the package cache
typst packages clean
```

---

## `typst fonts`

List all discovered fonts.

```bash
typst fonts [OPTIONS]
```

| Option | Env Variable | Description |
|--------|-------------|-------------|
| `--font-path <DIR>` | `TYPST_FONT_PATHS` | Additional font directories |
| `--ignore-system-fonts` | `TYPST_IGNORE_SYSTEM_FONTS` | Skip system fonts |
| `--ignore-embedded-fonts` | `TYPST_IGNORE_EMBEDDED_FONTS` | Skip bundled fonts |
| `--variants` | — | List style variants of each font family |

### Examples

```bash
# List all available fonts
typst fonts

# List fonts with variants
typst fonts --variants

# List only custom fonts
typst fonts --font-path ./fonts --ignore-system-fonts
```

---

## `typst update`

Self-update the Typst CLI.

```bash
typst update [OPTIONS] [VERSION]
```

---

## `typst completions`

Generate shell completion scripts.

```bash
typst completions <SHELL>
```

Supported shells: `bash`, `elvish`, `fish`, `powershell`, `zsh`

---

## `typst info`

Display debugging information about the Typst environment.

```bash
typst info
```

---

## Package Publishing

To publish a Typst package/template, create a `typst.toml` manifest:

```toml
[package]
name = "my-template"
version = "0.1.0"
entrypoint = "package.typ"
authors = ["Your Name <you@example.com>"]
license = "MIT"
description = "A beautiful document template"
repository = "https://github.com/user/my-template"
keywords = ["template", "resume", "report"]
minimum-typst-version = "0.14.0"

[template]
path = "template"
entrypoint = "main.typ"
thumbnail = "images/thumbnail.png"
```

### Package structure

```
my-template/
├── typst.toml          # Package manifest
├── package.typ         # Library entry point (exported functions)
├── template/
│   └── main.typ        # Template entry point for `typst init`
├── fonts/              # Bundled fonts (optional)
├── images/             # Icons, thumbnails
└── README.md
```

### Using published packages

```bash
# Initialize a project from a template
typst init @preview/my-template:0.1.0 my-project

# Import in a .typ file
#import "@preview/my-template:0.1.0": *
```

### Custom font bundling

Bundle fonts in the package and use `--font-path` at compile time:

```bash
typst compile --font-path ./fonts document.typ
```

---

## Environment Variables Summary

| Variable | Description |
|----------|-------------|
| `TYPST_ROOT` | Project root directory |
| `TYPST_FONT_PATHS` | Additional font search directories |
| `TYPST_IGNORE_SYSTEM_FONTS` | Skip system fonts |
| `TYPST_IGNORE_EMBEDDED_FONTS` | Skip bundled fonts |
| `TYPST_PACKAGE_PATH` | Local packages directory |
| `TYPST_PACKAGE_CACHE_PATH` | Package cache directory |
| `TYPST_CERT` | Custom CA certificate path |
| `TYPST_FEATURES` | Enable experimental features |
| `SOURCE_DATE_EPOCH` | Document creation timestamp (reproducible builds) |
