
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
    target = output / f"{video_id}.webp"

    # Nie pobieraj ponownie istniejących miniaturek
    if target.exists():
        continue

    url = f"https://i.ytimg.com/vi_webp/{video_id}/hqdefault.webp"

    try:
        urllib.request.urlretrieve(url, target)
        print(f"Downloaded WebP: {video_id}")
    except Exception as exc:
        if target.exists():
            target.unlink()
        print(f"ERROR {video_id}: {exc}")
