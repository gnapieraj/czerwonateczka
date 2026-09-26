# Base Midjourney — 6 miejsc i obsada

Plan Pro, Stealth włączony, strona Create na midjourney.com (nie publiczny kanał Discorda).
Wersja V8.2. Najpierw gabinet Mecenasa. Jego zwycięzca jest `--sref` dla reszty.

Format płyt do gry i strony: **PNG, 16:9**. Komiks na iPhonie i iPadzie (pion i poziom) składa dwie plansze jedna pod drugą, więc kafelek jest szeroki. Strona przycina środek (`object-fit: cover`). Ważne rzeczy trzymaj w środku kadru. Pion 2:3 zostawia puste boki na iPadzie w poziomie.
Czerwień i pieczęcie lakowe nie wchodzą do bazy. Wejdą później, po jednym przedmiocie na kadr fabuły.
Litery, cyfry i nazwa kancelarii zostają w SwiftUI.

Ogon doklejany do każdego promptu:

```
--stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, rotary telephone
```

## 1. Gabinet Mecenasa (styl całej serii)

`--ar 16:9`

```
High-contrast European ink comic of an empty fifth-floor law office at night, graphite and newsprint paper only. Dark wood desk, leather chair, full bookshelves, banker's lamp drawn in grey ink, radiator, heavy curtains. A blank smartphone lies glass-up. A plain paper envelope has a smooth flap. Through the south window, across Plac Defilad, the stepped stone tower and needle spire of the Palace of Culture, crown as a flat masonry band. Rain on the outside of the glass. The room is dry and maintained. Wide panel, bold contour, cross-hatching. --ar 16:9 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, rotary telephone, clock face
```

Po wyborze zwycięzcy skopiuj jego URL. Dalej nazywam go `SREF`.

## 2. Gabinet Partnera

`--ar 16:9` plus `--sref SREF --sw 180`

```
High-contrast European ink comic of an empty wood-paneled law office at night, graphite and newsprint paper only. Heavy desk, plain laptop lid facing the camera, leather chair. The west window looks onto the street and shows the exterior wavy glass roof of Zlote Tarasy and the long roof of Warszawa Centralna beyond it. Signs are blank grey panels. Rain on the outside of the glass. The room is dry. Bold contour, cross-hatching. --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, rotary telephone, palace of culture, skyscraper spire
```

## 3. Pokój aplikanta

`--ar 16:9` plus `--sref SREF --sw 180`

```
High-contrast European ink comic of a small modern associate office in a Warsaw law firm at night, graphite and newsprint paper only. Clean intact walls, a tidy side table, a sound chair, a short bookshelf. A laptop on the table shows its plain metal lid. The east window looks onto Marszalkowska at night: tram wires, a wet avenue, a row of maintained city blocks. Rain on the outside of the glass. The room is dry. Bold contour, cross-hatching. --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, rotary telephone, palace of culture, skyscraper spire, peeling paint, dingy walls
```

## 4. Sekretariat

`--ar 16:9` plus `--sref SREF --sw 180`

```
High-contrast European ink comic of a law-firm reception counter at night, graphite and newsprint paper only. No window. Behind the counter a closed wood door with a narrow glass sidelight and a blank nameplate. On the counter an open paper desk calendar with a blank month grid, a wooden pencil with a round rubber eraser, a small banker's lamp drawn in grey ink, and a stack of plain paper. A wall calendar is a blank grid. Bold contour, cross-hatching. --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, rotary telephone, window, city skyline
```

## 5. Korytarz kancelarii

`--ar 16:9` plus `--sref SREF --sw 180`

```
High-contrast European ink comic of an empty modern law-firm corridor on an upper floor at night, graphite and newsprint paper only. Even plaster, a wool runner, wood doors with narrow glass sidelights, blank nameplates, wall sconces in grey ink. The corridor is dry. A window at the far end shows rainy cloud and a slice of the office building across Swietokrzyska. Bold contour, cross-hatching. --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, palace of culture, skyscraper spire
```

## 6. Sala konferencyjna klienta

`--ar 16:9` plus `--sref SREF --sw 180`

```
High-contrast European ink comic of an empty modern client conference room in Warsaw at night, graphite and newsprint paper only. Long glass table, leather chairs, a large whiteboard with a blank surface, a ceiling rail of grey light. One older smartphone lies glass-up, screen blank grey. The window shows a rainy downtown street of office slabs and distant tram wires. The room is clean and dry. Bold contour, cross-hatching. --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, palace of culture, password, handwriting
```

## Postacie

Każdą personę generuj dopiero po akceptacji jej pokoju. Na początku promptu wklej URL pustego pokoju jako image prompt, z `--iw 0.45`, żeby pokój został, a doszła osoba. Styl nadal z `SREF`.

### Mecenas, tylko ręce

URL gabinetu na początku. `--ar 16:9`

```
POKOJ_MECENASA first-person ink comic, two bare lawyer hands only, white shirt cuffs, dark suit sleeves. A blank grey smartphone glass faces the camera. An iPad in a keyboard folio, blank grey screen, thin keyboard in front of it. A string-tied grey folder. The same south window and Palace of Culture needle. Rain on the outside of the glass. No face. Graphite and newsprint paper only. --iw 0.45 --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, face, portrait
```

### Filip Iglica w swoim pokoju

URL pokoju aplikanta na początku. `--ar 16:9`

```
POKOJ_APLIKANTA high-contrast ink comic portrait of Filip, a Polish man in his early twenties, round thin wire glasses, messy dark hair, freckles, white shirt, dark tie, anxious eyes, skin in grey ink. He stands in this same small modern office and holds an older smartphone, glass facing him, blank grey screen. The east window keeps Marszalkowska, tram wires and the wet avenue. Graphite and newsprint paper only. Bold contour. --iw 0.45 --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, palace of culture
```

### Partner Chropot w swoim gabinecie

URL gabinetu Partnera na początku. `--ar 16:9`

```
POKOJ_PARTNERA high-contrast ink comic portrait of a middle-aged Polish partner, receding dark hair, heavy brow, overcoat, white shirt, dark tie, stern eyes, skin in grey ink. He sits at this desk with an older smartphone at his ear and a plain laptop lid in front of him. The west window keeps the wavy glass roof of Zlote Tarasy and the station roof. Graphite and newsprint paper only. Bold contour. --iw 0.45 --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, palace of culture
```

### Irena w sekretariacie

URL sekretariatu na początku. `--ar 16:9`

```
SEKRETARIAT high-contrast ink comic portrait of Irena, a woman about forty, hair in a tight bun, rectangular glasses, dark blouse, calm face, skin in grey ink. She stands at this counter, one hand on an open paper desk calendar with a blank grid, a pencil with a rubber eraser beside it, a grey-ink banker's lamp. Her phone glass is dim grey. The closed wood door stays behind her. Graphite and newsprint paper only. Bold contour. --iw 0.45 --ar 16:9 --sref SREF --sw 180 --stylize 80 --v 8.2 --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, logo, watermark, photoreal photograph, anime, 3d render, window, city skyline, red glasses chain
```

## Kolejność

1. Włącz Stealth. Sprawdź, że nowy obraz jest prywatny.
2. Gabinet Mecenasa. Wybierz jedną planszę. To jest `SREF` na cały sezon.
3. Pokoje 2–6 z tym `--sref`.
4. Cztery płyty osób, z URL-em ich pokoju na początku.
5. Zwycięzców zapisz jako: `OfficeNight`, `PokojPartnera`, `PokojAplikanta`, `Sekretariat`, `Korytarz`, `SalaKlienta`, `MecenasPOV`, `AplikantIglica`, `PartnerChropot`, `SekretariatIrena`.

Jeśli osoba rozjedzie pokój, zmniejsz `--iw` do 0.3. Jeśli pokój zje twarz, podnieś opis twarzy i zejdź z `--iw`, a `--sw` zostaw.
