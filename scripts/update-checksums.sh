#!/usr/bin/env bash
# Pull SHA256SUMS from a Forge GitHub release and rewrite the four `sha256` lines
# in Formula/forge.rb. Bump `version` in the formula yourself first.
#
# Usage:
#   ./scripts/update-checksums.sh 0.1.0
#
# Requires: curl, awk, sed.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <version>   (e.g. 0.1.0)" >&2
  exit 1
fi

VERSION="$1"
REPO="ForgeAILab/forge"
URL="https://github.com/${REPO}/releases/download/v${VERSION}/SHA256SUMS"
FORMULA="$(dirname "$0")/../Formula/forge.rb"

echo "→ fetching ${URL}"
SUMS="$(curl -fsSL "${URL}")"
if [[ -z "${SUMS}" ]]; then
  echo "error: empty SHA256SUMS response — does v${VERSION} exist on GitHub Releases?" >&2
  exit 2
fi

# Pull each platform's sha by filename suffix. Matches either:
#   <64hex>  forge-aarch64-macos.tar.gz            (clean form)
#   <64hex>  artifacts/forge-aarch64-macos/forge-aarch64-macos.tar.gz   (CI internal form)
get_sha() {
  local file="$1"
  local sha
  sha="$(echo "${SUMS}" | awk -v f="${file}" '$2 ~ ("(^|/)" f "$") { print $1; exit }')"
  if [[ -z "${sha}" ]]; then
    echo "error: no entry for ${file} in SHA256SUMS" >&2
    exit 3
  fi
  echo "${sha}"
}

SHA_MAC_ARM="$(get_sha forge-aarch64-macos.tar.gz)"
SHA_MAC_X86="$(get_sha forge-x86_64-macos.tar.gz)"
SHA_LINUX_ARM="$(get_sha forge-aarch64-linux.tar.gz)"
SHA_LINUX_X86="$(get_sha forge-x86_64-linux.tar.gz)"

echo "  aarch64-macos: ${SHA_MAC_ARM}"
echo "  x86_64-macos:  ${SHA_MAC_X86}"
echo "  aarch64-linux: ${SHA_LINUX_ARM}"
echo "  x86_64-linux:  ${SHA_LINUX_X86}"

# Update each sha256 line by matching on the URL filename in the preceding url line.
# Uses a state-machine awk so we never overwrite the wrong sha.
tmp="$(mktemp)"
awk -v mac_arm="${SHA_MAC_ARM}" \
    -v mac_x86="${SHA_MAC_X86}" \
    -v lin_arm="${SHA_LINUX_ARM}" \
    -v lin_x86="${SHA_LINUX_X86}" '
  /url ".*forge-aarch64-macos\.tar\.gz"/ { last="mac_arm" }
  /url ".*forge-x86_64-macos\.tar\.gz"/  { last="mac_x86" }
  /url ".*forge-aarch64-linux\.tar\.gz"/ { last="lin_arm" }
  /url ".*forge-x86_64-linux\.tar\.gz"/  { last="lin_x86" }
  /sha256 ".*"/ && last != "" {
    sha = ""
    if (last == "mac_arm") sha = mac_arm
    else if (last == "mac_x86") sha = mac_x86
    else if (last == "lin_arm") sha = lin_arm
    else if (last == "lin_x86") sha = lin_x86
    if (sha != "") {
      sub(/sha256 ".*"/, "sha256 \"" sha "\"")
      last = ""
    }
  }
  { print }
' "${FORMULA}" > "${tmp}"

mv "${tmp}" "${FORMULA}"

echo "✓ updated ${FORMULA}"
echo "  next: brew audit --strict --online forgeailab/tap/forge"
