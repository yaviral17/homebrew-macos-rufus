class MacosRufus < Formula
  desc "Rufus for macOS — create bootable Windows and Linux USB drives"
  homepage "https://github.com/yaviral17/macos-rufus"
  url "https://github.com/yaviral17/macos-rufus/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "2c95c0fb9c1934ff171684d58c19e8e3acb4352d75a87746b7b46b4bcfa5de33"
  license "MIT"

  depends_on "python@3.12"
  depends_on "wimlib"

  def install
    venv = libexec/"venv"
    system "python3", "-m", "venv", venv
    system "#{venv}/bin/pip", "install", "--quiet", "rich", "requests", "playwright"
    libexec.install "rufus.py"

    (bin/"macos-rufus").write <<~SH
      #!/bin/bash
      exec "#{libexec}/venv/bin/python3" "#{libexec}/rufus.py" "$@"
    SH
  end

  test do
    assert_path_exists bin/"macos-rufus"
    assert_match "1.3.0", shell_output("#{bin}/macos-rufus --version")
  end
end
