from pathlib import Path
import re
import urllib.request

root = Path(__file__).resolve().parent
output = root / "thumbnails"
output.mkdir(exist_ok=True)

ids = set()

for qmd in root.glob("*.qmd"):
    text = qmd.read_text(encoding="utf-8")
    ids.update(re.findall(
        r"\{\{<\s*ytvideo\s+([A-Za-z0-9_-]{11})\s*>\}\}",
        text
    ))

for video_id in sorted(ids):
    target = output / f"{video_id}.jpg"

    if target.exists():
        continue

    url = f"https://img.youtube.com/vi/{video_id}/hqdefault.jpg"

    try:
        urllib.request.urlretrieve(url, target)
        print(f"Downloaded: {video_id}")
    except Exception as exc:
        print(f"ERROR {video_id}: {exc}")