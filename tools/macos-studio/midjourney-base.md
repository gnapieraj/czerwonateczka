# Midjourney — baza na sezon

Plan Pro (60 USD). Stealth włączony zanim padnie pierwszy prompt.
Strona: https://www.midjourney.com/imagine (Create). Nie publiczny kanał Discorda.
Wersja: V8.2. Przyjęte wzory, ta sama ręka:

- gabinet Mecenasa: `https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png`
- gabinet Partnera: `https://cdn.midjourney.com/045bcb08-bc39-4d4e-87ba-218c21f66e77/0_3.png`
- pokój aplikanta: `https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png`
- sekretariat: `https://cdn.midjourney.com/4e94c6cf-a83e-45d3-807f-b30ad6dd16c3/0_1.png`
- korytarz: `https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png`
- sala klienta: `https://cdn.midjourney.com/e89bfce3-c8ba-40af-9ad0-a57bf48a2be7/0_1.png`
- Mecenas, tylko ręce: `https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png`
- aplikant w swoim pokoju: `https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png`
- partner w swoim gabinecie: `https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png`
- asystentka w sekretariacie: `https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png`

Styl serii trzyma plansza Mecenasa. Plansza Partnera jest dowodem, że ten przepis przenosi kreskę do innego pokoju. Nie wstawiaj jej jako drugiego `--sref`.

Czwarty opis z Describe jest osobny. Jego język wchodzi do promptów: black and white graphic illustration, comic book sketch style, strong ink outlines and shading, deszcz jako rain streaks. Proporcję `--ar 25:14` odrzucam, seria zostaje 16:9. „Soviet era skyscraper” zostaje tylko przy oknie Mecenasa, nie w gabinecie partnera.

Adres wzoru wklejasz raz, na końcu, jako `--sref`. Drugi raz na początku kopiuje układ gabinetu: regał, lampkę, zasłony i okno. Nowy pokój ma mieć inne meble. Waga `--sw 500`, `--stylize 0`. Suwak Stylization w lewo, do zera. Jeśli kreska zmięknie, podnieś `--sw` do `700`. Nie wklejaj pliku drugi raz.

Nie wgrywaj płyt Flux ani plików z `World/reference-colgante/` jako referencji stylu. Nowa seria ma powstać z opisu, nie z tamtych pikseli.

## Co odrzucasz, zanim cokolwiek zapiszesz

Plansza odpada, gdy widać którekolwiek z tych rzeczy:

- litera, cyfra, logo, znak wodny, podpis w rogu
- czerwień, pieczęć lakowa, krew
- tarcza zegara na wieży
- telefon tarczowy
- palce zlane albo napis na skórze
- łańcuszek przy okularach Ireny
- kremowy drzeworyt: gęste równoległe kreskowanie na żółtej kartce. Mocny kontur i szare cieniowanie, jak na obu wzorach, zostają

Zostawiasz planszę, gdy papier i ekrany są puste, a ważna rzecz siedzi na środku kadru.

## Format

PNG, 16:9. Najpierw czwórka (siatka). Dopiero zwycięzcę podnosisz raz: Upscale. Bez `--hd` na próbach.
Długi bok po upscale ma mieć co najmniej 1536 px. Rzeczy ważne trzymaj w środku: strona przycina środek, komiks w grze składa dwa szerokie kadry jeden pod drugim.

## Ogon

Ten ogon jest już wklejony na końcu każdego promptu poniżej. Wklej sam prompt, bez dokładania ogona drugi raz. V8.2 przyjmuje tylko jeden `--no`. Drugi `--no` kończy się błędem „Multiple --no parameters aren't supported”.

```
--ar 16:9 --stylize 50 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell
```

## 1. Gabinet Mecenasa

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png`

To jest styl całego sezonu. Prompt poniżej został już użyty. Nie wklejaj tej planszy drugi raz na początku ani w panelu.

```
High-contrast European ink comic of an empty fifth-floor law office at night in Warsaw, the reference palette only: black ink contour, cool blue-grey wash in sky rain and shadows, grey cross-hatching, small uninked paper highlights, no sepia, no brown, no yellowed newsprint, no warm cream page. Dark wood desk, leather chair, bookshelves with blank spines, a banker's lamp drawn in grey ink, a radiator, heavy curtains. A blank smartphone lies glass-up, screen flat grey. A plain envelope has a smooth flap and no mark. The south window looks slightly upward. The Palace of Culture and Science fills most of the window, close, not a distant landmark: a wide socialist-realist stone tower, stacked horizontal setbacks each narrower than the one below, a square central shaft, then a tall thin spire. Sandstone drawn in grey ink. Open parade square at its foot. No clock, no dial, no dome, no church roof, no caption in the sky. Rain on the outside of the glass. The room is dry. Wide panel, bold contour, cross-hatching, the tower centered in the window. --ar 16:9 --stylize 80 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, church, cathedral, dome, town hall, cupola
```

## 2. Gabinet Partnera

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/045bcb08-bc39-4d4e-87ba-218c21f66e77/0_3.png`

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration of an empty wood-paneled law office. Comic book sketch style with strong ink outlines and shading, rain streaks cutting across the sky, same pen as the reference image. Heavy desk, a plain metal laptop lid with no logo facing the camera, leather chair, blank paper. The west window shows the exterior wavy glass roof of Zlote Tarasy and, beyond it, the long low roof of Warszawa Centralna. Signs are empty grey panels. Rain on the outside of the glass. The room is dry. Subject centered. --iw 0.3 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 1000 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, palace of culture, skyscraper spire
```

## 3. Pokój aplikanta

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png`

```
a black and white graphic illustration of a real fifth-floor associate office in a Warsaw law firm at night, smaller than a partner suite but a proper working room with space to walk. Comic book sketch style with strong ink outlines and shading, same pen only. A full-size desk in the middle of the room, a blank laptop lid with no mark and no symbol, a padded office chair, a low two-shelf bookcase with blank spines along one wall. No person. The wide window fills the far wall and looks steeply downward from the fifth floor. Rooftops of the opposite blocks sit near the sill. Far below, a wet avenue, tram tracks and tram wires. Every shopfront and roof sign is an empty grey panel. No billboard, no neon, no word anywhere inside or outside. Thin curtains pulled aside. Rain streaks on the glass. The room is dry. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, billboard, shop sign, neon sign, wordmark, advertisement, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, palace of culture, skyscraper spire, peeling paint, dingy walls, street-level view, eye-level street, tram at the window, closet, cupboard, broom, bare cell, person, figure, seated man
```

## 4. Sekretariat

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/4e94c6cf-a83e-45d3-807f-b30ad6dd16c3/0_1.png`

```
a black and white graphic illustration of a law-firm reception counter at night, comic book sketch style with strong ink outlines and shading, same pen as the reference image. No window. Behind the counter a closed wood door with a narrow glass sidelight and a blank nameplate. On the counter an open paper desk calendar with an empty month grid, a wooden pencil with a round rubber eraser, a small banker's lamp drawn in grey ink, and a stack of plain paper. A wall calendar is an empty grid. Subject centered. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, window, city skyline, red glasses chain
```

## 5. Korytarz

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png`

```
a black and white graphic illustration of an empty modern law-firm corridor on an upper floor at night, a different room from the reference. Comic book sketch style with strong ink outlines and shading, same pen only. Even plaster, a wool runner, wood doors with narrow glass sidelights, blank nameplates, wall sconces in grey ink. No desk, no bookcase, no curtains. The corridor is dry. A window at the far end shows rainy cloud and a slice of the office building across the street. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, skyscraper spire, bookcase, desk, heavy curtains
```

## 6. Sala klienta

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/e89bfce3-c8ba-40af-9ad0-a57bf48a2be7/0_1.png`

```
a black and white graphic illustration of an empty modern client conference room in Warsaw at night, a different room from the reference. Comic book sketch style with strong ink outlines and shading, same pen only. Long glass table, leather chairs, a large whiteboard with a blank surface, a ceiling rail of grey light. One older smartphone lies glass-up, screen flat grey. No bookcase, no desk lamp, no heavy curtains. The window shows a rainy downtown street of office slabs and distant tram wires. The room is clean and dry. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, handwriting, bookcase, desk lamp, heavy curtains
```

## Postacie

Dopiero po akceptacji pustego pokoju tej osoby. Na początku wklej adres tego pokoju (image prompt), z `--iw 0.45`. Kreska zostaje na wzorze `0_3`, `--sw 1000`, `--stylize 0`.

Jeśli osoba rozjedzie pokój, zejdź do `--iw 0.3`. Jeśli pokój zje twarz, zostaw `--sw 1000` i zejdź z `--iw`.

### Mecenas, tylko ręce

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png`

Zdjęcie pustego gabinetu nie wchodzi na początek: jego kamera stoi po stronie klienta i sadza ręce naprzeciw krzesła.

```
a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person seated in the lawyer's chair, on the far side of the desk, facing the window. The chair is not in the frame because the camera sits in it. We look slightly down at our own hands on the near edge of the desk. The right hand holds a pen over blank paper. The left hand rests on a blank folder. Hands are large in the foreground, wrists low, fingers working, exactly five on each hand, unmarked skin. White shirt cuffs, dark suit sleeves. A blank grey smartphone lies flat nearby. Beyond the desk, the south window and the Palace of Culture: stacked setbacks, square shaft, thin spire, no clock. Rain on the outside of the glass. No face. No empty chair opposite. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, portrait, clock face, reaching hands, splayed fingers, claws, hovering hands, empty chair, visitor seat, client side
```

### Aplikant w swoim pokoju

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png`

Adres pokoju aplikanta na początku. Imienia nie wpisuj: model maluje je na szyldzie.

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks cutting across the sky, same pen as the reference image. A Polish man in his early twenties, round thin wire glasses, messy dark hair, freckles drawn as grey ink, white shirt, dark tie, anxious eyes. Exactly five fingers on each hand, unmarked skin, no writing on the skin. He sits in the chair beside this desk and holds an older smartphone, glass facing him, screen flat grey. The east window looks steeply down from the fifth floor: rooftops near the sill, tram tracks and wires far below. Subject centered. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 1000 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, tattoos
```

### Partner w swoim gabinecie

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png`

Adres gabinetu Partnera na początku.

```
https://cdn.midjourney.com/045bcb08-bc39-4d4e-87ba-218c21f66e77/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks cutting across the sky, same pen as the reference image. A middle-aged Polish man, receding dark hair, heavy brow, overcoat, white shirt, dark tie, stern eyes, skin in grey ink. Exactly five fingers, unmarked skin. He sits at this desk with an older smartphone at his ear and a plain laptop lid with no logo in front of him. Blank paper on the desk. The west window keeps the wavy glass roof and the long station roof. Subject centered. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 1000 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture
```

### Asystentka w sekretariacie

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png`

Stoi po swojej stronie lady. Plansza od strony klienta, z kalendarzem do niej tyłem, odpada: `https://cdn.midjourney.com/3d669bc2-6a3b-4c39-9f56-0ec66e3a0749/0_3.png`.

```
a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. No rain, no sky. The camera stands on the assistant's side of the reception counter, beside her, not on the visitor side. A woman about forty, hair in a tight bun, rectangular glasses with empty temples and no chain and no beads, dark blouse, calm face, skin in grey ink. She looks down at her own counter. The desk calendar faces her, spiral binding nearest to her, the blank page right-side up in her view. A pencil, a grey-ink banker's lamp and a stack of plain paper also face her. Her phone glass is dim grey. The closed wood door and the blank nameplate are behind her. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, window, city skyline, red glasses chain, beads, upside-down calendar, calendar facing the camera, visitor side
```

## Nazwy plików po zapisie

Przyjęte plansze leżą w `World/plates/mj/`. Kopia w grze jest w `Resources/Assets.xcassets`; spis i licencja są w `World/AssetRegistry.md`. `World/reference-colgante` to zamrożony zestaw Flux i nie wraca do katalogu.

`OfficeNight`, `PokojPartnera`, `PokojAplikanta`, `Sekretariat`, `Korytarz`, `SalaKlienta`, `MecenasPOV`, `AplikantIglica`, `PartnerChropot`, `SekretariatIrena`.

## Kadry nocy

Każda noc to dwa kadry, `Night01a` i `Night01b`, aż do `Night12b`. Zapis do `World/plates/mj/`, a przyjęta kopia do `Resources/Assets.xcassets`. Najpierw noc 1. Następną dopiero po przyjęciu obu kadrów.

Na obrazie nie ma liter. Pytanie na telefonie, tytuł pisma i kwestia w dymku są w grze, nałożone na kadr. Ekran i kartka zostają puste.

Styl: `--sref` gabinetu Mecenasa, `--sw 400`, `--stylize 0`, jeden `--no`. Osobę albo pokój wklejasz raz, na początku, jako obraz. Nie dokładaj drugiego pliku.

### Noc 1a — telefon na biurku Mecenasa

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/0ff29cc5-3b18-413a-b21e-d0ad5cde0ae8/0_0.png`. Plik: `World/plates/mj/Night01a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair. The same hands, the same desk, the Palace of Culture in the window. A blank grey smartphone lies in the near hand and shows two identical empty cards, one under the other, no letters and no icons. Rain on the glass. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 1b — Iglica mówi

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/b0b1cb1e-44a2-4630-be51-b51573820d89/0_0.png`. Plik: `World/plates/mj/Night01b.png`.

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same young man in this same office, seated, round glasses, messy hair, white shirt, dark tie. He looks up from a blank grey phone, mouth open, anxious. The window still looks down on the rooftops and the street. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

Kadry nocy są kompletne: `Night01a`…`Night12b`. Tło biurka `DeskFolders` też jest przyjęte. Zapis w `World/plates/mj/`.

### Noc 2a — dwa pliki w mailu

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/1ff47333-d0a3-4862-8141-b0c79205a6a6/0_3.png`. Plik: `World/plates/mj/Night02a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace of Culture in the window. A laptop shows a blank mail with two empty document sheets attached, one sheet slightly apart from the other. No letters, no file names. Rain on the glass. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 2b — Chropot mówi

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/45b1b222-ac4d-439e-97f6-683669c487d4/0_0.png`. Plik: `World/plates/mj/Night02b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, wavy glass roof behind him. He looks up from a laptop, mouth open, insisting. Two blank sheets of paper lie on the desk. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 3a — niejawna ugoda

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/ce153e03-0b08-411d-9f79-d9e8c3238609/0_0.png`. Plik: `World/plates/mj/Night03a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A closed string-tied folder of blank paper lies beside a laptop. The laptop shows a blank writing window, empty of words. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 3b — Iglica namawia

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/2c50c54f-26f3-44e3-b252-0405b9fd3ba9/0_0.png`. Plik: `World/plates/mj/Night03b.png`.

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same young man in this office, seated, mouth open, anxious, pushing a closed blank folder toward a laptop with an empty screen. The window looks down on the rooftops. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 4a — cztery puste pola hasła

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/f73d383e-bbac-4c73-b3e9-a97d82247b49/0_0.png`. Plik: `World/plates/mj/Night04a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A small slip of paper shows four empty boxes in a row, no marks inside them. A laptop beside it is closed. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 4b — Chropot wskazuje mail

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/6c1913fe-eaca-4c0d-8997-886dbd988c4d/0_1.png`. Plik: `World/plates/mj/Night04b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, mouth open, pointing at a laptop with a blank mail and one empty link bar. The wavy glass roof stays behind him. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 5a — tablica w sali klienta

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/b2a193ec-8540-428a-8304-430190fe2d36/0_3.png`. Plik: `World/plates/mj/Night05a.png`.

```
https://cdn.midjourney.com/e89bfce3-c8ba-40af-9ad0-a57bf48a2be7/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. This same client room, long table, empty chairs. The whiteboard holds one row of empty boxes, a marker on the rail, no writing. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, person
```

### Noc 5b — Irena w sali

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/dde3be83-74b5-4de1-96b2-467eb5180461/0_0.png`. Plik: `World/plates/mj/Night05b.png`.

Nie wklejaj zdjęcia Ireny z sekretariatu na początku. Ten plik trzyma ladę, lampkę, kalendarz i drzwi za jej plecami. Tablica wchodzi wtedy w miejsce drzwi, a ona zostaje na recepcji. Długopisu nie ma w tej scenie: ona mówi, hasło jest już na tablicy z kadru 5a. Styl tylko jako `--sref`.

```
a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. Tight close-up, head and shoulders, of the firm assistant. She fills most of the frame. A woman about forty, hair in a tight bun, rectangular glasses with empty temples and no chain and no beads, dark blouse, calm face, skin in grey ink. Mouth open as she speaks. Both hands are below the frame. No pen, no marker, no pencil. Behind her, soft and small, the client conference room: the edge of a long table, chair backs, and a whiteboard far back with one row of empty boxes. No reception desk, no lamp, no calendar, no door. No letters. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, reception counter, banker's lamp, desk lamp, desk calendar, wood door, nameplate, pen, marker, pencil, writing hand, red glasses chain, beads
```

### Noc 6a — plik z nieznanego numeru

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/f41d4b63-98ab-4253-aecd-d415242207cd/0_0.png`. Plik: `World/plates/mj/Night06a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A blank grey smartphone shows one empty file card and no name. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 6b — Chropot każe instalować

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/352ce8b0-2663-4071-b8b9-55827a67c5ce/0_2.png`. Plik: `World/plates/mj/Night06b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, mouth open, holding a blank grey phone toward the camera. The wavy glass roof stays behind him. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 7a — SMS z linkiem

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/7a08de68-baab-4131-802a-e90f52fe3e58/0_0.png`. Plik: `World/plates/mj/Night07a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A blank grey smartphone shows one empty message bubble and one empty button under it. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 7b — Irena popędza

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/d7f43400-d47a-4484-9177-451f6cf13a66/0_0.png`. Plik: `World/plates/mj/Night07b.png`.

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same woman behind her counter, bun, glasses with no chain, mouth open, holding a blank grey phone. The calendar faces her. The door stays behind her. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, window, city skyline, red glasses chain, beads
```

### Noc 8a — wyrok i pusty kod

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/24cc6c8e-d4e7-4d37-803c-773818255ff2/0_3.png`. Plik: `World/plates/mj/Night08a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. An open blank judgment lies on the desk. Beside it a sheet with one empty square of pale blocks, no digits, and a blank grey phone next to the sheet. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 8b — Chropot wskazuje kod

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/c055c32b-86cc-411f-9f9c-e14650045dc9/0_0.png`. Plik: `World/plates/mj/Night08b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, mouth open, pointing at a sheet with one empty square of pale blocks. The wavy glass roof stays behind him. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 9a — słuchawka

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/09f76005-6a46-4c23-9b1d-85725c42f39f/0_0.png`. Plik: `World/plates/mj/Night09a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. One hand holds a blank grey smartphone to the side of the head. The other hand rests on blank paper. No face. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, portrait, clock face
```

### Noc 9b — Iglica o rachunku

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/7766d5da-338a-44c1-b0a1-6e56add8d7de/0_1.png`. Plik: `World/plates/mj/Night09b.png`.

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same young man in this office, seated, mouth open, worried, a blank grey phone in his hand. The window looks down on the rooftops. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 10a — puste okno programu

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/a70533d2-4599-47ca-944c-3cba6a91b5ea/0_2.png`. Plik: `World/plates/mj/Night10a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A laptop shows one empty dialog: a blank page behind it and two empty buttons, no words. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### Noc 10b — Iglica o pozwie

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/d6b8cfcb-3043-4bd3-8e39-63ff2c1a3ac6/0_2.png`. Plik: `World/plates/mj/Night10b.png`.

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same young man in this office, seated, mouth open, urgent, pointing at a laptop with an empty dialog. The window looks down on the rooftops. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 11a — Irena o skrzynce

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/166e8f04-5a13-48e7-9540-b22184152994/0_0.png`. Plik: `World/plates/mj/Night11a.png`.

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same woman behind her counter, mouth open, calm, one hand on a laptop that shows an empty list of rows, no words. The calendar faces her. The door stays behind her. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, window, city skyline, red glasses chain, beads
```

### Noc 11b — Chropot o ciągłości

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/d2db4c3a-518c-46b0-bb16-cd07a4fd2b10/0_1.png`. Plik: `World/plates/mj/Night11b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, mouth open, a closed blank folder in his hand. The wavy glass roof stays behind him. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### Noc 12a — ekran żądania

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/05a3b7d0-1459-4afb-9abe-8a080d61312a/0_1.png`. Plik: `World/plates/mj/Night12a.png`.

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. First person in the lawyer's chair, the Palace in the window. A laptop screen is a flat grey field with one empty panel in the center and a simple padlock drawn in grey ink, no words and no coins. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face, bitcoin, currency
```

### Noc 12b — Chropot o zapłacie

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/abb011b8-a918-4ac4-b203-e7a78d93e8f9/0_0.png`. Plik: `World/plates/mj/Night12b.png`.

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference image. The same stern man at this desk, mouth open, tense, a laptop in front of him with a flat grey screen and a small padlock, no words. The wavy glass roof stays behind him. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, bitcoin, currency
```

Tło wokandy jest przyjęte. To nie jest noc.

### Biurko — tło wokandy

Przyjęta plansza, nie generuj jej ponownie: `https://cdn.midjourney.com/477d7a9a-a40b-4938-8a04-39c42c232f73/0_3.png`. Plik: `World/plates/mj/DeskFolders.png`.

```
a black and white graphic illustration of a lawyer's desk seen from above, comic book sketch style with strong ink outlines and shading, same pen as the reference image. Stacks of blank folders, a pen, a blank sheet, no stamps and no words. Graphite and cool grey only. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```
