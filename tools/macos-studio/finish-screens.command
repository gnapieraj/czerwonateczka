#!/bin/zsh
set -euo pipefail
cd /Users/AI/src/CzerwonaTeczka
LOG=tools/macos-studio/finish-screens.log
exec > >(tee "$LOG") 2>&1
echo "=== START $(date -Iseconds) ==="
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"

APP=.derivedData-device/Build/Products/Debug-iphoneos/CzerwonaTeczka.app
IPHONE=00008110-000E48EA0160401E
IPAD=00008030-000474311168202E
TMP=tools/macos-studio/screens-tmp
SCREENS=Website/src/assets/screens
mkdir -p "$TMP"

echo "=== rebuild ==="
xcodebuild -project CzerwonaTeczka.xcodeproj -scheme CzerwonaTeczka -configuration Debug \
  -destination 'generic/platform=iOS' \
  -derivedDataPath .derivedData-device \
  DEVELOPMENT_TEAM=6FK9765G7T CODE_SIGN_STYLE=Automatic -allowProvisioningUpdates build | tail -5

install_one() {
  local id=$1 name=$2
  for i in 1 2 3 4 5; do
    echo "install $name attempt $i"
    if xcrun devicectl device install app --device "$id" "$APP"; then
      return 0
    fi
    sleep 4
  done
  return 1
}

capture_one() {
  local id=$1 out=$2
  for i in 1 2 3; do
    if xcrun devicectl device capture screenshot --device "$id" --destination "$out"; then
      return 0
    fi
    sleep 3
  done
  return 1
}

install_one "$IPHONE" iphone || echo "IPHONE_INSTALL_FAIL"
install_one "$IPAD" ipad || echo "IPAD_INSTALL_FAIL"

xcrun devicectl device process launch --device "$IPHONE" pl.czerwonateczka.app || true
sleep 4
capture_one "$IPHONE" "$TMP/iphone-desk.png" || echo "IPHONE_SHOT_FAIL"

xcrun devicectl device process launch --device "$IPAD" pl.czerwonateczka.app || true
sleep 3
capture_one "$IPAD" "$TMP/ipad-desk.png" || echo "IPAD_SHOT_FAIL"

# Also try Simulator for reliable desk + comic navigation via defaults
SIM=98629FCC-A0CE-455B-ABBD-5DCB2AD43FFB
echo "=== simulator path ==="
xcrun simctl boot "$SIM" 2>/dev/null || true
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app || true
sleep 3
SIMAPP=.derivedData-sim/Build/Products/Debug-iphonesimulator/CzerwonaTeczka.app
if [[ ! -d "$SIMAPP" ]]; then
  xcodebuild -project CzerwonaTeczka.xcodeproj -scheme CzerwonaTeczka -configuration Debug \
    -destination "platform=iOS Simulator,id=$SIM" \
    -derivedDataPath .derivedData-sim build | tail -5
fi
xcrun simctl install "$SIM" "$SIMAPP" || true
xcrun simctl spawn "$SIM" defaults write pl.czerwonateczka.app docket.seenHowToPlay -bool YES || true
xcrun simctl spawn "$SIM" defaults write pl.czerwonateczka.app docket.seenBible -bool YES || true
xcrun simctl terminate "$SIM" pl.czerwonateczka.app 2>/dev/null || true
xcrun simctl launch "$SIM" pl.czerwonateczka.app || true
sleep 5
xcrun simctl io "$SIM" screenshot "$TMP/sim-desk.png" || true

tools/macos-studio/.venv/bin/python <<'PY'
from PIL import Image
from pathlib import Path

def fit(src: Path, dst: Path, tw: int, th: int, rotate90=False):
    if not src.exists() or src.stat().st_size < 80_000:
        print('skip small/missing', src)
        return False
    im = Image.open(src).convert('RGB')
    if rotate90:
        im = im.rotate(90, expand=True)
    scale = max(tw / im.width, th / im.height)
    nw, nh = int(im.width * scale), int(im.height * scale)
    im = im.resize((nw, nh), Image.Resampling.LANCZOS)
    left, top = (nw - tw) // 2, (nh - th) // 2
    im = im.crop((left, top, left + tw, top + th))
    dst.parent.mkdir(parents=True, exist_ok=True)
    im.save(dst, 'JPEG', quality=88, optimize=True)
    print('wrote', dst, dst.stat().st_size)
    return True

tmp = Path('tools/macos-studio/screens-tmp')
screens = Path('Website/src/assets/screens')

# Prefer physical iPhone desk if good, else sim
desk = tmp / 'iphone-desk.png'
if not (desk.exists() and desk.stat().st_size > 80_000):
    desk = tmp / 'sim-desk.png'
fit(desk, screens / 'iphone-wokanda.jpg', 644, 1400)

ipad = tmp / 'ipad-desk.png'
if fit(ipad, screens / 'ipad-wokanda.jpg', 1251, 1800):
    # landscape variant from same capture
    fit(ipad, screens / 'ipad-wokanda-landscape.jpg', 1800, 1251, rotate90=True)

# Comic: if we only have desk, leave komiks for next step note
print('desk source used:', desk)
for p in screens.glob('*.jpg'):
    print(p.name, p.stat().st_mtime, p.stat().st_size)
PY

echo "=== DONE $(date -Iseconds) ==="
