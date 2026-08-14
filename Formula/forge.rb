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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.4/forge-aarch64-macos.tar.gz"
      sha256 "aab4bab1a8e3c4f9a9ca6fbd383334ad258fb59709abeb45dc16943e5e720ee8"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.4/forge-x86_64-macos.tar.gz"
      sha256 "196ec0361a5f9b4b1505fea921f9ac0a1b659065ede766dc9ac06f6c115337f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.4/forge-aarch64-linux.tar.gz"
      sha256 "d95bf9a2d48e4969b1c9d0c7eadaca814ffa65192f12ba18eb004a8d6b9b5207"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.4/forge-x86_64-linux.tar.gz"
      sha256 "34a7000cc15b94edecbd6a30f4aeb1e3bde4ac988b527b27be2fc83751c6efd8"
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
