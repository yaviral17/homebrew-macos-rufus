class MacosRufus < Formula
  desc "Rufus for macOS — create bootable Windows 7/8/10/11 USB drives from your Mac"
  homepage "https://github.com/yaviral17/macos-rufus"
  url "https://github.com/yaviral17/macos-rufus/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a36a591f8bf2b01e905007dda3b25cdbe6564d3df6dadf77948cd16f04fa2f86"
  license "MIT"

  depends_on "python@3.12"
  depends_on "wimlib"

  def install
    venv = libexec/"venv"
    system "python3", "-m", "venv", venv
    system "#{venv}/bin/pip", "install", "--quiet", "rich"
    libexec.install "rufus.py"

    (bin/"macos-rufus").write <<~SH
      #!/bin/bash
      exec "#{libexec}/venv/bin/python3" "#{libexec}/rufus.py" "$@"
    SH
  end

  test do
    assert_predicate bin/"macos-rufus", :exist?
  end
end
