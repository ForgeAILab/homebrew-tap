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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.10.0/forge-aarch64-macos.tar.gz"
      sha256 "9e75bd304a89a3f5ac68d918f121a2c552a69c8f04b219a7d154b6afe291c63c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.10.0/forge-x86_64-macos.tar.gz"
      sha256 "fe1327d815bbb3180119ea14887293182feeef31e8d19068712554bdd4aadb6f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.10.0/forge-aarch64-linux.tar.gz"
      sha256 "b28af494ff6971cfe046e46f68173c835a8eaa6d2bb4c982e4afdf5e039a1c5e"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.10.0/forge-x86_64-linux.tar.gz"
      sha256 "0d8fcb126b02272009e03198f7a7ab103ca40eff01fdf0dc1195fbb8262d9aa7"
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
