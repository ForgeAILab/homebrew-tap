# typed: false
# frozen_string_literal: true

# Homebrew formula for Forge — the local-first workflow engine for coding agents.
# Source repo: https://github.com/ForgeAILab/forge
#
# After cutting a new release on the source repo:
#   1. Bump `version` below to the new tag (without the leading `v`).
#   2. Run `scripts/update-checksums.sh <version>` from the repo root — it pulls
#      the published SHA256SUMS file and rewrites the four `sha256` lines here.
#   3. Commit and push. Users on the tap pick up the new version on `brew update`.
class Forge < Formula
  desc "Local-first workflow engine for coding agents"
  homepage "https://github.com/ForgeAILab/forge"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-macos.tar.gz"
      sha256 "3b7696d0f605f1b637ae5234ce3cf0a2ced280fa3e7a9d9b493f71f534eb17d1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-macos.tar.gz"
      sha256 "def6198f6ae1b414bab3fb261125dc6c348d8866e60855a718d03187544b0b50"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-linux.tar.gz"
      sha256 "f853f6317d94c6143a6078ecb7000fd6a4e74cb19a05bf44e542b5a110729b7d"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-linux.tar.gz"
      sha256 "426628f6a59650591673a5a0fce7d6d47ee10d7b866508456f03e878143a1e57"
    end
  end

  def install
    bin.install "forge"
    bin.install "forge-ctl"
    (share/"forge").install "web" if Dir.exist?("web")
  end

  def caveats
    <<~EOS
      Forge starts bound to 127.0.0.1:8080 and stores data under ~/.forge/.
      To launch with seeded demo data:
        forge --demo
      Then open http://localhost:8080
    EOS
  end

  test do
    assert_match "forge", shell_output("#{bin}/forge --version")
    assert_match "forge-ctl", shell_output("#{bin}/forge-ctl --help")
  end
end
