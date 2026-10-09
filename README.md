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

## Automated updates

Each tool's release workflow calls the reusable
[`update-formula.yml`](.github/workflows/update-formula.yml) workflow, which
reads the release's `checksums.txt`, rewrites `Formula/<tool>.rb` with
[`scripts/update_formula.py`](scripts/update_formula.py), and opens a pull
request against this repo using a GitHub App token.

To enable it for a tool, add this job to its release workflow (after the job
that publishes the release) and set the `TAP_APP_ID` and `TAP_APP_PRIVATE_KEY`
secrets on the tool's repo:

```yaml
  update-tap:
    needs: release
    permissions:
      contents: read
    uses: managedkaos/homebrew-tap/.github/workflows/update-formula.yml@main
    with:
      formula: <tool>
      tag: ${{ github.ref_name }}
    secrets:
      TAP_APP_ID: ${{ secrets.TAP_APP_ID }}
      TAP_APP_PRIVATE_KEY: ${{ secrets.TAP_APP_PRIVATE_KEY }}
```
