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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.3.0/forge-aarch64-macos.tar.gz"
      sha256 "78ee17f0abe518f466a3626d6f7678dc6e0f44a2a15675c1890beb5b823157f1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.3.0/forge-x86_64-macos.tar.gz"
      sha256 "16b6c283e7a405cb0deefc607afa55d77bf954c20f18111242feb894f411170c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.3.0/forge-aarch64-linux.tar.gz"
      sha256 "26e438494f5583d0bbaf37c3e05097114db570a2069f961883d3c2dc44e39254"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.3.0/forge-x86_64-linux.tar.gz"
      sha256 "d6635717252c01698c25821f9fb8a9c4b1049cb6260d9cc0624f60d135ea8711"
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
