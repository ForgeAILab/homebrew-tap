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
      sha256 "86d461504d6a74e80376e03d8bc902f49db3d7cb40cc209b4471a0497b8debf2"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-macos.tar.gz"
      sha256 "642aad09f66249f0d4b220f062b68da72fc9458b229521c11afdc833e7342bf8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-linux.tar.gz"
      sha256 "3a107ab60c91870dc72d795f96ea736cb4e38f1f4f7c1fbee59794a9db5a0bbc"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-linux.tar.gz"
      sha256 "6849199997db712f8fc886bff8c0c013930e71413226131082edb8a6cfbfc564"
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
