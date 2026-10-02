from pathlib import Path
import subprocess, shutil

root = Path("/Users/AI/src/CzerwonaTeczka")
out = root / "World/report-fixtures/ipad-shots"
screens = root / "Website/src/assets/screens"
world = root / "World/report-fixtures"
try:
    from PIL import Image
except ImportError:
    Image = None

def to_jpg(src, dst, max_w=1200):
    if Image is None:
        subprocess.run(["sips", "-s", "format", "jpeg", str(src), "--out", str(dst)], check=True)
        return
    im = Image.open(src).convert("RGB")
    if im.width > max_w:
        h = int(im.height * max_w / im.width)
        im = im.resize((max_w, h), Image.Resampling.LANCZOS)
    im.save(dst, "JPEG", quality=88, optimize=True)
    print("jpg", dst, dst.stat().st_size)

for src_name, dst_name in {
    "ipad-raport-formularz.png": "ipad-raport-formularz.jpg",
    "ipad-raport-share.png": "ipad-raport-share.jpg",
}.items():
    src = out / src_name
    if src.exists():
        to_jpg(src, screens / dst_name)
        shutil.copy2(src, world / src_name)

badge = world / "sezon0-12-badge.png"
folder = world / "badge-previews" / "badge-folder-pack24.png"
dst_badge = screens / "raport-odznaka-folder.png"
if badge.exists():
    shutil.copy2(badge, dst_badge)
elif folder.exists():
    shutil.copy2(folder, dst_badge)
print("badge", dst_badge.exists(), dst_badge)

pdf = world / "sezon0-12.pdf"
png = screens / "raport-dyplom-sezon0.png"
if pdf.exists():
    subprocess.run(["qlmanage", "-t", "-s", "1200", "-o", str(out), str(pdf)], capture_output=True, text=True)
    cand = out / "sezon0-12.pdf.png"
    if cand.exists():
        if Image:
            Image.open(cand).convert("RGB").save(png, "PNG", optimize=True)
        else:
            shutil.copy2(cand, png)
        print("diploma", png, png.stat().st_size)
    else:
        print("qlmanage did not produce thumbnail")
print("asset prep done")
