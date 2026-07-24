#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/.build-src/olcrtc"

rm -rf "$SRC" \
       "$ROOT/Frameworks/Mobile.xcframework" \
       "$ROOT/olcrtc-linux-amd64"

mkdir -p "$ROOT/.build-src" "$ROOT/Frameworks"

git clone --depth 1 https://github.com/openlibrecommunity/olcrtc "$SRC"

pushd "$SRC"

COMMIT="$(git rev-parse HEAD)"
printf '%s\n' "$COMMIT" > "$ROOT/OLCRTC_COMMIT.txt"
printf '%s\n' "$COMMIT" > "$ROOT/App/OLCRTC_COMMIT.txt"

gomobile bind \
  -target=ios \
  -iosversion=16.0 \
  -ldflags="-s -w -checklinkname=0" \
  -o "$ROOT/Frameworks/Mobile.xcframework" \
  ./mobile

CGO_ENABLED=0 \
GOOS=linux \
GOARCH=amd64 \
go build \
  -trimpath \
  -ldflags="-s -w -checklinkname=0" \
  -o "$ROOT/olcrtc-linux-amd64" \
  ./cmd/olcrtc

popd

test -d "$ROOT/Frameworks/Mobile.xcframework"
test -x "$ROOT/olcrtc-linux-amd64"
test -s "$ROOT/OLCRTC_COMMIT.txt"

echo "Built iOS and Linux from commit: $(cat "$ROOT/OLCRTC_COMMIT.txt")"
