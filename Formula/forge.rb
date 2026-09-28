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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.8/forge-aarch64-macos.tar.gz"
      sha256 "61899e3e2678b8df543377f730768a33fe5022a1ddb611bf3b55afc2e0d23e96"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.8/forge-x86_64-macos.tar.gz"
      sha256 "6cd84867bf8816ab657c58047ad44641ac13a546500aad680e7da47234495a5d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.8/forge-aarch64-linux.tar.gz"
      sha256 "3625bc21978cff7550be6cfa649c67adc7308440794f38a4f7d4dadce4885591"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.8/forge-x86_64-linux.tar.gz"
      sha256 "6bf049025605fb706d612aaa629dbb624cc3f11d9bac857c31b6a6a7db8d1ef3"
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
