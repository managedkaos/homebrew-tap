class Recall < Formula
  desc "Store, retrieve, and search markdown-formatted reference files"
  homepage "https://github.com/managedkaos/recall"
  # Release tags are date-based (e.g. v2026.10.04); GoReleaser strips the
  # leading "v" for the version embedded in the binary. Set it explicitly
  # because it cannot be reliably parsed from the download URL.
  version "2026.10.04"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/managedkaos/recall/releases/download/v2026.10.04/recall-darwin-arm64.tar.gz"
      sha256 "d9f7a94acab1fb736829ee3db5cde4982d1a3e32e45d55754473db77b261331d"
    end
    on_intel do
      url "https://github.com/managedkaos/recall/releases/download/v2026.10.04/recall-darwin-amd64.tar.gz"
      sha256 "388b171e06e9eaa32fe0df71566c3b1d21372206b62cc36b5ba7cb397367bc11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/managedkaos/recall/releases/download/v2026.10.04/recall-linux-arm64.tar.gz"
      sha256 "2dd29d0b1ea11129e51f032647aa75d4af8030b7186cfbc20a51f6174926d996"
    end
    on_intel do
      url "https://github.com/managedkaos/recall/releases/download/v2026.10.04/recall-linux-amd64.tar.gz"
      sha256 "2c731ce85d094192fd9f96653e0d4ab6f8dc45fbaa34d12b37a21de2a5b78beb"
    end
  end

  def install
    bin.install "recall"

    man1.install "man/recall.1"

    generate_completions_from_executable(bin/"recall", "--completion")
  end

  test do
    assert_match "recall version #{version}", shell_output("#{bin}/recall --version")

    # Exercise real behavior against an isolated recall directory.
    ENV["RECALL_DIR"] = (testpath/"recall").to_s
    system bin/"recall", "--init"
    (testpath/"recall/note").write "# Note\n\nhomebrew-needle\n"

    assert_match "note", shell_output("#{bin}/recall --list")
    assert_match "homebrew-needle", shell_output("#{bin}/recall --search needle")
    assert_match "Note", shell_output("#{bin}/recall note")

    assert_match "_recall", shell_output("#{bin}/recall --completion zsh")
  end
end
