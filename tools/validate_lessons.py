#!/usr/bin/env python3
import json
from pathlib import Path

p = Path("/agent/CzerwonaTeczka/Resources/Lessons.json")
lessons = json.loads(p.read_text(encoding="utf-8"))
blob = p.read_text(encoding="utf-8")
assert len(lessons) == 8, len(lessons)
assert sum(1 for x in lessons if x["demo"]) == 3
assert [x["id"] for x in lessons if x["demo"]] == ["01-sygnatura", "03-glos", "04-prostokaty"]
assert "Art. 6" in blob or "art. 6" in blob
assert "DKN.5131.31.2022" in blob
assert "ust. 1 lit. f" in blob or "5(1)(f)" in blob
sygn = next(x for x in lessons if x["id"] == "01-sygnatura")
stamp = next(c for c in sygn["choices"] if c["kind"] == "stamp")
assert stamp["delta"]["sad"] == -45
assert stamp["pass"] is False
whisper = next(x for x in lessons if x["id"] == "02-szept")
wstamp = next(c for c in whisper["choices"] if c["kind"] == "stamp")
assert "Art. 6" in wstamp["ratio"]["statute"]["pl"]
assert "Art. 17" not in wstamp["ratio"]["statute"]["pl"]
for lesson in lessons:
    kinds = {c["kind"] for c in lesson["choices"]}
    assert kinds == {"stamp", "reject", "verify"}, lesson["id"]
    assert any(c["pass"] for c in lesson["choices"]), lesson["id"]
print("LessonPack OK")
