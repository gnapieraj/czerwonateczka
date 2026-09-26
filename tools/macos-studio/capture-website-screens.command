#!/bin/zsh
set -euo pipefail
cd /Users/AI/src/CzerwonaTeczka
LOG=tools/macos-studio/capture-screens.log
exec > >(tee -a "$LOG") 2>&1
echo "=== START $(date -Iseconds) ==="
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
SIM=98629FCC-A0CE-455B-ABBD-5DCB2AD43FFB
echo "SIM=$SIM"
xcrun simctl boot "$SIM" 2>/dev/null || true
# Bring Simulator UI without relying on short name
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app || true
sleep 5
APP=.derivedData-sim/Build/Products/Debug-iphonesimulator/CzerwonaTeczka.app
xcrun simctl install "$SIM" "$APP"
xcrun simctl spawn "$SIM" defaults write pl.czerwonateczka.app docket.seenHowToPlay -bool YES
xcrun simctl spawn "$SIM" defaults write pl.czerwonateczka.app docket.seenBible -bool YES
xcrun simctl terminate "$SIM" pl.czerwonateczka.app 2>/dev/null || true
xcrun simctl launch "$SIM" pl.czerwonateczka.app
sleep 5
TMP=tools/macos-studio/screens-tmp
mkdir -p "$TMP"
xcrun simctl io "$SIM" screenshot "$TMP/sim-desk.png"
tools/macos-studio/.venv/bin/python <<'PY'
from PIL import Image
from pathlib import Path
src = Path('tools/macos-studio/screens-tmp/sim-desk.png')
dst = Path('Website/src/assets/screens/iphone-wokanda.jpg')
im = Image.open(src).convert('RGB')
tw, th = 644, 1400
scale = max(tw/im.width, th/im.height)
nw, nh = int(im.width*scale), int(im.height*scale)
im = im.resize((nw, nh), Image.Resampling.LANCZOS)
im = im.crop(((nw-tw)//2, (nh-th)//2, (nw-tw)//2+tw, (nh-th)//2+th))
im.save(dst, 'JPEG', quality=88, optimize=True)
print('wrote', dst, dst.stat().st_size)
PY
echo "=== DONE desk $(date -Iseconds) ==="
