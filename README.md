# homebrew-tap

A [Homebrew](https://brew.sh) tap for command-line tools by [managedkaos](https://github.com/managedkaos).

## Usage

```bash
brew tap managedkaos/tap
brew install <tool>
```

Or install directly without tapping first:

```bash
brew install managedkaos/tap/<tool>
```

## Tools on tap

| Tool | Description | Install |
| ---- | ----------- | ------- |
| [recall](https://github.com/managedkaos/recall) | Store, retrieve, and search markdown-formatted reference files | `brew install managedkaos/tap/recall` |
| [rehab](https://github.com/managedkaos/rehab) | Rename files and directories to replace problematic characters, with undo | `brew install managedkaos/tap/rehab` |

## Development

With Ruby and Homebrew installed, run `make lint` to check the syntax and Homebrew style of all files in `./Formula`.
