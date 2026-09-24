# Generator grafiki — Mac Studio M2 Ultra, 128 GB

To jest **jedyne** miejsce, w którym wolno puścić model obrazów. iPad i iPhone tylko odtwarzają gotowe pliki z `Assets.xcassets`.

## Co stoi na Studio

[mflux](https://github.com/filipstrand/mflux) — Flux na Apple **MLX** (Metal), nie CUDA, nie chmura. 128 GB unified memory spokojnie trzyma `flux-dev` w 8-bitach i img2img z biblii.

Spójność twarzy = **img2img z `World/bible/`**, siła ~0.32, **stały seed** na postać. Nowy prompt bez mastera = nowa twarz.

## Uruchomienie

W Terminalu, folder `CzerwonaTeczka`:

```bash
python3 tools/macos-studio/generate_noir.py --smoke
```

Smoke (`schnell`, 4 kroki) sprawdza, że MLX i waga zeszły. Potem pełny lock:

```bash
python3 tools/macos-studio/generate_noir.py
```

Jedna płyta:

```bash
python3 tools/macos-studio/generate_noir.py --job aplikant-iglica
```

Wynik: `tools/macos-studio/out/` oraz od razu `Resources/Assets.xcassets/<Asset>.imageset/`.

Pierwsze `flux-dev` ściąga kilka GB z Hugging Face (offline po cache).

## Zasady

- Nie zmieniaj `style_lock` ani seedów w `prompts.json` „dla urozmaicenia”.
- Siła img2img > 0.45 rozjeżdża twarz Iglicy i Chropota.
- Zero czytelnych liter w płycie (Flux psuje polski). Szyld, Colgante, numery teczek — tylko SwiftUI.
- Na tablicach pusto — bez Vogel, Kruk, Królewska 16, bez numeru działki.
- Panele nocy: `Night01a`…`Night12b` (dwa kadry na noc).
- Po generacji: Xcode ⌘R.

ComfyUI jest opcją, jeśli wolisz węzły.
