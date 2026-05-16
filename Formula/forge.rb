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
      sha256 "53f1b861fde7c7eb534aa1921fc2c7f4eec0683f5fdfa97156fe9505d00bb812"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-macos.tar.gz"
      sha256 "6852cc5dea1731e1487982a1b04c0ff21a31c44e4156dd96e816c9033ac18595"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-linux.tar.gz"
      sha256 "bc5498ce7c441830c3a14af4f330f4085d57e9d5c3878622fd80aff330a01ab3"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-linux.tar.gz"
      sha256 "2ada89c2e963e68dabbba6d9ac1a8dde2c628d2a6f60a2c32ec0ed4ddb1a3ff7"
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
    assert_match "Usage: forge", shell_output("#{bin}/forge --help")
    assert_match "Forge CLI client", shell_output("#{bin}/forge-ctl --help")
  end
end
