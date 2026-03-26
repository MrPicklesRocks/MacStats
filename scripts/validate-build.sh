#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
DERIVED_DATA_PATH="${DERIVED_DATA_PATH:-$ROOT/.build/DerivedData}"

export SKIP_SWIFTLINT="${SKIP_SWIFTLINT:-1}"
export SKIP_WIDGET_VERSION_SCRIPT="${SKIP_WIDGET_VERSION_SCRIPT:-1}"

exec xcodebuild \
  -project "$ROOT/Stats.xcodeproj" \
  -scheme Stats \
  -configuration Debug \
  -destination 'platform=macOS,arch=x86_64' \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  build
