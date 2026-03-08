# Envelope Format

A Quarto extension for generating print-ready envelope PDFs programmatically using Typst. Supports common envelope sizes with configurable sender and recipient addresses.

## Installing

```bash
quarto use template felixmil/quarto-envelope
```

This will install the extension and create an example `template.qmd` file you can use as a starting point.

## Using

Set the format to `envelope-typst` in your document's YAML front matter and provide the sender and recipient addresses as arrays:

```yaml
---
format:
  envelope-typst:
    envelope_type: "C6"
sender:
  - "John Doe"
  - "123 Main Street"
  - "Springfield, IL 62701"
recipient:
  - "Jane Doe"
  - "456 Elm Street"
  - "Springfield, IL 62702"
---
```

Then render with:

```bash
quarto render template.qmd
```

## Options

`sender` and `recipient` are top-level metadata keys (not under `format:`):

| Key | Description |
|---|---|
| `sender` | Sender address lines (array) |
| `recipient` | Recipient address lines (array) |

Format options go under `format: envelope-typst:`:

| Option | Description | Default |
|---|---|---|
| `envelope_type` | Envelope size (see supported types below) | `"DL"` |
| `sender-fontsize` | Font size for the sender address | `11pt` |
| `recipient-fontsize` | Font size for the recipient address | `14pt` |
| `sender-width` | Width of the sender block | `30%` |
| `recipient-width` | Width of the recipient block | `40%` |
| `recipient-shift-x` | Horizontal offset for the recipient block | `-10%` |
| `recipient-shift-y` | Vertical offset for the recipient block | `10%` |


## Supported Envelope Types

You can specify `envelope_type` as a named size string or as a custom `[height, width]` array in millimeters.

### Named sizes

| Type | Dimensions (H × W) | Notes |
|---|---|---|
| `C4` | 229 × 324 mm | |
| `C5` | 162 × 229 mm | |
| `C6` | 114 × 162 mm | |
| `DL` | 110 × 220 mm | Default |
| `B4` | 250 × 353 mm | |
| `B5` | 176 × 250 mm | |
| `#10` | 105 × 241 mm | US #10 |
| `#9` | 98 × 225 mm | US #9 |
| `Monarch` | 98 × 190 mm | |
| `A2` | 111 × 146 mm | |

### Custom size

Pass a two-element array `[height, width]` in mm:

```yaml
format:
  envelope-typst:
    envelope_type:
      - 125
      - 185
```


## Batch Rendering

To generate one envelope PDF per recipient from a CSV file, use the included `render_envelopes.R` script. It renders `template-batch.qmd` — a minimal template with no hardcoded addresses — injecting sender and recipient data at render time via `--metadata-file`.

### CSV format

Create a CSV file with the following columns:

```csv
first_name,last_name,adresse,city,zip
Jean,Dupont,12 rue de la Paix,Paris,75001
Marie,Martin,45 avenue des Fleurs,Lyon,69002
```

A sample file is provided at `data/recipients.csv`.

### Running the script

Edit the `sender` variable at the top of `render_envelopes.R`, then run:

```r
source("render_envelopes.R")
```

Or from the terminal:

```bash
Rscript render_envelopes.R
```

One PDF per recipient will be written to `output/`, named `envelope_<first>_<last>.pdf`.

### How it works

The script writes a temporary YAML file for each recipient containing the sender and recipient address arrays, then calls:

```bash
quarto render template-batch.qmd --output <name>.pdf --metadata-file <tmp>.yaml
```

> **Note:** `sender` and `recipient` must not be defined in the front matter of `template-batch.qmd`, as document front matter takes precedence over `--metadata-file`.
