#!/usr/bin/env bash
# Used by Cloudflare Pages as the build command.
set -euo pipefail

MDBOOK_VERSION="0.4.40"

if ! command -v mdbook &>/dev/null; then
  echo "Downloading mdBook $MDBOOK_VERSION..."
  curl -sSL "https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar -xz
  export PATH="$PWD:$PATH"
fi

mdbook build
