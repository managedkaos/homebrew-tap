class Rehab < Formula
  desc "Rename files and directories to replace problematic characters, with undo"
  homepage "https://github.com/managedkaos/rehab"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.0/rehab-darwin-arm64.tar.gz"
      sha256 "bc61d504e6354d28789b5607fbc71c5fbb66c158e09f7915537a82d0d0aa0b9f"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.0/rehab-darwin-amd64.tar.gz"
      sha256 "3eac69edae6296f9f12b5be8a07b84752f63ccce1eb5f8466668d0c069838358"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.0/rehab-linux-arm64.tar.gz"
      sha256 "779c583e021382960e34f1c157f416d8b8bb4c99f525c7335fb28817e66f588a"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.0/rehab-linux-amd64.tar.gz"
      sha256 "05ab5ea94baa59ac91904797b528b439c79b0311bb9fee15262b4055f358ead0"
    end
  end

  def install
    bin.install "rehab"

    man1.install "man/rehab.1"
    man5.install "man/rehab-config.5"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rehab --version")

    (testpath/"bad name.txt").write "x"
    system bin/"rehab", testpath/"bad name.txt"
    assert_path_exists testpath/"bad_name.txt"
    refute_path_exists testpath/"bad name.txt"
  end
end
