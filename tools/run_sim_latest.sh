#!/bin/bash
# Build + install latest CzerwonaTeczka from /Users/AI/src (not Downloads).
set -euo pipefail
ROOT="/Users/AI/src/CzerwonaTeczka"
cd "$ROOT"

echo "== Devices =="
xcrun simctl list devices available | sed -n '1,50p'

UDID=$(xcrun simctl list devices available -j | /usr/bin/python3 -c '
import json, sys
data = json.load(sys.stdin)
best = None
for runtime, devices in data.get("devices", {}).items():
    if "iOS" not in runtime:
        continue
    for d in devices:
        if d.get("isAvailable") is False:
            continue
        name = d.get("name", "")
        if "iPhone" not in name:
            continue
        score = (2 if "iPhone 17" in name else 1, runtime, name)
        if best is None or score > best[0]:
            best = (score, d["udid"], name, runtime)
if not best:
    sys.exit("Brak dostępnego iPhone w Simulatorze")
print(best[1], file=sys.stdout)
print(f"Wybrano: {best[2]} ({best[3]})", file=sys.stderr)
')

echo "Boot $UDID"
xcrun simctl boot "$UDID" 2>/dev/null || true
open -a Simulator 2>/dev/null || true
xcrun simctl bootstatus "$UDID" -b

DERIVED="$ROOT/.derivedData-sim"
rm -rf "$DERIVED"
echo "== Build =="
xcodebuild -project "$ROOT/CzerwonaTeczka.xcodeproj" \
  -scheme CzerwonaTeczka \
  -destination "id=$UDID" \
  -derivedDataPath "$DERIVED" \
  -configuration Debug \
  build

APP="$DERIVED/Build/Products/Debug-iphonesimulator/CzerwonaTeczka.app"
test -d "$APP"
ls -la "$APP/Mission01Intro.mp4" "$APP/Assets.car" "$APP/Lessons.json"

/usr/bin/python3 - <<PY
import json
from pathlib import Path
app = Path("$APP")
lessons = json.loads((app / "Lessons.json").read_text())
assert isinstance(lessons, list) and len(lessons) == 8, lessons
l = next(x for x in lessons if x["id"] == "01-sygnatura")
assert l.get("storyMode") is True and l.get("introVideo") == "Mission01Intro"
assert len(l.get("beats", [])) >= 3
assert (app / "Assets.car").stat().st_size > 1_000_000
assert (app / "Mission01Intro.mp4").stat().st_size > 100_000
print("bundle OK — 8 lekcji, wideo, Assets.car")
PY

BID=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$APP/Info.plist")
xcrun simctl uninstall "$UDID" "$BID" 2>/dev/null || true
xcrun simctl install "$UDID" "$APP"
xcrun simctl launch "$UDID" "$BID"
echo "DONE — $BID na $UDID"
