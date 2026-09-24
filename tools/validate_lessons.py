#!/usr/bin/env python3
import json
import subprocess
import sys
import tempfile
from pathlib import Path

root = Path(__file__).resolve().parents[1]
p = root / "Resources" / "Lessons.json"
with tempfile.TemporaryDirectory() as directory:
    generated = Path(directory) / "Lessons.json"
    subprocess.run(
        [sys.executable, str(root / "tools" / "build_lessons.py"), "--output", str(generated)],
        check=True,
        capture_output=True,
        text=True,
    )
    assert generated.read_bytes() == p.read_bytes(), "Resources/Lessons.json differs from generator output"
lessons = json.loads(p.read_text(encoding="utf-8"))
blob = p.read_text(encoding="utf-8")
asset_root = root / "Resources" / "Assets.xcassets"
known_assets = {
    directory.name.removesuffix(".imageset")
    for directory in asset_root.glob("*.imageset")
}
assert len(lessons) == 12, len(lessons)
assert sum(1 for x in lessons if x["demo"]) == 3
assert "Iglica" in blob and "Chropot" in blob and "Irena" in blob
for banned in ("Vogel", "Kruk", "Wilk", "Królewska 16", "vogelkruk", "Art. 6", "DKN.5131", "aplikantk"):
    assert banned not in blob, banned
for lesson in lessons:
    assert lesson["storyMode"] is True
    assert "introVideo" not in lesson
    assert lesson["sourceIds"] == []
    kinds = {c["kind"] for c in lesson["choices"]}
    assert kinds == {"stamp", "reject", "verify"}, lesson["id"]
    sound = [c for c in lesson["choices"] if c["verdict"] == "sound"]
    assert len(sound) == 1, lesson["id"]
    assert sound[0]["id"] == "trap"
    assert len(lesson["beats"]) == 2, lesson["id"]
    beat_assets = [beat["asset"] for beat in lesson["beats"]]
    assert len(set(beat_assets)) == len(beat_assets), lesson["id"]
    assert set(beat_assets) <= known_assets, lesson["id"]
    for beat in lesson["beats"]:
        assert beat["caption"]["pl"] and len(beat["caption"]["pl"]) <= 140
    assert lesson["innerVoice"]["pl"].endswith("?")
    assert lesson["awareness"]["practice"]["pl"]
    assert lesson["awareness"]["minimize"]["pl"] != lesson["awareness"]["practice"]["pl"]
print("LessonPack OK")
