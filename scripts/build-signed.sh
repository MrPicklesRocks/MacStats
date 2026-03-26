#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
DERIVED_DATA_PATH="${DERIVED_DATA_PATH:-$ROOT/.build/DerivedData}"

exec xcodebuild \
  -project "$ROOT/Stats.xcodeproj" \
  -scheme Stats \
  -configuration Debug \
  -destination 'platform=macOS,arch=x86_64' \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  build
