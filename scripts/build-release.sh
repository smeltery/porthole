#!/bin/sh
# Builds the universal app, notarizes it when it's signed with the Developer ID, staples the ticket,
# checks the signature survives zipping, and writes dist/Porthole-<version>.zip for a GitHub release.
# Notarizing needs the Developer ID certificate in the keychain and a notarytool profile named "notary":
#   xcrun notarytool store-credentials notary --apple-id <apple id> --team-id YOUR_TEAM_ID
# Usage: scripts/build-release.sh
set -eu

ROOT=$(CDPATH='' cd -- "$(dirname "$0")/.." && pwd)
cd "$ROOT"
VERSION=${RELEASE_VERSION:-$(sed -n 's/^ *static let version = "\(.*\)"$/\1/p' Sources/PortholeApp/Version.swift)}
APP="$ROOT/dist/Porthole.app"
ZIP="$ROOT/dist/Porthole-$VERSION.zip"
CHECK=$(mktemp -d)
trap 'rm -rf "$CHECK"' EXIT

rm -f "$ZIP"
scripts/build-app.sh >/dev/null
for architecture in arm64 x86_64; do
  lipo -archs "$APP/Contents/MacOS/Porthole" | tr ' ' '\n' | grep -qx "$architecture"
done

TEAM=$(codesign -dv "$APP" 2>&1 | sed -n 's/^TeamIdentifier=//p')
if [ -n "${NOTARY_PROFILE:-}" ] && [ "$TEAM" != "not set" ]; then
  SIGNATURE="Developer ID"
  ditto -c -k --keepParent "$APP" "$ZIP"
  RESULT=$(xcrun notarytool submit "$ZIP" --keychain-profile "$NOTARY_PROFILE" --wait --output-format json)
  if [ "$(printf '%s' "$RESULT" | plutil -extract status raw -o - -)" != Accepted ]; then
    printf '%s\n' "$RESULT" >&2
    xcrun notarytool log "$(printf '%s' "$RESULT" | plutil -extract id raw -o - -)" --keychain-profile "$NOTARY_PROFILE" >&2
    exit 1
  fi
  xcrun stapler staple "$APP"
  rm -f "$ZIP"
  ditto -c -k --keepParent "$APP" "$ZIP"
  spctl --assess --type execute --verbose "$APP"
else
  SIGNATURE="ad-hoc"
  ditto -c -k --keepParent "$APP" "$ZIP"
fi

ditto -x -k "$ZIP" "$CHECK"
codesign --verify --deep --strict "$CHECK/Porthole.app"

echo "Built $ZIP, $SIGNATURE signed"
shasum -a 256 "$ZIP"
