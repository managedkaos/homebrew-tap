class Browsers < Formula
  desc "Tools for working with web browsers on macOS"
  homepage "https://github.com/managedkaos/browser-tools"
  # The tap's update workflow rewrites the release tag in `url` and `sha256` on
  # each release (see the tap's scripts/update_formula.py). The asset name has no
  # version in it; Homebrew reads the version from the tag in the URL path.
  url "https://github.com/managedkaos/browser-tools/releases/download/v2026.10.22/browsers-macos-universal.tar.gz"
  sha256 "2f3a9f327fe6df381d5db51fbe35b4898bcf493f7f4d29f7c62a1aa809d21007"
  license "MIT"

  depends_on macos: :sonoma

  def install
    bin.install "browsers"
    generate_completions_from_executable(bin/"browsers", "--generate-completion-script")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/browsers --version")
    assert_match "name", shell_output("#{bin}/browsers list --json")
  end
end
