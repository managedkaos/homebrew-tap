class Rehab < Formula
  desc "Rename files and directories to replace problematic characters, with undo"
  homepage "https://github.com/managedkaos/rehab"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.1.0/rehab-darwin-arm64.tar.gz"
      sha256 "4358bb38d7cce0e4a8407e1c2fdf605fcb8c54984c53c110e469be9d52767f67"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.1.0/rehab-darwin-amd64.tar.gz"
      sha256 "7eece8958151d4e0b92e9c623899e855dca7aa061b224641e0b85459a2c60ca6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.1.0/rehab-linux-arm64.tar.gz"
      sha256 "01b3897fdfe6bb33f6b7222ed3ad31e53f9cd4e180eefc885e5933db6e6950d3"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.1.0/rehab-linux-amd64.tar.gz"
      sha256 "cc841df826d7b932191b1dcd85e377909a43f7acb6612e4d17e78f9ee9bf31b3"
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
