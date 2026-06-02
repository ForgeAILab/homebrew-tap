# typed: false
# frozen_string_literal: true

# Homebrew formula for Forge — the local-first workflow engine for coding agents.
# Source repo: https://github.com/ForgeAILab/forge
#
# After cutting a new release on the source repo, run
# `scripts/update-checksums.sh <version>` from the tap root. The script updates
# the release URLs and rewrites the four `sha256` lines from the release
# SHA256SUMS file.
class Forge < Formula
  desc "Local-first workflow engine for coding agents"
  homepage "https://github.com/ForgeAILab/forge"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.6/forge-aarch64-macos.tar.gz"
      sha256 "88ecc2a46211d8549813820c6d1572b4dd4bdd81eb77d0ebc2c3a52443b4ff4a"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.6/forge-x86_64-macos.tar.gz"
      sha256 "809c68de655fec71cca2bb1057ae75efa7ee222aaadc55a5bc94b920f448dd33"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.6/forge-aarch64-linux.tar.gz"
      sha256 "12ee2badb6f2f3dc20dfe9be6f41f3b1aa73313783f11edc394e8b37acb2acc5"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.6/forge-x86_64-linux.tar.gz"
      sha256 "60aa65131878d87a0090ad88ce5632f53a72346f359d1e6f6b8e9260c162378a"
    end
  end

  def install
    bin.install "forge"
    bin.install "forge-ctl"
    pkgshare.install "web" if Dir.exist?("web")
  end

  def caveats
    <<~EOS
      Forge starts on a loopback port and stores data under ~/.forge/.
      To launch with seeded demo data:
        forge --demo
      Then open the management_url printed in the logs.
    EOS
  end

  test do
    assert_match "Usage: forge", shell_output("#{bin}/forge --help")
    assert_match "Forge CLI client", shell_output("#{bin}/forge-ctl --help")
  end
end
