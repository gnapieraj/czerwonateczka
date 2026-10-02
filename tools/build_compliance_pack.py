#!/usr/bin/env python3
"""Emit Compliance pack markdown + draft lessons from tools/data/compliance_pack_nights.json.

Does NOT overwrite Resources/Lessons.json (free Seasons 0–1).
"""
from __future__ import annotations
import argparse, json, subprocess, sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
DATA = REPO / "tools" / "data" / "compliance_pack_nights.json"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true", help="Validate night count and caption limits")
    args = ap.parse_args()
    nights = json.loads(DATA.read_text(encoding="utf-8"))
    assert len(nights) == 24
    assert [n["order"] for n in nights] == list(range(25, 49))
    for n in nights:
        assert len(n["caption_a_pl"]) <= 140, n["id"]
        assert len(n["caption_b_pl"]) <= 140, n["id"]
        assert len(n["threat_pl"]) >= 120, n["id"]
        assert n["minimize_pl"] != n["practice_pl"], n["id"]
        assert n["voice_pl"].endswith("?"), n["id"]
    print("ok", len(nights), "nights", "s2", sum(1 for n in nights if n["season"]=="2"), "s3", sum(1 for n in nights if n["season"]=="3"))
    if args.check:
        return
    print("Data OK. Markdown/draft already generated alongside this PR;")
    print("re-run the generator block in repo history or extend this script if regenerating.")


if __name__ == "__main__":
    main()
