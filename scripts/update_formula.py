#!/usr/bin/env python3
"""Update a binary-release Homebrew formula for a new release tag.

Rewrites `version`, the release tag inside every `url`, and each `sha256`
(looked up by the url's asset filename in a checksums file).

Usage: update_formula.py FORMULA TAG CHECKSUMS_FILE
  e.g. update_formula.py Formula/rehab.rb v0.1.1 checksums.txt

CHECKSUMS_FILE uses `sha256sum` format: "<hash>  <filename>" per line.
"""
import re
import sys
from pathlib import Path

URL_RE = re.compile(r'^(\s*url\s+")(?P<base>[^"]*/download/)(?P<tag>[^/"]+)/(?P<asset>[^/"]+)(")\s*$')
SHA_RE = re.compile(r'^(\s*sha256\s+")([0-9a-f]{64})(")\s*$')
VERSION_RE = re.compile(r'^(\s*version\s+")([^"]*)(")\s*$')


def load_checksums(path):
    sums = {}
    for line in Path(path).read_text().splitlines():
        parts = line.split()
        if len(parts) == 2:
            sums[parts[1].lstrip("*")] = parts[0]
    return sums


def main(formula, tag, checksums_file):
    version = tag[1:] if tag.startswith("v") else tag
    sums = load_checksums(checksums_file)
    lines = Path(formula).read_text().splitlines(keepends=True)
    out, pending_asset, urls, has_version = [], None, 0, False

    for line in lines:
        body = line.rstrip("\n")
        if m := VERSION_RE.match(body):
            has_version = True
            line = f'{m[1]}{version}{m[3]}\n'
        elif m := URL_RE.match(body):
            urls += 1
            pending_asset = m["asset"]
            # Asset names may embed the version (e.g. foo-1.2.3-darwin.tar.gz).
            asset = pending_asset
            line = f'{m[1]}{m["base"]}{tag}/{asset}"\n'
        elif m := SHA_RE.match(body):
            if pending_asset is None:
                sys.exit("sha256 found without a preceding url")
            if pending_asset not in sums:
                sys.exit(f"no checksum for {pending_asset} in {checksums_file}")
            line = f'{m[1]}{sums[pending_asset]}{m[3]}\n'
            pending_asset = None
        out.append(line)

    if urls == 0:
        sys.exit("no download urls found in formula")
    if pending_asset is not None:
        sys.exit(f"url for {pending_asset} has no sha256")

    if not has_version:
        print("note: formula has no explicit version line", file=sys.stderr)
    Path(formula).write_text("".join(out))
    print(f"updated {formula} to {version} ({urls} urls)")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    main(*sys.argv[1:])
