#!/usr/bin/env python3
"""Remove portrait background and composite on pure white."""
from __future__ import annotations

import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Install: pip install pillow rembg", file=sys.stderr)
    sys.exit(1)

SRC = Path(
    "/Users/ahmedehabmohammed/.cursor/projects/Users-ahmedehabmohammed-Developer-myportofilo/assets/1000330025-b96ec553-1e14-473c-9b76-6b40d2629984.png"
)
OUT = Path(__file__).resolve().parents[1] / "assets/images/ahmed_profile.png"


def remove_bg_rembg(img: Image.Image) -> Image.Image:
    from rembg import remove

    return remove(img)


def remove_bg_simple(img: Image.Image) -> Image.Image:
    """Fallback: keep center subject via rembg unavailable — rough mask from edges."""
    img = img.convert("RGBA")
    w, h = img.size
    px = img.load()
    # Sample corner colors
    corners = [px[0, 0], px[w - 1, 0], px[0, h - 1], px[w - 1, h - 1]]
    avg = tuple(sum(c[i] for c in corners) // 4 for i in range(3))

    def dist(c):
        return sum(abs(c[i] - avg[i]) for i in range(3))

    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            if dist((r, g, b)) < 55:
                px[x, y] = (r, g, b, 0)
    return img


def main() -> None:
    if not SRC.exists():
        print(f"Missing source: {SRC}", file=sys.stderr)
        sys.exit(1)

    img = Image.open(SRC).convert("RGBA")
    try:
        cutout = remove_bg_rembg(img)
        if isinstance(cutout, bytes):
            from io import BytesIO

            cutout = Image.open(BytesIO(cutout)).convert("RGBA")
        else:
            cutout = cutout.convert("RGBA")
    except Exception as exc:
        print(f"rembg failed ({exc}), using simple fallback", file=sys.stderr)
        cutout = remove_bg_simple(img)

    # Trim transparent padding
    bbox = cutout.getbbox()
    if bbox:
        cutout = cutout.crop(bbox)

    # Pad to comfortable portrait canvas on white
    cw, ch = cutout.size
    pad_x = int(cw * 0.08)
    pad_y = int(ch * 0.06)
    canvas_w = cw + pad_x * 2
    canvas_h = ch + pad_y * 2
    white = Image.new("RGB", (canvas_w, canvas_h), (255, 255, 255))
    white.paste(cutout, (pad_x, pad_y), cutout)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    white.save(OUT, format="PNG", optimize=True)
    print(f"Saved {OUT} ({canvas_w}x{canvas_h})")


if __name__ == "__main__":
    main()
