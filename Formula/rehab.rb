class Rehab < Formula
  desc "Rename files and directories to replace problematic characters, with undo"
  homepage "https://github.com/managedkaos/rehab"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.1/rehab-darwin-arm64.tar.gz"
      sha256 "fae5df21b0d3ead3dc9ef83a1f458ac1a5887d232930f695bd571f01d147c76d"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.1/rehab-darwin-amd64.tar.gz"
      sha256 "efd8882be4f0498392b00ccb102bbaf69472301f05c8b8ac1bbddac706c5ab84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.1/rehab-linux-arm64.tar.gz"
      sha256 "4c4dec7400fd894fefabc6c0dcc98cd5fac96de8dd281ffec08f9560e41895ee"
    end
    on_intel do
      url "https://github.com/managedkaos/rehab/releases/download/v0.2.1/rehab-linux-amd64.tar.gz"
      sha256 "b5a4f3597f109ebb754038e49c50645107a71f9a2b9fc296a847f786f2b1e843"
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
