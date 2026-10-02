#!/bin/bash
set -euo pipefail
ROOT=/Users/AI/src/CzerwonaTeczka
cd "$ROOT"
export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"

UDID=$(xcrun simctl list devices available -j | /usr/bin/python3 "$ROOT/tools/macos-studio/pick-ipad-air.py")
echo "UDID=$UDID"
xcrun simctl boot "$UDID" 2>/dev/null || true
open -a Simulator 2>/dev/null || true
xcrun simctl bootstatus "$UDID" -b

DERIVED="$ROOT/.derivedData-sim"
echo "== Build =="
xcodebuild -project "$ROOT/CzerwonaTeczka.xcodeproj" \
  -scheme CzerwonaTeczka \
  -destination "id=$UDID" \
  -derivedDataPath "$DERIVED" \
  -configuration Debug \
  build

APP="$DERIVED/Build/Products/Debug-iphonesimulator/CzerwonaTeczka.app"
test -d "$APP"
BID=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$APP/Info.plist")

OUT="$ROOT/World/report-fixtures/ipad-shots"
SCREENS="$ROOT/Website/src/assets/screens"
mkdir -p "$OUT" "$SCREENS"

xcrun simctl uninstall "$UDID" "$BID" 2>/dev/null || true
xcrun simctl install "$UDID" "$APP"

launch_with() {
  xcrun simctl terminate "$UDID" "$BID" 2>/dev/null || true
  sleep 1
  xcrun simctl launch "$UDID" "$BID" "$@"
  sleep 3
}

shot() {
  local name="$1"
  xcrun simctl io "$UDID" screenshot "$OUT/$name.png"
  echo "shot $name"
}

launch_with --seed-season0-pass --report
sleep 2
shot ipad-raport-formularz

launch_with --seed-season0-pass --report --auto-share-pdf
sleep 2
shot ipad-raport-share

launch_with --seed-season0-pass --report --auto-preview-pdf
sleep 2
shot ipad-raport-pdf-preview

launch_with --seed-season0-pass --report --auto-share-badge
sleep 2
shot ipad-raport-badge-share

echo "== Fixtures =="
xcodebuild test \
  -project "$ROOT/CzerwonaTeczka.xcodeproj" \
  -scheme CzerwonaTeczka \
  -destination "platform=iOS Simulator,name=iPhone 17" \
  -derivedDataPath "$DERIVED" \
  -only-testing:CzerwonaTeczkaTests/TrainingReportLayoutTests/testWriteReportFixturesIfRequested \
  -only-testing:CzerwonaTeczkaTests/TrainingReportLayoutTests/testWriteBadgeStylePreviewsIfRequested \
  WRITE_REPORT_FIXTURES=1 WRITE_BADGE_PREVIEWS=1 \
  2>&1 | tail -50 || echo tests-nonzero

if [[ -f "$ROOT/CzerwonaTeczkaTests/Fixtures/Reports/sezon0-12.pdf" ]]; then
  cp -f "$ROOT/CzerwonaTeczkaTests/Fixtures/Reports/sezon0-12.pdf" "$ROOT/World/report-fixtures/sezon0-12.pdf"
  cp -f "$ROOT/CzerwonaTeczkaTests/Fixtures/Reports/sezon0-12-badge.png" "$ROOT/World/report-fixtures/sezon0-12-badge.png" || true
fi

/usr/bin/python3 "$ROOT/tools/macos-studio/prep-raport-assets.py"
echo DONE
ls -la "$OUT" || true
ls -la "$SCREENS"/ipad-raport* "$SCREENS"/raport-* 2>/dev/null || true
