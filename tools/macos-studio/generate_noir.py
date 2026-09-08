#!/usr/bin/env python3
"""Generate locked Sin City plates on Mac Studio (M2 Ultra, 128 GB) via mflux/MLX.

Does not run on iPad. Does not invent new faces: every job img2img's a bible plate
with a low strength so Tomasz's successor Filip Iglica stays Filip Iglica.

Usage (on the Studio, from the CzerwonaTeczka folder):

    python3 tools/macos-studio/generate_noir.py --smoke
    python3 tools/macos-studio/generate_noir.py
    python3 tools/macos-studio/generate_noir.py --job aplikant-iglica
"""

from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PROMPTS = Path(__file__).resolve().parent / "prompts.json"
OUT = Path(__file__).resolve().parent / "out"
VENV = Path(__file__).resolve().parent / ".venv"
ASSETS = ROOT / "Resources" / "Assets.xcassets"


def die(msg: str, code: int = 1) -> None:
    print(msg, file=sys.stderr)
    raise SystemExit(code)


def load_spec() -> dict:
    return json.loads(PROMPTS.read_text(encoding="utf-8"))


def ensure_macos() -> None:
    if sys.platform != "darwin":
        die(
            "Ten skrypt jest na Mac Studio M2 Ultra (128 GB), nie na iPadzie i nie na Linuxie.\n"
            "Skopiuj folder CzerwonaTeczka na Studio i uruchom tam."
        )


def venv_python() -> Path:
    return VENV / "bin" / "python3"


def venv_mflux() -> Path:
    return VENV / "bin" / "mflux-generate"


def bootstrap() -> None:
    if not venv_python().exists():
        subprocess.check_call([sys.executable, "-m", "venv", str(VENV)])
    pip = VENV / "bin" / "pip"
    subprocess.check_call([str(pip), "install", "--upgrade", "pip"])
    # mflux = Flux on Apple MLX. 128 GB holds flux-dev at 8-bit with headroom.
    subprocess.check_call([str(pip), "install", "mflux"])


def run_job(spec: dict, job: dict, smoke: bool) -> Path:
    bible = ROOT / job["bible"]
    if not bible.exists():
        die(f"Brak mastera biblii: {bible}")
    OUT.mkdir(parents=True, exist_ok=True)
    dest = OUT / f"{job['id']}.png"
    mfx = spec["mflux"]
    prompt = f"{spec['style_lock']}. {job['prompt']}"
    steps = 4 if smoke else int(mfx["steps"])
    model = "schnell" if smoke else mfx["model"]
    strength = 0.22 if smoke else float(mfx["img2img_strength"])
    cmd = [
        str(venv_mflux()),
        "--model",
        model,
        "--prompt",
        prompt,
        "--negative-prompt",
        spec["negative"],
        "--width",
        str(job["width"]),
        "--height",
        str(job["height"]),
        "--steps",
        str(steps),
        "--seed",
        str(job["seed"]),
        "--guidance",
        str(mfx["guidance"]),
        "-q",
        str(mfx["quantize"]),
        "--image",
        str(bible),
        str(strength),
        "--output",
        str(dest),
    ]
    print(" ".join(cmd))
    env = os.environ.copy()
    # Unified memory: leave headroom for the desktop.
    env.setdefault("PYTORCH_MPS_HIGH_WATERMARK_RATIO", "0.0")
    subprocess.check_call(cmd, env=env, cwd=str(ROOT))
    return dest


def install_into_xcassets(job: dict, png: Path) -> None:
    folder = ASSETS / f"{job['asset']}.imageset"
    folder.mkdir(parents=True, exist_ok=True)
    jpg = folder / f"{job['asset']}.jpg"
    try:
        from PIL import Image
    except ImportError:
        shutil.copy2(png, folder / f"{job['asset']}.png")
        (folder / "Contents.json").write_text(
            json.dumps(
                {
                    "images": [{"filename": f"{job['asset']}.png", "idiom": "universal", "scale": "1x"}],
                    "info": {"author": "xcode", "version": 1},
                },
                indent=2,
            )
            + "\n"
        )
        return
    im = Image.open(png).convert("RGB")
    im.save(jpg, "JPEG", quality=85, optimize=True)
    (folder / "Contents.json").write_text(
        json.dumps(
            {
                "images": [{"filename": f"{job['asset']}.jpg", "idiom": "universal", "scale": "1x"}],
                "info": {"author": "xcode", "version": 1},
            },
            indent=2,
        )
        + "\n"
    )
    print("installed", jpg)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--smoke", action="store_true", help="schnell, 4 steps — test instalacji")
    parser.add_argument("--job", help="tylko jedno id z prompts.json")
    parser.add_argument("--skip-install", action="store_true")
    parser.add_argument("--no-assets", action="store_true", help="nie kopiuj do Assets.xcassets")
    args = parser.parse_args()

    ensure_macos()
    spec = load_spec()
    jobs = spec["jobs"]
    if args.job:
        jobs = [j for j in jobs if j["id"] == args.job]
        if not jobs:
            die(f"Nie ma joba {args.job}")
    if not args.skip_install:
        bootstrap()
    if not venv_mflux().exists():
        die("mflux-generate nie wstał. Odpal bez --skip-install.")

    for job in jobs:
        png = run_job(spec, job, smoke=args.smoke)
        if not args.no_assets:
            install_into_xcassets(job, png)
        print("ok", job["id"], png)


if __name__ == "__main__":
    main()
