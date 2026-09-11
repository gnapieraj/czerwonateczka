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
assert len(lessons) == 8, len(lessons)
assert sum(1 for x in lessons if x["demo"]) == 3
assert [x["id"] for x in lessons if x["demo"]] == ["01-sygnatura", "03-glos", "04-prostokaty"]
assert "Art. 6" in blob or "art. 6" in blob
assert "DKN.5131.31.2022" in blob
assert "ust. 1 lit. f" in blob or "5(1)(f)" in blob
for banned in (
    "art. 107 k.k.",
    "Art. 107 k.k.",
    "Art. 3 § 1 i § 2",
    "Żadnego z tych orzeczeń nie ma",
    "Trzy sygnatury nie istnieją",
    "ISAP są źródłem prawa",
    "ISAP jest źródłem prawa",
    "UODO już wyceniło ten gest",
    "eksport-as-image",
    "Rzecznik Dyscyplinarny Izby Adwokackiej w Warszawie",
    "III CZP z numerem, którego nie ma",
):
    assert banned not in blob, banned
for banned in ("Vogel", "Kruk", "Wilk", "Królewska 16", "vogelkruk"):
    assert banned not in blob, banned
assert "Iglica" in blob and "Chropot" in blob
sygn = next(x for x in lessons if x["id"] == "01-sygnatura")
stamp = next(c for c in sygn["choices"] if c["kind"] == "stamp")
assert stamp["delta"]["sad"] == -45
assert stamp["verdict"] == "unsound"
whisper = next(x for x in lessons if x["id"] == "02-szept")
wstamp = next(c for c in whisper["choices"] if c["kind"] == "stamp")
assert "Art. 6" in wstamp["ratio"]["statute"]["pl"]
assert "Art. 17" not in wstamp["ratio"]["statute"]["pl"]
for lesson in lessons:
    kinds = {c["kind"] for c in lesson["choices"]}
    assert kinds == {"stamp", "reject", "verify"}, lesson["id"]
    assert {c["verdict"] for c in lesson["choices"]} <= {"unsound", "incomplete", "sound"}
    assert any(c["verdict"] == "sound" for c in lesson["choices"]), lesson["id"]
    assert next(c for c in lesson["choices"] if c["kind"] == "stamp")["verdict"] == "unsound"
    assert next(c for c in lesson["choices"] if c["kind"] == "verify")["verdict"] == "sound"
    assert lesson["sourceIds"], lesson["id"]
    assert 3 <= len(lesson["beats"]) <= 6, lesson["id"]
    assert len(lesson["beats"]) == 4, f"{lesson['id']} storyboard should fill two pages"
    beat_assets = [beat["asset"] for beat in lesson["beats"]]
    assert len(set(beat_assets)) == len(beat_assets), f"{lesson['id']} repeats a panel asset"
    assert set(beat_assets) <= known_assets, f"{lesson['id']} references a missing comic asset"
    for beat in lesson["beats"]:
        assert beat["caption"]["pl"] and beat["caption"]["en"], lesson["id"]
        assert len(beat["caption"]["pl"]) <= 140, lesson["id"]
    assert lesson["innerVoice"]["pl"].endswith("?"), f"{lesson['id']} inner voice gives an answer"
    assert lesson["innerVoice"]["en"].endswith("?"), f"{lesson['id']} inner voice gives an answer"
    a = lesson["awareness"]
    for key in ("threat", "minimize", "practice"):
        assert a[key]["pl"] and a[key]["en"], f"{lesson['id']} {key}"
    assert len(a["watchFor"]) >= 4, lesson["id"]
sygn = next(x for x in lessons if x["id"] == "01-sygnatura")
assert "Avianca" in sygn["choices"][0]["ratio"]["patternStory"]["pl"]
usb = next(x for x in lessons if x["id"] == "05-pendrive")
assert "23 580" in usb["choices"][0]["ratio"]["patternStory"]["pl"]
assert "utrat" in usb["awareness"]["threat"]["pl"].lower()
assert "złośliw" in usb["awareness"]["threat"]["pl"].lower()
assert "nieprawomocn" in usb["awareness"]["threat"]["pl"].lower()
voice = next(x for x in lessons if x["id"] == "03-glos")
assert "Heppner" not in voice["choices"][0]["ratio"]["pattern"]["pl"]
emotion = next(x for x in lessons if x["id"] == "08-emocje")
assert "danych biometrycznych" in blob
assert "motywem 18" in blob
assert "28 października 2026" in blob
copilot = next(x for x in lessons if x["id"] == "07-copilot")
copilot_blob = json.dumps(copilot, ensure_ascii=False)
assert "III CZP 7/24 istnieje" in copilot_blob
assert "ECLI:EU:C:2024:805" in copilot_blob
print("LessonPack OK")
