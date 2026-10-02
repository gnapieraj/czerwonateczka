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
        if "iPad Air" not in name:
            continue
        score = (2 if "11" in name else 1, runtime, name)
        if best is None or score > best[0]:
            best = (score, d["udid"], name, runtime)
if not best:
    sys.exit("No iPad Air simulator")
print(best[1])
print(f"Wybrano: {best[2]} ({best[3]})", file=sys.stderr)
