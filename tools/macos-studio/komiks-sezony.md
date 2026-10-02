# Komiks dwóch sezonów — prompty, kwestie, analiza

Stan: 29.09.2026. To nie jest porada prawna. To robocza księga do Midjourney i do generatora nocy.

Wklejasz na https://midjourney.com/imagine (Create), Stealth włączony, V8.2. Jeden prompt, jeden `--no`.

Przyjęta płyta ląduje raz: `Resources/Assets.xcassets/<nazwa>.imageset/<nazwa>.png`. Spis jest tylko w `World/AssetRegistry.md`. Sezon 1 ma nazwy `Night13a`–`Night24b`, piksele to jeszcze kopia `SezonMecenas.png`, na kadrze flaga „W przygotowaniu”.

Jedna noc, jeden blok. Nad parą kadrów jest kontekst po polsku: co czyta gracz, termin, pytanie i oba napisy. Nad każdym promptem jest komentarz HTML `card`. Do Midjourney wklejasz tylko szary blok pod komentarzem. `context_pl` i `caption_pl` są treścią nocy i napisem SwiftUI. `paint_caption: no` znaczy, że tego tekstu nie ma na rysunku. `pass` to obraz, który zostaje. `fail` każe poprawić albo powtórzyć czwórkę. `caption_in_game_pl` i `game_asset` są napisem i nazwą pliku, które gra czyta teraz.

Odrzucasz planszę, gdy widać literę, cyfrę, logo, czerwień, pieczęć, krew, tarczę zegara, telefon tarczowy, zlane palce, łańcuszek przy okularach, mozaikę pikseli albo pasek cenzury z napisem. Twarz mecenasa jest czarną plamą tuszu, nie rozmyciem ze zdjęcia.

## Głosy

Iglica mówi szybko, boi się listy, szuka pozwolenia. Chropot mówi krótko, w trybie rozkazującym, bez pocieszenia. Irena mówi spokojnie i robi z błędu porządek kancelarii. Żadna kwestia nie zdradza werdyktu.

Nowe kwestie są w `tools/build_lessons.py` i w grze.

## 1. Wybór sezonu — wklej najpierw te dwa

Lewa połowa: mecenas, twarz schowana w tuszu, bo gracz nigdy nie dostaje jego twarzy. Prawa: aplikant z twarzą, którą już znamy (okulary, rozczochrane włosy). Dwie czarne głowy nie dadzą się odróżnić na biurku. Napisy „Sezon 0 / Mecenas” i „Sezon 1 / Aplikant” zostają w SwiftUI.

Pliki po akceptacji: `SezonMecenas.png`, `SezonAplikant.png`. Biblia bierze te plakaty oraz `Night04b` i `Night05b`. Starsze portrety z 28.09 są usunięte. Gabinet i biurko wokandy jeszcze nie istnieją w nowej serii: sekcja niżej.

Jeśli aplikant usiądzie z powrotem, zejdź z `--iw` do `0.3`. Jeśli pokój zje twarz, zostań przy `0.4` i nie dokładaj drugiego obrazu.

### Sezon 0 — mecenas, świadek w tuszu

<!-- card
asset: SezonMecenas
lesson: none
panel: season
file: SezonMecenas.png
story: Season choice, left half. The player is counsel. The face is never shown.
context_pl: none. This plate is the season switch, not a night.
caption_pl: none. SwiftUI draws the season label. Do not paint it.
paint_caption: no
who: a man in his forties in a dark suit, white shirt, dark tie; the face is a solid black ink field with no features
where: fifth-floor Warsaw office at night; the Palace of Culture fills the window behind his shoulder
gesture: stands three-quarter length, large, left of center
props: pen over blank paper; closed blank folder under the other hand
pass: face is solid black ink, not a blur and not a mosaic; suit and hands stay readable; five fingers; palace has stacked setbacks, a square shaft, a thin spire, and no clock; rain outside, room dry
fail: a readable face, eyes, mouth, or ears; letters of any season title; the associate; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks, same pen as the reference, cool grey wash, bold contour. Wide poster panel of this fifth-floor Warsaw law office at night. A Polish man in his forties stands three-quarter length, dark suit, white shirt, dark tie. His face is a solid field of black ink: no eyes, no nose, no mouth, no ears, no skin on the face, a protected witness drawn in ink, not a photo blur, not a pixel mosaic, not a bar across the eyes. Suit, collar, hands and posture stay readable. Exactly five fingers on each hand, unmarked skin. One hand holds a pen above blank paper. The other rests on a closed blank folder. The Palace of Culture fills the window behind his shoulder: stacked setbacks, square shaft, thin spire, grey ink, no clock. Rain on the outside of the glass. The room is dry. He is large, left of center. --iw 0.28 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 700 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, church, cathedral, dome
```

### Sezon 1 — aplikant, twarz czytelna

<!-- card
asset: SezonAplikant
lesson: none
panel: season
file: SezonAplikant.png
story: Season choice, right half. The player will be the associate. His face is the known one.
context_pl: none. This plate is the season switch, not a night.
caption_pl: none. SwiftUI draws the season label. Do not paint it.
paint_caption: no
who: the same young man, early twenties, round wire glasses, messy dark hair, freckles in grey ink, white shirt, loosened dark tie, anxious eyes, face visible
where: his smaller fifth-floor office; the east window looks steeply down to rooftops and tram wires
gesture: stands, he is not sitting, large, right of center
props: older smartphone, glass toward him, screen flat grey; closed blank folder against his ribs
pass: face visible and matching the associate reference; he is standing; five fingers; signs are empty grey panels
fail: a seated pose; the Palace of Culture; a blacked-out face; letters of any season title; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks, same pen as the reference, cool grey wash, bold contour. Wide poster panel. The same young Polish man, early twenties, round thin wire glasses, messy dark hair, freckles as grey ink, white shirt, dark tie loosened, anxious eyes, skin in grey ink. He stands, he is not sitting, at the east window of his smaller fifth-floor office. Exactly five fingers, unmarked skin, nothing written on the skin. One hand holds an older smartphone, glass toward him, screen flat grey. The other arm holds a closed blank folder to his ribs. The window looks steeply down: rooftops near the sill, tram tracks and wires far below, every sign an empty grey panel. Rain on the glass. The room is dry. His face stays visible and matches the reference. He is large, right of center. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 700 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, skyscraper spire, seated man, sitting
```

Gdy obie połowy mają być incognito, drugi przebieg aplikanta: w tym samym prompcie zamień zdanie o twarzy na „his face is a solid field of black ink, no eyes, no features, the round glasses still visible as a thin wire shape over the black”. Zostaw okulary. Bez nich sezon 1 ginie.

## 1b. Gabinet i biurko

`Gabinet` i `Biurko` są przyjęte i leżą w katalogu gry. Prompty zostają, gdy trzeba wygenerować płytę ponownie. Styl bierze plakat mecenasa.

### Gabinet — pusty pokój mecenasa

Biblia wizualna, ekran tytułowy i tło sceny. Żadnej osoby. Pałac w oknie, deszcz na szybie, pusty szyld.

<!-- card
asset: Gabinet
lesson: none
panel: place
file: Gabinet.png
story: The fifth-floor office with nobody in it. The Palace is in the window. The firm name is drawn by the app, not by the picture.
context_pl: none. This plate is the place in the visual bible and the title screen, not a night.
caption_pl: none. SwiftUI draws the firm name and the Palace line. Do not paint them.
paint_caption: no
who: nobody
where: fifth-floor Warsaw office at night, empty chair, desk in the foreground, blinds half open
gesture: none
props: one closed blank folder, a pen, empty leather chair turned to the window, a flat grey wall plaque with no letters
pass: no person and no hands; palace has stacked setbacks, a square shaft, a thin spire, and no clock; rain outside, room dry
fail: any person, face, or hand; letters on the plaque; a clock on the tower; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f921f941-c5ab-40fd-9a2a-24dd6d769a45/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks, same pen as the reference, cool grey wash, bold contour. Empty fifth-floor Warsaw law office at night, no person, no hands. A dark wooden desk in the foreground, one closed blank folder, a pen, an empty leather chair turned toward the window. Venetian blinds half open. Through the window the Palace of Culture in the rain: stacked setbacks, square shaft, thin spire, grey ink, no clock face. Rain on the outside of the glass. The room is dry. On the wall a blank plaque, flat grey, no letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f921f941-c5ab-40fd-9a2a-24dd6d769a45/0_1.png --sw 500 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, face, person, hand, fingers, man, woman
```

### Biurko — blat pod wokandą

Tło biurka, mocno przyciemnione. Żadnej osoby. Teczki puste, bez pieczęci i bez numerów.

<!-- card
asset: Biurko
lesson: none
panel: desk
file: Biurko.png
story: The docket background. Blank folders on the counsel's desk. Numbers and stamps are drawn by the app.
context_pl: none. This plate sits behind the habit strip and the docket, not inside a night.
caption_pl: none. Do not paint a caption.
paint_caption: no
who: nobody
where: the same night office, seen slightly from above, only the desktop
gesture: none
props: three stacks of blank folders, one loose blank sheet, a pen
pass: no person and no hands; folders are blank; graphite and cool grey only
fail: a wax seal, a red mark, a number, a letter; a face or a hand; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f921f941-c5ab-40fd-9a2a-24dd6d769a45/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A lawyer's desk at night, seen slightly from above, no person, no hands. Three stacks of blank folders, one closed blank folder, a pen, one loose blank sheet. Graphite and cool grey only. No stamps and no seals. A dark strip of rainy window only at the top edge. --iw 0.2 --ar 16:9 --sref https://cdn.midjourney.com/f921f941-c5ab-40fd-9a2a-24dd6d769a45/0_1.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, hand, person, man, woman, clock face, rotary telephone, pixel mosaic, censor bar, blur filter
```


## 2. Dlaczego sezon 0 trzeba ruszyć

Dziewięć kadrów „a” to te same ręce, to samo biurko, ten sam Pałac: noce 1, 2, 3, 4, 6, 7, 8, 10, 12. Noc 9 dokłada tylko słuchawkę. Gracz uczy się mebla, nie gestu. Zostawiamy kreskę i Pałac tam, gdzie okno jest naprawdę oknem mecenasa. Zmieniamy odległość, ręce i pokój.

Zasada pary: kadr A jest rzeczą i gestem, który gracz ma powstrzymać. Kadr B jest człowiekiem, który naciska, w innym miejscu niż A. Iglica nie wraca sześć razy do tego samego krzesła. Chropot nie wskazuje palcem w tym samym kadrze. Irena raz jest z bliska, raz w drzwiach, raz przy cudzym telefonie.

Plakat konferencyjny to któryś z tych kadrów, wydrukowany bez dopisanego tytułu. Litery dokładamy na planszy obok, nie w Midjourney. Najmocniejsze do druku: sezon 0, sezon 1, noc 12a (kabel), noc 18a (kurier), noc 24a (ława).

Ogon nocy jest krótszy w wadze stylu (`--sw 400`), żeby twarz i gest nie zginęły w meblach. Gdy kreska zmięknie, podnieś do `500`, nie dokładaj drugiego obrazu.

## 3. Sezon 0 — nowe pary

Adres na początku jest wzorem osoby albo pokoju. Nie wklejaj go drugi raz.

#### Noc 1 · `01-kod` · Drugie zatwierdzenie

Sezon 0. Termin: Rozprawa za cztery minuty. Pytanie: Które pytanie na telefonie jest twoim logowaniem?

Kontekst, który czyta gracz:

> Wchodzisz do portalu sądu ze swojego telefonu i wpisujesz hasło. Telefon pyta: „Czy zatwierdzić logowanie?”. Zatwierdzasz. Minutę później przychodzi drugie, takie samo pytanie. Iglica mówi, że to Chropot z sali rozpraw: nie może się zalogować i prosi, żebyś zatwierdził też to drugie.

Kadr A `Night01a`, napis w grze, nie malować: Hasło wpisane. Na telefonie dwa pytania: „Czy zatwierdzić logowanie?”.

Kadr B `Night01b`, kwestia do wklejenia w grę, nie malować: Iglica: „Chropot stoi na sali i nie wejdzie. Zatwierdź drugie, bo za moment nas wywołają.”

### 01a `Night01a` — dwa puste karty, z bliska

<!-- card
asset: Night01a
lesson: 01-kod
panel: a
file: Night01a.png
story: One password produced one approval prompt. A second identical prompt is someone else's sign-in.
context_pl: Wchodzisz do portalu sądu ze swojego telefonu i wpisujesz hasło. Telefon pyta: „Czy zatwierdzić logowanie?”. Zatwierdzasz. Minutę później przychodzi drugie, takie samo pytanie. Iglica mówi, że to Chropot z sali rozpraw: nie może się zalogować i prosi, żebyś zatwierdził też to drugie.
caption_pl: Hasło wpisane. Na telefonie dwa pytania: „Czy zatwierdzić logowanie?”.
caption_in_game_pl: Hasło wpisane. Na telefonie dwa pytania: „Czy zatwierdzić logowanie?”.
game_asset: Night01a
paint_caption: no
who: the lawyer's hands only, white cuff, dark sleeve, no face
where: tight close-up; the Palace of Culture is only a narrow slice
gesture: one hand holds a phone that fills the frame
props: blank grey smartphone; two identical empty cards, one under the other, no icons
pass: exactly two empty cards stacked; five fingers; no face
fail: any mark inside the cards; a readable question; a wide shot of the whole desk; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. An open laptop alone on a dark desk. The screen shows one clear small grey padlock and soft blurred illegible text blocks, no sharp readable letters, no coins, no bitcoin. No cables of any kind. No hand. Through the window: blank rain or dark glass only, no landmark tower. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, sharp letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, hand, cable, ethernet, power cable, charger, MagSafe, Palace of Culture, palace of culture, landmark tower, city skyline, clock face, bitcoin, currency, coins
```

### 01b `Night01b` — Iglica w drzwiach, nie przy swoim biurku

<!-- card
asset: Night01b
lesson: 01-kod
panel: b
file: Night01b.png
story: The trainee pressures counsel to approve the second prompt, claiming the partner is locked out of court.
context_pl: Wchodzisz do portalu sądu ze swojego telefonu i wpisujesz hasło. Telefon pyta: „Czy zatwierdzić logowanie?”. Zatwierdzasz. Minutę później przychodzi drugie, takie samo pytanie. Iglica mówi, że to Chropot z sali rozpraw: nie może się zalogować i prosi, żebyś zatwierdził też to drugie.
caption_pl: Iglica: „Chropot stoi na sali i nie wejdzie. Zatwierdź drugie, bo za moment nas wywołają.”
caption_in_game_pl: Iglica: „Chropot stoi na sali i nie wejdzie. Zatwierdź drugie, bo za moment nas wywołają.”
game_asset: Night01b
paint_caption: no
who: the associate, round glasses, messy hair, white shirt, dark tie, anxious, mouth open
where: standing in a doorway, a slice of corridor behind him, not his own desk
gesture: leaning in, one hand on the door frame, the other holding a phone
props: blank grey phone, screen flat grey
pass: he is standing in a doorway; five fingers; urgent open mouth
fail: seated at his own desk; the Palace as the subject; letters in a balloon; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same young man, round glasses, messy hair, white shirt, dark tie, anxious. He is standing in a doorway, leaning in, one hand on the door frame, mouth open, urgent. A blank grey phone is in his other hand, screen flat grey. Behind him a slice of corridor, not his own desk. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, seated, sitting
```

#### Noc 2 · `02-list` · Doklejone pismo

Sezon 0. Termin: Termin doręczenia dziś. Pytanie: Który plik otwierasz?

Kontekst, który czyta gracz:

> Chropot przesyła dalej mail od sądu w twojej sprawie. Do tej wiadomości sam dołączył drugi plik PDF o nazwie „uzupełnienie opłaty”. Mówi, że dopisał go ręcznie, bo portal sądu działa wolno, i że masz otworzyć oba pliki, bo sygnatura się zgadza.

Kadr A `Night02a`, napis w grze, nie malować: Mail od Chropota: pismo sądu i drugi PDF, „uzupełnienie opłaty”.

Kadr B `Night02b`, kwestia do wklejenia w grę, nie malować: Chropot: „Portal zdycha. Sygnatura się zgadza, otwórz oba, nie mamy dnia.”

### 02a `Night02a` — dwa arkusze rozchodzą się w dłoniach

<!-- card
asset: Night02a
lesson: 02-list
panel: a
file: Night02a.png
story: A forwarded court mail carries the court's paper plus a second file the partner attached.
context_pl: Chropot przesyła dalej mail od sądu w twojej sprawie. Do tej wiadomości sam dołączył drugi plik PDF o nazwie „uzupełnienie opłaty”. Mówi, że dopisał go ręcznie, bo portal sądu działa wolno, i że masz otworzyć oba pliki, bo sygnatura się zgadza.
caption_pl: Mail od Chropota: pismo sądu i drugi PDF, „uzupełnienie opłaty”.
caption_in_game_pl: Mail od Chropota: pismo sądu i drugi PDF, „uzupełnienie opłaty”.
game_asset: Night02a
paint_caption: no
who: two hands only, no face
where: close on the desk; the Palace is small, not the subject
gesture: the hands pull two blank sheets apart, one slipping free
props: two blank sheets; a laptop with an empty mail window
pass: two sheets separating; empty mail window; five fingers
fail: file names or a case number on the sheets; a single sheet only; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Close on two hands pulling two blank sheets apart, one sheet slipping free of the other. A laptop behind them shows an empty mail window, no words. Exactly five fingers, unmarked skin. The Palace is a small shape in the window, not the subject. Rain. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 02b `Night02b` — Chropot stoi, płaszcz na ramionach

<!-- card
asset: Night02b
lesson: 02-list
panel: b
file: Night02b.png
story: The partner insists both files be opened because the case number matches and the portal is slow.
context_pl: Chropot przesyła dalej mail od sądu w twojej sprawie. Do tej wiadomości sam dołączył drugi plik PDF o nazwie „uzupełnienie opłaty”. Mówi, że dopisał go ręcznie, bo portal sądu działa wolno, i że masz otworzyć oba pliki, bo sygnatura się zgadza.
caption_pl: Chropot: „Portal zdycha. Sygnatura się zgadza, otwórz oba, nie mamy dnia.”
caption_in_game_pl: Chropot: „Portal zdycha. Sygnatura się zgadza, otwórz oba, nie mamy dnia.”
game_asset: Night02b
paint_caption: no
who: the partner, receding hair, heavy brow, overcoat still on, white shirt, dark tie, mouth open
where: his office, only a slice of the wavy glass roof
gesture: standing, not seated, pushing a laptop toward the camera
props: laptop; two blank sheets between him and the lens
pass: he is standing with the coat on; five fingers
fail: seated and only pointing; letters on the sheets; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern middle-aged man, receding hair, heavy brow, overcoat still on, white shirt, dark tie. He is standing, not seated, pushing a laptop across the desk toward the camera, mouth open, insisting. Two blank sheets lie between him and the lens. The wavy glass roof is only a slice behind him. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, seated, sitting
```

#### Noc 3 · `03-prompt` · Ugoda w asystencie

Sezon 0. Termin: Ugoda przed północą. Pytanie: Co z tej ugody wklejasz do asystenta?

Kontekst, który czyta gracz:

> Kancelaria ma firmowego asystenta do pisania pism. Jest umowa z dostawcą, a IT mówi, że program nie uczy się na waszych tekstach. W schowku kopiuj-wklej leży projekt ugody, której klient jeszcze nie widział: nazwy stron, kwota i sygnatura sprawy.

Kadr A `Night03a`, napis w grze, nie malować: Projekt ugody jest jeszcze niejawny. Rada klienta czyta go rano.

Kadr B `Night03b`, kwestia do wklejenia w grę, nie malować: Iglica: „IT mówi, że program się nie uczy. Wklej ugodę, rada czyta rano.”

### 03a `Night03a` — teczka zamknięta, dłonie cofnięte

<!-- card
asset: Night03a
lesson: 03-prompt
panel: a
file: Night03a.png
story: A draft settlement the client has not seen sits beside the firm assistant. It must not be pasted in.
context_pl: Kancelaria ma firmowego asystenta do pisania pism. Jest umowa z dostawcą, a IT mówi, że program nie uczy się na waszych tekstach. W schowku kopiuj-wklej leży projekt ugody, której klient jeszcze nie widział: nazwy stron, kwota i sygnatura sprawy.
caption_pl: Projekt ugody jest jeszcze niejawny. Rada klienta czyta go rano.
caption_in_game_pl: Projekt ugody jest jeszcze niejawny. Rada klienta czyta go rano.
game_asset: Night03a
paint_caption: no
who: two hands only, no face
where: the lawyer's desk; the Palace is small
gesture: hands hover above a closed folder and do not touch the keys
props: closed string-tied folder of blank paper; laptop with an empty writing window
pass: folder stays closed; hands off the keyboard; five fingers
fail: hands typing the settlement into the laptop; writing on the paper; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A closed string-tied folder of blank paper sits beside a laptop. The laptop shows an empty writing window. Two hands hover above the folder and do not touch the keys. Exactly five fingers, unmarked skin. Palace small in the window. Rain. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 03b `Night03b` — Iglica w pół kroku, teczka w ruchu

<!-- card
asset: Night03b
lesson: 03-prompt
panel: b
file: Night03b.png
story: The trainee says IT promised the program does not learn, and pushes the draft toward the machine.
context_pl: Kancelaria ma firmowego asystenta do pisania pism. Jest umowa z dostawcą, a IT mówi, że program nie uczy się na waszych tekstach. W schowku kopiuj-wklej leży projekt ugody, której klient jeszcze nie widział: nazwy stron, kwota i sygnatura sprawy.
caption_pl: Iglica: „IT mówi, że program się nie uczy. Wklej ugodę, rada czyta rano.”
caption_in_game_pl: Iglica: „IT mówi, że program się nie uczy. Wklej ugodę, rada czyta rano.”
game_asset: Night03b
paint_caption: no
who: the associate, glasses, messy hair, loosened tie, anxious, mouth open
where: his office, window looking down on rooftops
gesture: standing, mid-step, pushing a closed folder toward a laptop
props: closed blank folder; laptop with an empty screen
pass: he is on his feet; the folder is still closed; five fingers
fail: seated; an open document full of writing; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same young man stands, mid-step, pushing a closed blank folder toward a laptop with an empty screen. Mouth open, anxious, tie loosened. Round glasses, messy hair. The window looks down on rooftops. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, seated, sitting
```

#### Noc 4 · `04-haslo` · Hasło przed radą

Sezon 0. Termin: Rada za dwadzieścia minut. Pytanie: Jak przekazać klientowi te cztery słowa?

Kontekst, który czyta gracz:

> Klient ma wejść do pokoju danych, czyli na stronę, na którą wrzuca dokumenty do sprawy. Link do tej strony już wysłałeś mailem. Nowe hasło to cztery zwykłe słowa, zapisane na kartce na biurku. Klient ich nie zna. Rada siada za dwadzieścia minut i nikt nie odbiera telefonu. Chropot chce, żebyś odpisał w tym samym mailu i wpisał te cztery słowa pod linkiem.

Kadr A `Night04a`, napis w grze, nie malować: Mail z linkiem już poszedł. Na kartce leżą cztery słowa nowego hasła.

Kadr B `Night04b`, kwestia do wklejenia w grę, nie malować: Chropot: „Rada siada za dwadzieścia minut. Wpisz te cztery słowa pod linkiem.”

### 04a `Night04a` — kartka i telefon leżą osobno

<!-- card
asset: Night04a
lesson: 04-haslo
panel: a
file: Night04a.png
story: The data-room link already went by email. The new password is four words that must not travel in that mail.
context_pl: Klient ma wejść do pokoju danych, czyli na stronę, na którą wrzuca dokumenty do sprawy. Link do tej strony już wysłałeś mailem. Nowe hasło to cztery zwykłe słowa, zapisane na kartce na biurku. Klient ich nie zna. Rada siada za dwadzieścia minut i nikt nie odbiera telefonu. Chropot chce, żebyś odpisał w tym samym mailu i wpisał te cztery słowa pod linkiem.
caption_pl: Mail z linkiem już poszedł. Na kartce leżą cztery słowa nowego hasła.
caption_in_game_pl: Mail z linkiem już poszedł. Na kartce leżą cztery słowa nowego hasła.
game_asset: Night04a
paint_caption: no
who: hands resting away from both objects, no face
where: the lawyer's desk; the Palace is small
gesture: a wide gap of bare wood separates the slip from the phone
props: a slip with four empty boxes; a smartphone lying face down, far from the slip
pass: four empty boxes; phone face down; a visible gap between them; five fingers
fail: marks inside the boxes; the phone face up next to the slip; words on the slip; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. On the desk a small slip shows four empty boxes in a row, no marks inside. Far from the slip, a blank grey smartphone lies face down. A wide gap of bare wood is between them. Hands rest away from both. Exactly five fingers. Palace small. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 04b `Night04b` — Chropot, słuchawka, kartka między wami

<!-- card
asset: Night04b
lesson: 04-haslo
panel: b
file: Night04b.png
story: The partner orders the four words typed under the link because the board sits in twenty minutes.
context_pl: Klient ma wejść do pokoju danych, czyli na stronę, na którą wrzuca dokumenty do sprawy. Link do tej strony już wysłałeś mailem. Nowe hasło to cztery zwykłe słowa, zapisane na kartce na biurku. Klient ich nie zna. Rada siada za dwadzieścia minut i nikt nie odbiera telefonu. Chropot chce, żebyś odpisał w tym samym mailu i wpisał te cztery słowa pod linkiem.
caption_pl: Chropot: „Rada siada za dwadzieścia minut. Wpisz te cztery słowa pod linkiem.”
caption_in_game_pl: Chropot: „Rada siada za dwadzieścia minut. Wpisz te cztery słowa pod linkiem.”
game_asset: Night04b
paint_caption: no
who: the partner, overcoat, mouth open, phone at his ear
where: reception lobby, visitor side of the counter; conference-room door behind him behind, half risen from the chair
gesture: the slip lies on the desk between him and the camera
props: older smartphone at his ear; slip with four empty boxes
pass: four empty boxes; he is half risen; five fingers
fail: words inside the boxes; him calmly seated with no phone; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man, overcoat, mouth open, an older smartphone at his ear. On the desk between him and the camera lies the slip with four empty boxes, no marks. He is half risen from the chair. Wavy glass roof behind. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

#### Noc 5 · `05-arkusz` · Hasło klienta

Sezon 0. Termin: Kontrola jutro rano. Pytanie: Gdzie zapisujesz to hasło na noc?

Kontekst, który czyta gracz:

> We dwóch wchodzicie do starego systemu klienta, tego, w którym trzymają swoje dokumenty. Hasło jest napisane mazakiem na tablicy w ich sali konferencyjnej. Jutro kontroler czyta chronologię sprawy w aktach kancelarii. Irena chce, żebyś wpisał to hasło do chronologii, „żeby akta były kompletne”.

Kadr A `Night05a`, napis w grze, nie malować: Tablica w sali klienta. Mazakiem napisane hasło do ich systemu.

Kadr B `Night05b`, kwestia do wklejenia w grę, nie malować: Irena: „Kontroler jutro czyta chronologię. Bez hasła akta są dziurawe.”

### 05a `Night05a` — tablica, telefon opuszczony

<!-- card
asset: Night05a
lesson: 05-arkusz
panel: a
file: Night05a.png
story: The client's system password is written on their conference whiteboard. It is not part of the file.
context_pl: We dwóch wchodzicie do starego systemu klienta, tego, w którym trzymają swoje dokumenty. Hasło jest napisane mazakiem na tablicy w ich sali konferencyjnej. Jutro kontroler czyta chronologię sprawy w aktach kancelarii. Irena chce, żebyś wpisał to hasło do chronologii, „żeby akta były kompletne”.
caption_pl: Tablica w sali klienta. Mazakiem napisane hasło do ich systemu.
caption_in_game_pl: Tablica w sali klienta. Mazakiem napisane hasło do ich systemu.
game_asset: Night05a
paint_caption: no
who: one hand only, no full figure and no face
where: the client conference room, long table, empty chairs
gesture: the phone is held down by the hip, not raised to photograph the board
props: whiteboard with one row of empty boxes; marker on the rail; blank grey phone lowered
pass: empty boxes only; phone pointed down; five fingers
fail: writing on the board; the phone aimed at the board; a person posing for a photo; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/e89bfce3-c8ba-40af-9ad0-a57bf48a2be7/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The client conference room, long table, empty chairs. The whiteboard holds one row of empty boxes and a marker on the rail, no writing. In the near corner a hand holds a blank grey phone down by the hip, not raised to photograph the board. Exactly five fingers. No letters. No full figure. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 05b `Night05b` — Irena z bliska, bez lady

Zostaw kompozycję, którą już przyjąłeś, jeśli twarz i tablica są czyste. Nowy przebieg tylko wtedy, gdy tablica weszła w drzwi sekretariatu.

<!-- card
asset: Night05b
lesson: 05-arkusz
panel: b
file: Night05b.png
story: The assistant wants that password typed into the chronology so a reviewer sees a complete file.
context_pl: We dwóch wchodzicie do starego systemu klienta, tego, w którym trzymają swoje dokumenty. Hasło jest napisane mazakiem na tablicy w ich sali konferencyjnej. Jutro kontroler czyta chronologię sprawy w aktach kancelarii. Irena chce, żebyś wpisał to hasło do chronologii, „żeby akta były kompletne”.
caption_pl: Irena: „Kontroler jutro czyta chronologię. Bez hasła akta są dziurawe.”
caption_in_game_pl: Irena: „Kontroler jutro czyta chronologię. Bez hasła akta są dziurawe.”
game_asset: Night05b
paint_caption: no
who: the assistant, about forty, tight bun, rectangular glasses with no chain, dark blouse, calm, mouth open
where: tight head-and-shoulders; soft conference room and whiteboard behind her
gesture: speaking; both hands below the frame
props: whiteboard far back with one row of empty boxes
pass: close-up of her face; empty glasses temples; empty boxes behind; no pen
fail: a reception counter, lamp, calendar, or door; a glasses chain; a marker in her hand; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Tight close-up, head and shoulders, of the firm assistant. A woman about forty, hair in a tight bun, rectangular glasses with empty temples and no chain and no beads, dark blouse, calm face, skin in grey ink, mouth open. Both hands below the frame. Behind her, soft, the edge of a long conference table and a whiteboard with one row of empty boxes. No reception desk, no lamp, no calendar, no door. No letters. --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, reception counter, banker's lamp, desk calendar, wood door, nameplate, pen, marker, pencil, red glasses chain, beads
```

#### Noc 6 · `06-pomoc` · Program w trakcie awarii

Sezon 0. Termin: Wokanda za dziesięć minut. Pytanie: Której instrukcji słuchasz?

Kontekst, który czyta gracz:

> Poczta nie działa. W zgłoszeniu, które sam założyłeś u informatyków kancelarii, jest napisane: awaria jest na serwerze poczty, laptopy są sprawne, nic nie instalować. Osobno pisze administrator, którego znasz, z numeru, którego nie masz w telefonie. Pisze, że zgubił służbowy telefon i przysyła program do zdalnej naprawy, ten sam co w marcu.

Kadr A `Night06a`, napis w grze, nie malować: Zgłoszenie: nic nie instalować. Na telefonie plik z nieznanego numeru.

Kadr B `Night06b`, kwestia do wklejenia w grę, nie malować: Chropot: „W marcu ten plik nas podniósł. Instaluj, sala nie czeka.”

### 06a `Night06a` — laptop zamknięty, plik na telefonie

<!-- card
asset: Night06a
lesson: 06-pomoc
panel: a
file: Night06a.png
story: The firm's own ticket says the outage is the mail server and to install nothing. A new number sends a program.
context_pl: Poczta nie działa. W zgłoszeniu, które sam założyłeś u informatyków kancelarii, jest napisane: awaria jest na serwerze poczty, laptopy są sprawne, nic nie instalować. Osobno pisze administrator, którego znasz, z numeru, którego nie masz w telefonie. Pisze, że zgubił służbowy telefon i przysyła program do zdalnej naprawy, ten sam co w marcu.
caption_pl: Zgłoszenie: nic nie instalować. Na telefonie plik z nieznanego numeru.
caption_in_game_pl: Zgłoszenie: nic nie instalować. Na telefonie plik z nieznanego numeru.
game_asset: Night06a
paint_caption: no
who: one hand pulled back, no face
where: the lawyer's desk; the Palace is small
gesture: the hand does not touch the phone
props: closed laptop lid with no logo; phone showing one empty file card; a blank ticket slip under the laptop
pass: laptop closed; one empty file card; hand withdrawn; five fingers
fail: a name on the file card; the hand tapping install; an open installer window; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A laptop lid is closed, plain metal, no logo. Beside it a blank grey smartphone shows one empty file card, no name. A hand is pulled back, not touching the phone. Exactly five fingers. A blank ticket slip lies under the laptop. Palace small. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 06b `Night06b` — Chropot w korytarzu sądu, telefon wyciągnięty

<!-- card
asset: Night06b
lesson: 06-pomoc
panel: b
file: Night06b.png
story: The partner recalls a program that worked in March and orders it installed before court.
context_pl: Poczta nie działa. W zgłoszeniu, które sam założyłeś u informatyków kancelarii, jest napisane: awaria jest na serwerze poczty, laptopy są sprawne, nic nie instalować. Osobno pisze administrator, którego znasz, z numeru, którego nie masz w telefonie. Pisze, że zgubił służbowy telefon i przysyła program do zdalnej naprawy, ten sam co w marcu.
caption_pl: Chropot: „W marcu ten plik nas podniósł. Instaluj, sala nie czeka.”
caption_in_game_pl: Chropot: „W marcu ten plik nas podniósł. Instaluj, sala nie czeka.”
game_asset: Night06b
paint_caption: no
who: the partner, overcoat, receding hair, mouth open
where: a court corridor, wood doors, wool runner, rainy window at the far end, not his office
gesture: he thrusts a phone toward the camera
props: blank grey smartphone
pass: corridor, not a desk; phone thrust forward; five fingers
fail: his own office and the wavy glass roof; letters on the phone; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man, overcoat, receding hair, stands in a court corridor, not in his office. He thrusts a blank grey smartphone toward the camera, mouth open. Wood doors, wool runner, a window of rainy cloud at the far end. No desk, no wavy glass roof. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, desk, bookcase
```

#### Noc 7 · `07-sms` · Druga opłata

Sezon 0. Termin: Wokanda dziś. Pytanie: Czy płacisz tę drugą ratę?

Kontekst, który czyta gracz:

> Przychodzi SMS z linkiem do płatności. Podaje sygnaturę sprawy i nazwę firmy, przez którą w marcu płaciłeś opłatę sądową. Kwota jest podobna do tej z nakazu zapłaty kosztów, ale SMS dzieli ją na dwie raty. W nakazie była jedna kwota. Irena mówi, że kasa sądu mogła podzielić wpłatę. Wokanda jest dziś.

Kadr A `Night07a`, napis w grze, nie malować: SMS z linkiem do płatności i sygnaturą, którą rano czytałeś w aktach.

Kadr B `Night07b`, kwestia do wklejenia w grę, nie malować: Irena: „Ta sama kasa co w marcu. Zapłać ratę, bo spadamy z listy.”

### 07a `Night07a` — kciuk nie dotyka przycisku

<!-- card
asset: Night07a
lesson: 07-sms
panel: a
file: Night07a.png
story: An SMS offers a payment link and a second instalment that is not in the costs order.
context_pl: Przychodzi SMS z linkiem do płatności. Podaje sygnaturę sprawy i nazwę firmy, przez którą w marcu płaciłeś opłatę sądową. Kwota jest podobna do tej z nakazu zapłaty kosztów, ale SMS dzieli ją na dwie raty. W nakazie była jedna kwota. Irena mówi, że kasa sądu mogła podzielić wpłatę. Wokanda jest dziś.
caption_pl: SMS z linkiem do płatności i sygnaturą, którą rano czytałeś w aktach.
caption_in_game_pl: SMS z linkiem do płatności i sygnaturą, którą rano czytałeś w aktach.
game_asset: Night07a
paint_caption: no
who: a hand, no face
where: close on the phone over an open judgment
gesture: the thumb hovers beside the button and does not touch it
props: blank grey phone with one empty message bubble and one empty button; open blank judgment underneath
pass: thumb off the button; empty bubble and empty button; five fingers
fail: the thumb pressing the button; words in the bubble; a readable case number; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Close on a blank grey smartphone: one empty message bubble and one empty button under it, no letters. A thumb hovers beside the button and does not touch it. An open blank judgment lies under the phone. Exactly five fingers. No face. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 07b `Night07b` — Irena w drzwiach gabinetu

<!-- card
asset: Night07b
lesson: 07-sms
panel: b
file: Night07b.png
story: The assistant says it is the same payment firm as in March and to pay or fall off the list.
context_pl: Przychodzi SMS z linkiem do płatności. Podaje sygnaturę sprawy i nazwę firmy, przez którą w marcu płaciłeś opłatę sądową. Kwota jest podobna do tej z nakazu zapłaty kosztów, ale SMS dzieli ją na dwie raty. W nakazie była jedna kwota. Irena mówi, że kasa sądu mogła podzielić wpłatę. Wokanda jest dziś.
caption_pl: Irena: „Ta sama kasa co w marcu. Zapłać ratę, bo spadamy z listy.”
caption_in_game_pl: Irena: „Ta sama kasa co w marcu. Zapłać ratę, bo spadamy z listy.”
game_asset: Night07b
paint_caption: no
who: the assistant, bun, rectangular glasses with no chain, dark blouse, mouth open
where: standing in a doorway, a slice of the office window and rain behind her, not the reception counter
gesture: holding a phone, urgent but controlled
props: blank grey phone
pass: she is in a doorway, not behind the counter; five fingers
fail: the reception desk and calendar; a glasses chain; letters on the phone; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, rectangular glasses with no chain and no beads, dark blouse, stands in a doorway holding a blank grey phone, mouth open, urgent but controlled. Behind her a slice of the law office window and rain, not the reception counter. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, red glasses chain, beads, clock face, reception counter, desk calendar
```

#### Noc 8 · `08-qr` · IBAN po wyroku

Sezon 0. Termin: Przelew dziś. Pytanie: Na który numer rachunku idą koszty?

Kontekst, który czyta gracz:

> W wyroku jest wpisany numer rachunku do zapłaty kosztów. Godzinę później przychodzi PDF. Ma stopkę kancelarii, z którą latami korespondujesz, ale nadawca to adres Gmail, nie ich domena. W PDF jest kwadratowy kod do zeskanowania telefonem, podpisany „nowy numer rachunku”. Chropot chce, żebyś zeskanował kod, zamiast przepisywać numer z wyroku.

Kadr A `Night08a`, napis w grze, nie malować: Laptop na biurku. Na ekranie kod do zeskanowania i puste pole.

Kadr B `Night08b`, kwestia do wklejenia w grę, nie malować: Chropot: „Stopkę znam od lat. Skanuj kod, nie przepisuj wyroku.”

### 08a `Night08a` — wyrok i kartka z pustym kwadratem

<!-- card
asset: Night08a
lesson: 08-qr
panel: a
file: Night08a.png
story: The judgment states the account. A later sheet carries a square code to a different one.
context_pl: W wyroku jest wpisany numer rachunku do zapłaty kosztów. Godzinę później przychodzi PDF. Ma stopkę kancelarii, z którą latami korespondujesz, ale nadawca to adres Gmail, nie ich domena. W PDF jest kwadratowy kod do zeskanowania telefonem, podpisany „nowy numer rachunku”. Chropot chce, żebyś zeskanował kod, zamiast przepisywać numer z wyroku.
caption_pl: Laptop na biurku. Na ekranie kod do zeskanowania i puste pole.
caption_in_game_pl: Laptop na biurku. Na ekranie kod do zeskanowania i puste pole.
game_asset: Night08a
paint_caption: no
who: hands flat, not reaching, no face
where: the lawyer's desk; the Palace is small
gesture: hands stay off the sheet and off the phone
props: open blank judgment; a sheet with one empty square of pale blocks; phone face down, away from the square
pass: judgment and the empty square are separate; phone face down; five fingers
fail: digits inside the square; the phone scanning the square; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. An open blank judgment on the desk. Beside it a sheet with one empty square of pale blocks, no digits. A blank grey phone lies face down, away from the square. Hands flat, not reaching. Exactly five fingers. Palace small. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 08b `Night08b` — Chropot wstaje, wskazuje kartkę

<!-- card
asset: Night08b
lesson: 08-qr
panel: b
file: Night08b.png
story: The partner trusts the letterhead and wants the code scanned instead of the number in the judgment.
context_pl: W wyroku jest wpisany numer rachunku do zapłaty kosztów. Godzinę później przychodzi PDF. Ma stopkę kancelarii, z którą latami korespondujesz, ale nadawca to adres Gmail, nie ich domena. W PDF jest kwadratowy kod do zeskanowania telefonem, podpisany „nowy numer rachunku”. Chropot chce, żebyś zeskanował kod, zamiast przepisywać numer z wyroku.
caption_pl: Chropot: „Stopkę znam od lat. Skanuj kod, nie przepisuj wyroku.”
caption_in_game_pl: Chropot: „Stopkę znam od lat. Skanuj kod, nie przepisuj wyroku.”
game_asset: Night08b
paint_caption: no
who: the partner, overcoat, mouth open
where: reception lobby, visitor side of the counter; conference-room door behind him, chair pushed back
gesture: half risen, pointing at the sheet
props: a sheet with one empty square of pale blocks
pass: he is half risen; one empty square; five fingers
fail: digits or a logo in the square; him seated and calm; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man, half risen, overcoat, mouth open, pointing at a sheet that holds one empty square of pale blocks. The chair is pushed back. Wavy glass roof behind. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

#### Noc 9 · `09-glos` · Numer z pisma

Sezon 0. Termin: Lista przelewów o 16:00. Pytanie: Skąd bierzesz numer rachunku do zwrotu?

Kontekst, który czyta gracz:

> Dzwoni numer, który masz zapisany jako komórkę Chropota. Rozmówca zna kwotę zaliczki co do złotówki i dyktuje nowy numer rachunku klienta, na który trzeba zwrócić zaliczkę. Lista przelewów, którą księgowość wysyła, zamyka się o szesnastej. Numer Chropota, zapisany przy przyjęciu sprawy, leży w piśmie w aktach.

Kadr A `Night09a`, napis w grze, nie malować: Słuchawka. Głos jest jego, kwota zaliczki też. Numer rachunku słyszysz pierwszy raz.

Kadr B `Night09b`, kwestia do wklejenia w grę, nie malować: Iglica: „To jego komórka. Stary rachunek puści zaliczkę w próżnię.”

### 09a `Night09a` — słuchawka, bez twarzy

<!-- card
asset: Night09a
lesson: 09-glos
panel: a
file: Night09a.png
story: A call shows the partner's number and knows the retainer. The new account is heard for the first time.
context_pl: Dzwoni numer, który masz zapisany jako komórkę Chropota. Rozmówca zna kwotę zaliczki co do złotówki i dyktuje nowy numer rachunku klienta, na który trzeba zwrócić zaliczkę. Lista przelewów, którą księgowość wysyła, zamyka się o szesnastej. Numer Chropota, zapisany przy przyjęciu sprawy, leży w piśmie w aktach.
caption_pl: Słuchawka. Głos jest jego, kwota zaliczki też. Numer rachunku słyszysz pierwszy raz.
caption_in_game_pl: Słuchawka. Głos jest jego, kwota zaliczki też. Numer rachunku słyszysz pierwszy raz.
game_asset: Night09a
paint_caption: no
who: one hand only; the head is outside the frame, no face
where: tight on the hand and the phone; the Palace is soft and out of focus
gesture: the phone is held where an ear would be
props: blank grey smartphone; the other hand on blank paper
pass: no face in frame; phone at the ear position; five fingers
fail: a visible face; a second phone confirming the call; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Tight on one hand holding a blank grey smartphone to where an ear would be, but the head is outside the frame. The other hand rests on blank paper. White cuff, dark sleeve, exactly five fingers, unmarked skin. Rain on the window, Palace soft and out of focus. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, portrait, clock face
```

### 09b `Night09b` — Iglica w progu gabinetu mecenasa

<!-- card
asset: Night09b
lesson: 09-glos
panel: b
file: Night09b.png
story: The trainee says the display is the partner's phone, so the old account will send the retainer nowhere.
context_pl: Dzwoni numer, który masz zapisany jako komórkę Chropota. Rozmówca zna kwotę zaliczki co do złotówki i dyktuje nowy numer rachunku klienta, na który trzeba zwrócić zaliczkę. Lista przelewów, którą księgowość wysyła, zamyka się o szesnastej. Numer Chropota, zapisany przy przyjęciu sprawy, leży w piśmie w aktach.
caption_pl: Iglica: „To jego komórka. Stary rachunek puści zaliczkę w próżnię.”
caption_in_game_pl: Iglica: „To jego komórka. Stary rachunek puści zaliczkę w próżnię.”
game_asset: Night09b
paint_caption: no
who: the associate, round glasses, messy hair, mouth open, worried
where: standing in the doorway of the lawyer's office, corridor behind, a slice of the Palace far inside the room
gesture: standing, a phone in his hand
props: blank grey phone
pass: he is in the doorway, not in his own chair; five fingers
fail: seated in his own office; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same young man stands in the doorway of the lawyer's office, not in his own room. Round glasses, messy hair, mouth open, worried, a blank grey phone in his hand. Behind him the corridor. A slice of the Palace window is inside the room, far behind. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, clock face, seated, sitting
```

#### Noc 10 · `10-okno` · Makra w pozwie

Sezon 0. Termin: Pozew na jutro. Pytanie: Jak czytasz ten pozew?

Kontekst, który czyta gracz:

> Pozew ściągnąłeś z portalu sądu, z którego korzystasz na co dzień. Word pokazuje żółty pasek: tekstu nie widać, dopóki nie klikniesz „Włącz treść”. Ten przycisk uruchamia makra, czyli program zaszyty w pliku, nie sam tekst pozwu. W stopce pliku jest numer telefonu podpisany „informatyk sądu”.

Kadr A `Night10a`, napis w grze, nie malować: Plik z portalu. Word czeka, aż klikniesz „Włącz treść”.

Kadr B `Night10b`, kwestia do wklejenia w grę, nie malować: Iglica: „To portal. Włącz treść, inaczej pozew zostaje ślepy.”

### 10a `Night10a` — palec zatrzymany przed paskiem

<!-- card
asset: Night10a
lesson: 10-okno
panel: a
file: Night10a.png
story: A pleading from the court portal hides its text behind a control that would run a program in the file.
context_pl: Pozew ściągnąłeś z portalu sądu, z którego korzystasz na co dzień. Word pokazuje żółty pasek: tekstu nie widać, dopóki nie klikniesz „Włącz treść”. Ten przycisk uruchamia makra, czyli program zaszyty w pliku, nie sam tekst pozwu. W stopce pliku jest numer telefonu podpisany „informatyk sądu”.
caption_pl: Plik z portalu. Word czeka, aż klikniesz „Włącz treść”.
caption_in_game_pl: Plik z portalu. Word czeka, aż klikniesz „Włącz treść”.
game_asset: Night10a
paint_caption: no
who: one hand, no face
where: the lawyer's desk; the Palace is small
gesture: a finger has stopped short of an empty bar and does not touch it
props: laptop with one empty bar across a blank page and two empty buttons
pass: finger off the bar; empty bar and empty buttons; five fingers
fail: the finger touching the bar; words on the buttons; a readable pleading; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A laptop shows one empty bar across a blank page and two empty buttons, no words. A finger has stopped short of the bar and does not touch it. Exactly five fingers. Palace small. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, clock face
```

### 10b `Night10b` — Iglica przy biurku mecenasa, palec nie dotyka

<!-- card
asset: Night10b
lesson: 10-okno
panel: b
file: Night10b.png
story: The trainee says the file is from the portal, so the bar must be used or the pleading stays blind.
context_pl: Pozew ściągnąłeś z portalu sądu, z którego korzystasz na co dzień. Word pokazuje żółty pasek: tekstu nie widać, dopóki nie klikniesz „Włącz treść”. Ten przycisk uruchamia makra, czyli program zaszyty w pliku, nie sam tekst pozwu. W stopce pliku jest numer telefonu podpisany „informatyk sądu”.
caption_pl: Iglica: „To portal. Włącz treść, inaczej pozew zostaje ślepy.”
caption_in_game_pl: Iglica: „To portal. Włącz treść, inaczej pozew zostaje ślepy.”
game_asset: Night10b
paint_caption: no
who: the associate, glasses, messy hair, white shirt, mouth open
where: standing beside the lawyer's desk, the Palace in the window behind him
gesture: pointing at the laptop; the fingertip does not touch the screen
props: laptop with an empty bar
pass: he stands at the lawyer's desk, not in his own room; finger off the screen; five fingers
fail: seated in his own office; the finger on the screen; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same young man stands beside the lawyer's desk, Palace in the window behind him, mouth open, urgent. He points at a laptop with an empty bar, but the fingertip does not touch the screen. Round glasses, messy hair, white shirt. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, clock face, seated, sitting
```

#### Noc 11 · `11-konta` · Skrzynka po odejściu

Sezon 0. Termin: Zestaw pism na jutro. Pytanie: Co robisz z tym logowaniem przed nocą?

Kontekst, który czyta gracz:

> Aplikant, którego szanujesz, odszedł dziś. Jego skrzynka wciąż dostaje pocztę klienta. Zestaw pism na jutrzejszą rozprawę leży w niedokończonym mailu, w kopiach roboczych. Przy każdym logowaniu jego prywatny telefon pyta „Czy zatwierdzić?”. Ten telefon został u niego.

Kadr A `Night11a`, napis w grze, nie malować: Irena: „Zostaw skrzynkę do rana. Bez tych pism nie ma wejścia.”

Kadr B `Night11b`, kwestia do wklejenia w grę, nie malować: Chropot: „Porządny człowiek. Sprawa nie poczeka na wyłączenie konta.”

### 11a `Night11a` — cudzy telefon na ladzie

<!-- card
asset: Night11a
lesson: 11-konta
panel: a
file: Night11a.png
story: An associate left today. Their mailbox still receives client mail, and their phone still approves sign-in.
context_pl: Aplikant, którego szanujesz, odszedł dziś. Jego skrzynka wciąż dostaje pocztę klienta. Zestaw pism na jutrzejszą rozprawę leży w niedokończonym mailu, w kopiach roboczych. Przy każdym logowaniu jego prywatny telefon pyta „Czy zatwierdzić?”. Ten telefon został u niego.
caption_pl: Irena: „Zostaw skrzynkę do rana. Bez tych pism nie ma wejścia.”
caption_in_game_pl: Irena: „Zostaw skrzynkę do rana. Bez tych pism nie ma wejścia.”
game_asset: Night11a
paint_caption: no
who: the assistant, bun, glasses with no chain, calm, mouth open
where: behind her own counter; calendar facing her; door behind her
gesture: one hand near a laptop; a second phone lies apart, as if someone left it
props: laptop with an empty list of rows; a second older smartphone, screen dark, on the counter
pass: two phones, one clearly not hers; empty rows; five fingers if a hand shows
fail: a window or skyline; a glasses chain; words in the list; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman behind her counter, bun, glasses with no chain, mouth open, calm. One hand rests near a laptop that shows an empty list of rows, no words. A second, older smartphone lies on the counter, apart from her, screen dark, as if someone left it. The calendar faces her. The door stays behind her. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, window, city skyline, red glasses chain, beads, clock face
```

Kwestia B: `Chropot: „Porządny człowiek. Sprawa nie poczeka na wyłączenie konta.”`

### 11b `Night11b` — Chropot po drugiej stronie lady

<!-- card
asset: Night11b
lesson: 11-konta
panel: b
file: Night11b.png
story: The partner says the person is decent and continuity of the matter matters more than cutting access today.
context_pl: Aplikant, którego szanujesz, odszedł dziś. Jego skrzynka wciąż dostaje pocztę klienta. Zestaw pism na jutrzejszą rozprawę leży w niedokończonym mailu, w kopiach roboczych. Przy każdym logowaniu jego prywatny telefon pyta „Czy zatwierdzić?”. Ten telefon został u niego.
caption_pl: Chropot: „Porządny człowiek. Sprawa nie poczeka na wyłączenie konta.”
caption_in_game_pl: Chropot: „Porządny człowiek. Sprawa nie poczeka na wyłączenie konta.”
game_asset: Night11b
paint_caption: no
who: the partner, mouth open
where: reception lobby, visitor side of the counter; conference-room door behind him
gesture: standing on the visitor side of the reception counter, mouth open, as if leaving a conference room
props: closed blank folder optional; reception counter edge in foreground; no phone
pass: Chropot on the visitor side of the counter; conference door behind; five fingers; no phone
fail: him alone in his private office with wavy roof; empty chair with phone; letters on the folder; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same stern clean-shaven man as the references. He stands on the visitor side of a reception counter, mouth open, as if just leaving a conference room. A closed blank folder in one hand optional. Behind him an open conference-room doorway. Reception counter edge in the foreground. No phone. No private office desk. Exactly five fingers. No letters. --iw 0.45 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, Palace of Culture, palace of culture, city skyline, clock face, smartphone, mobile phone, empty chair with phone, private office, wavy glass roof
```

#### Noc 12 · `12-okup` · Bitcoin przed rozprawą

Sezon 0. Termin: Rozprawa jutro o 9:00. Pytanie: Czy płacisz, i z czyjego rachunku?

Kontekst, który czyta gracz:

> Na ekranie laptopa jest żądanie: zapłać w bitcoinach, oddamy pliki, nie mów klientowi ani ubezpieczycielowi. Zestaw pism na jutrzejszą rozprawę jest na tym laptopie. Chropot chce zapłacić albo z rachunku klienta, albo po cichu z konta kancelarii, i napisać notatkę tak, żeby rozprawa się odbyła.

Kadr A `Night12a`, napis w grze, nie malować: Laptop na biurku. Ekran zamknięty kłódką, pod nią żądanie zapłaty.

Kadr B `Night12b`, kwestia do wklejenia w grę, nie malować: Chropot: „Po cichu, z konta kancelarii. Notatkę dopiszemy pod salę.”

### 12a `Night12a` — kabel wychodzi ze ściany

Plakat. Gest ma być większy niż ikona kłódki.

<!-- card
asset: Night12a
lesson: 12-okup
panel: a
file: Night12a.png
story: The laptop demands payment and silence. The first move is to disconnect it, not to pay.
context_pl: Na ekranie laptopa jest żądanie: zapłać w bitcoinach, oddamy pliki, nie mów klientowi ani ubezpieczycielowi. Zestaw pism na jutrzejszą rozprawę jest na tym laptopie. Chropot chce zapłacić albo z rachunku klienta, albo po cichu z konta kancelarii, i napisać notatkę tak, żeby rozprawa się odbyła.
caption_pl: Laptop na biurku. Ekran zamknięty kłódką, pod nią żądanie zapłaty.
caption_in_game_pl: Laptop na biurku. Ekran zamknięty kłódką, pod nią żądanie zapłaty.
game_asset: Night12a
paint_caption: no
who: no person, or only an empty desk; no face
where: the lawyer's desk; blank rain or dark glass, no landmark tower
gesture: none; the open laptop alone fills the desk; no hand required if the padlock reads clearly
props: laptop screen with one clear grey padlock and soft illegible blurred text blocks; no coins; no cables
pass: open laptop; visible padlock; blurred unreadable text only; no cables; no Palace
fail: coins, currency marks, or a bitcoin symbol; any cable (power or network); Palace of Culture or landmark tower; sharp readable letters; also reject logos (except the simple padlock), watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Close-up, no face: one hand with a white cuff yanks a thick Ethernet network cable out of a wall network jack so the plug comes free and the cable is taut. On the desk an open laptop stays put; its screen is a flat grey field with one small grey padlock, no words, no coins, no bitcoin. Exactly five fingers. Palace of Culture silhouette and rain in the window behind. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, face, eyes, mouth, clock face, bitcoin, currency, coins, power cable, charger, MagSafe, barrel plug, cable from keyboard, cable from hinge, cable on top of laptop deck, six fingers, fused fingers
```

### 12b `Night12b` — dłoń Chropota zatrzymana

<!-- card
asset: Night12b
lesson: 12-okup
panel: b
file: Night12b.png
story: The partner wants a quiet payment from the firm account and a note written for the hearing.
context_pl: Na ekranie laptopa jest żądanie: zapłać w bitcoinach, oddamy pliki, nie mów klientowi ani ubezpieczycielowi. Zestaw pism na jutrzejszą rozprawę jest na tym laptopie. Chropot chce zapłacić albo z rachunku klienta, albo po cichu z konta kancelarii, i napisać notatkę tak, żeby rozprawa się odbyła.
caption_pl: Chropot: „Po cichu, z konta kancelarii. Notatkę dopiszemy pod salę.”
caption_in_game_pl: Chropot: „Po cichu, z konta kancelarii. Notatkę dopiszemy pod salę.”
game_asset: Night12b
paint_caption: no
who: the partner leaning in, mouth open, tense; a second hand in a white cuff
where: reception lobby, visitor side of the counter; conference-room door behind him
gesture: he reaches toward the laptop; a second hand takes the laptop away from him
props: laptop with a flat grey screen and a small padlock; no coins
pass: second hand taking the laptop; Chropot face matches refs; no padlock on lid; five fingers; no coins
fail: him alone paying; hand grabbing his wrist instead of the laptop; padlock painted on the laptop lid; currency symbols; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same stern clean-shaven man as the references. He leans toward an open laptop. A second hand with a white cuff lifts the laptop away from him — taking the laptop, not his wrist. Plain laptop lid, no padlock on the lid. Mouth open, tense. Wavy glass roof. Exactly five fingers. No letters. No coins. --iw 0.55 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, beard, palace of culture, clock face, bitcoin, currency, coins, padlock on lid, hand grabbing wrist
```

## 4. Sezon 1 — własne kadry

### Checklista MJ (S1)

Zasady operacyjne (skrót; pełny opis: `World/s1-mj-process.md`, kolejka: `World/s1-mj-queue.md`):

- Przed każdym Imagine: przeczytaj kontekst nocy + kartę panelu + napis; przepisz szary blok, jeśli jest nieaktualny.
- **Causal A→B:** A = setup (stan / rekwizyt / gest wyjściowy); B = pressure (postać, rozkaz). Czas tylko do przodu. Audyt: `World/audyt-logika-ciag.md`.
- Zapis z Create **tylko 2×2** — **NIGDY Upscale**; natywnie ~1456×816.
- Pałac Kultury tylko gdy karta panelu o niego prosi; inaczej deszcz / korytarz / generyczne bloki + `--no palace of culture`.
- Po wyborze wariantu N: PNG → `Assets.xcassets/NightNNx.imageset`, AssetRegistry (CDN `…/0_N.png`, job `?index=N`); `artPending: false` gdy a+b nocy gotowe.
- Batch ~6–8 Imagine / sesja; paruj a→b.
- `paint_caption: no` — bez liter na płycie.
- Przy czwórce pokaż Gregowi pełny kontekst PL + dialogi / napisy.
- POV S1: aplikant (ręce / biała koszula). Chropot albo Irena na ekranie. **Nigdy** Mecenas-as-POV / ręka mecenasa dla gracza. Iglica nie jako druga osoba.

Gracz jest aplikantem. Iglica nie pojawia się jako druga osoba. Mecenasa, gdy pada w tekście, nie rysujemy twarzą: albo jest poza kadrem, albo plecy i cień. Na ekranie jest Chropot albo Irena.

#### Noc 13 · `13-chmura` · Zdjęcie akt

Sezon 1. Termin: Poprawka przed ósmą. Pytanie: Czy robisz zdjęcie akt prywatnym telefonem?

Kontekst, który czyta gracz:

> Chropot wychodzi na kolację i zostawia ci akta na biurku. Poprawka ma być rano na jego skrzynce. W kancelarii zostaje twój prywatny telefon. Mówi: zrób zdjęcie stron prywatnym telefonem — rano samo wyleci na jego skrzynkę.

**Causal:** A = telefon nad stronami (setup BYOD / chmura); B = Chropot w płaszczu w drzwiach, rozkaz wyślij (pressure). Bez tramwaju / „wsiadaj”.

Kadr A `Night13a`, napis w grze, nie malować: Prywatny telefon nad otwartymi stronami akt.

Kadr B `Night13b`, kwestia do wklejenia w grę, nie malować: Chropot: „Zrób zdjęcie i wyślij. Rano ma leżeć na mojej skrzynce.”

### 13a `Night13a` — prywatny telefon nad stronami akt

<!-- card
asset: Night13a
lesson: 13-chmura
panel: a
file: Night13a.png
story: The partner tells the associate to photograph the file on a personal phone. The photo would leave the firm into a private cloud (BYOD).
context_pl: Chropot wychodzi na kolację i zostawia ci akta na biurku. Poprawka ma być rano na jego skrzynce. W kancelarii zostaje twój prywatny telefon. Mówi: zrób zdjęcie stron prywatnym telefonem — rano samo wyleci na jego skrzynkę.
caption_pl: Prywatny telefon nad otwartymi stronami akt.
caption_in_game_pl: Prywatny telefon nad otwartymi stronami akt.
game_asset: Night13a
paint_caption: no
who: a young man's hand, white shirt cuff, no jacket, face out of frame
where: the associate's smaller office; window looking steeply down to rooftops and tram wires
gesture: the phone is held directly above the open pages, about to photograph them — not aimed at the window
props: open blank file on the desk; older personal smartphone, screen flat grey, above the pages; a coat hangs on the door
pass: phone clearly above the open pages on the desk; five fingers; no face; coat on the door only as background
fail: the Palace; the phone aimed at the window or already pocketed; the file closed; letters on the pages; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, rain streaks. The associate's smaller office, window looking steeply down to rooftops and tram wires. An open blank file on the desk. A young man's hand holds an older personal smartphone directly above the open pages, about to photograph them, screen flat grey — the phone aims at the paper, not at the window. White shirt cuff, no suit jacket. Exactly five fingers. His face is out of frame. A coat hangs on the door in the background. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 13b `Night13b` — Chropot w płaszczu, w drzwiach

<!-- card
asset: Night13b
lesson: 13-chmura
panel: b
file: Night13b.png
story: The partner is in his coat at the door and orders the photo sent to his mailbox by morning.
context_pl: Chropot wychodzi na kolację i zostawia ci akta na biurku. Poprawka ma być rano na jego skrzynce. W kancelarii zostaje twój prywatny telefon. Mówi: zrób zdjęcie stron prywatnym telefonem — rano samo wyleci na jego skrzynkę.
caption_pl: Chropot: „Zrób zdjęcie i wyślij. Rano ma leżeć na mojej skrzynce.”
caption_in_game_pl: Chropot: „Zrób zdjęcie i wyślij. Rano ma leżeć na mojej skrzynce.”
game_asset: Night13b
paint_caption: no
who: the partner, overcoat on, looking back, mouth open
where: the doorway of the associate's office, downward window and tram wires behind, not his own wavy roof
gesture: one hand on the door handle; he is leaving
props: none on a desk; the door handle
pass: coat on; he is at the door, not seated; five fingers
fail: his own office; him sitting down to work; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man, overcoat on, one hand on a door handle, looking back, mouth open. He is leaving. Behind him the associate's window looks down on tram wires, not the wavy glass roof of his own office. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

#### Noc 14 · `14-cudze` · Login partnera

Sezon 1. Termin: Pozew wychodzi dziś. Pytanie: Czyim hasłem wchodzisz do portalu?

Kontekst, który czyta gracz:

> Portal sądu nie ma jeszcze twojego konta. Pozew ma wyjść dziś. Chropot kładzie kartkę z własnym hasłem i mówi, żebyś wszedł jako on, „tylko ten jeden pozew”, bo wniosek o konto leży u Ireny od tygodnia.

**Causal (SWAP):** A = Chropot **kładzie** kartkę (przyczyna); B = kartka już leży, dłonie nad pustymi polami + rozkaz (pressure). Nie pokazywać gotowej kartki na A bez aktu kładzenia.

Kadr A `Night14a`, napis w grze, nie malować: Chropot kładzie kartkę z hasłem. Portal nie ma jeszcze twojego konta.

Kadr B `Night14b`, kwestia do wklejenia w grę, nie malować: Chropot: „Wejdź jako ja. Wniosek o twoje konto leży od tygodnia.”

### 14a `Night14a` — Chropot kładzie kartkę

<!-- card
asset: Night14a
lesson: 14-cudze
panel: a
file: Night14a.png
story: The partner places his password slip on the associate's desk. The court portal has no account for the associate yet.
context_pl: Portal sądu nie ma jeszcze twojego konta. Pozew ma wyjść dziś. Chropot kładzie kartkę z własnym hasłem i mówi, żebyś wszedł jako on, „tylko ten jeden pozew”, bo wniosek o konto leży u Ireny od tygodnia.
caption_pl: Chropot kładzie kartkę z hasłem. Portal nie ma jeszcze twojego konta.
caption_in_game_pl: Chropot kładzie kartkę z hasłem. Portal nie ma jeszcze twojego konta.
game_asset: Night14a
paint_caption: no
who: the partner, mouth open
where: the associate's smaller room, window looking down, not the wavy roof
gesture: standing, setting a small slip on a desk that is not his
props: a small blank slip mid-placement; laptop with empty sign-in window in soft background
pass: he stands at the associate's desk placing the slip; five fingers; empty sign-in only as backdrop
fail: his own office; him seated at his own laptop; the slip already lying flat with no placing gesture; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man stands and sets a small blank slip on a desk that is not his: smaller room, window looking down, not the wavy roof. The slip is mid-placement in his hand, not already lying flat. Mouth open, short gesture. A laptop with an empty sign-in window sits soft in the background, no letters. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### 14b `Night14b` — kartka leży, dłonie z dala od klawiatury

<!-- card
asset: Night14b
lesson: 14-cudze
panel: b
file: Night14b.png
story: The slip already lies beside empty sign-in fields. The partner's order presses the associate to type the password.
context_pl: Portal sądu nie ma jeszcze twojego konta. Pozew ma wyjść dziś. Chropot kładzie kartkę z własnym hasłem i mówi, żebyś wszedł jako on, „tylko ten jeden pozew”, bo wniosek o konto leży u Ireny od tygodnia.
caption_pl: Chropot: „Wejdź jako ja. Wniosek o twoje konto leży od tygodnia.”
caption_in_game_pl: Chropot: „Wejdź jako ja. Wniosek o twoje konto leży od tygodnia.”
game_asset: Night14b
paint_caption: no
who: two young hands, white shirt, no jacket, no face
where: the associate's desk; east window looking down
gesture: both hands are lifted off the keyboard, hovering above empty fields
props: a slip with four empty boxes already lying flat beside a laptop with an empty sign-in window
pass: hands off the keys; slip already on the desk; four empty boxes; empty sign-in window; five fingers
fail: hands typing; marks in the boxes or in the sign-in fields; someone still placing the slip; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The associate's desk. A slip of paper with four empty boxes already lies flat beside a laptop that shows an empty sign-in window, no letters. Two young hands are lifted off the keyboard, hovering above the empty fields. White shirt, no jacket. The east window looks down. Exactly five fingers. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

#### Noc 15 · `15-polecenie` · Jedna strona na rano

Sezon 1. Termin: Mecenas czyta o 7:30. Pytanie: Co wkładasz do czatu, którego kancelaria nie prowadzi?

Kontekst, który czyta gracz:

> Mecenas chce rano jedną stronę streszczenia pisma, które leży przed tobą: nazwy stron, kwota, sygnatura. Mówi, żebyś wrzucił całość do darmowego czatu, bo sam nie zdąży czytać, a firmowy asystent jest wyłączony na noc.

**Causal:** A = pismo + pusty czat (setup); B = Chropot z progu, rozkaz wrzucaj (pressure).

Kadr A `Night15a`, napis w grze, nie malować: Pismo z nazwami i kwotą. Obok pusty czat, poza kancelarią.

Kadr B `Night15b`, kwestia do wklejenia w grę, nie malować: Chropot: „Jedna strona przed świtem. Wrzucaj, firmowy asystent śpi.”

### 15a `Night15a` — pismo i pusty czat

<!-- card
asset: Night15a
lesson: 15-polecenie
panel: a
file: Night15a.png
story: Counsel wants one page by morning and tells the associate to drop the whole pleading into a free chat the firm does not run.
context_pl: Mecenas chce rano jedną stronę streszczenia pisma, które leży przed tobą: nazwy stron, kwota, sygnatura. Mówi, żebyś wrzucił całość do darmowego czatu, bo sam nie zdąży czytać, a firmowy asystent jest wyłączony na noc.
caption_pl: Pismo z nazwami i kwotą. Obok pusty czat, poza kancelarią.
caption_in_game_pl: Pismo z nazwami i kwotą. Obok pusty czat, poza kancelarią.
game_asset: Night15a
paint_caption: no
who: hands on the paper, not on the keys, no face
where: the associate's office at night; east window, rain, trams far below
gesture: the hands stay on the pleading
props: open blank pleading; laptop with an empty chat window and a single blank field
pass: hands on paper, off the keys; empty chat field; five fingers
fail: hands pasting the pleading into the chat; writing on the page; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. Night in the associate's office. A blank pleading lies open. Beside it a laptop shows an empty chat window, a single blank field, no words. Hands rest on the paper, not on the keys. East window, rain, trams far below. Exactly five fingers. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 15b `Night15b` — Chropot z progu, palto, noc

<!-- card
asset: Night15b
lesson: 15-polecenie
panel: b
file: Night15b.png
story: The partner repeats the order. The firm's own assistant is off for the night.
context_pl: Mecenas chce rano jedną stronę streszczenia pisma, które leży przed tobą: nazwy stron, kwota, sygnatura. Mówi, żebyś wrzucił całość do darmowego czatu, bo sam nie zdąży czytać, a firmowy asystent jest wyłączony na noc.
caption_pl: Chropot: „Jedna strona przed świtem. Wrzucaj, firmowy asystent śpi.”
caption_in_game_pl: Chropot: „Jedna strona przed świtem. Wrzucaj, firmowy asystent śpi.”
game_asset: Night15b
paint_caption: no
who: the partner, coat on, mouth open
where: the doorway of the smaller office with the downward window
gesture: standing, a short order, he does not sit
props: none in his hands
pass: coat on; he stays in the doorway; five fingers
fail: seated; the Palace; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man stands in the doorway, coat on, mouth open, a short order. The room beyond is the smaller office with the downward window. He does not sit. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, seated
```

#### Noc 16 · `16-link` · Rozprawa na komunikatorze

Sezon 1. Termin: Sala o 9:00, link o 8:40. Pytanie: Skąd bierzesz adres rozprawy?

Kontekst, który czyta gracz:

> Dwanaście minut przed salą na komunikatorze wpada link „od sądu” — przesłany przez koleżankę z aplikacji, nie z portalu. Irena mówi, że sala już czeka i że masz wejść, bo wokanda nie będzie powtarzana.

**Causal:** A = link na telefonie od koleżanki (setup); B = Irena naciska „wchodź” (pressure).

Kadr A `Night16a`, napis w grze, nie malować: Na telefonie link do spotkania. Nadawcą jest koleżanka, nie sąd.

Kadr B `Night16b`, kwestia do wklejenia w grę, nie malować: Irena: „Wchodź. Tej sali nikt drugi raz nie wywoła.”

### 16a `Night16a` — link w dłoni, korytarz sądu

<!-- card
asset: Night16a
lesson: 16-link
panel: a
file: Night16a.png
story: Minutes before a hearing, a meeting link arrives in a messenger from another trainee, not from the court.
context_pl: Dwanaście minut przed salą na komunikatorze wpada link „od sądu” — przesłany przez koleżankę z aplikacji, nie z portalu. Irena mówi, że sala już czeka i że masz wejść, bo wokanda nie będzie powtarzana.
caption_pl: Na telefonie link do spotkania. Nadawcą jest koleżanka, nie sąd.
caption_in_game_pl: Na telefonie link do spotkania. Nadawcą jest koleżanka, nie sąd.
game_asset: Night16a
paint_caption: no
who: a young man's hand, white shirt, no jacket, no face
where: a court corridor, wood doors, rainy window at the end of the hall
gesture: the thumb is off the card
props: blank grey smartphone showing one empty meeting card
pass: thumb off the card; empty meeting card; corridor; five fingers
fail: the thumb opening the card; a firm office; letters on the card; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A court corridor. A young man's hand holds a blank grey smartphone showing one empty meeting card, no letters. The thumb is off the card. White shirt, no jacket, exactly five fingers. Wood doors and a rainy window at the end of the hall. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 16b `Night16b` — Irena, telefon przy uchu

<!-- card
asset: Night16b
lesson: 16-link
panel: b
file: Night16b.png
story: The assistant says to join now, because the room will not be called again.
context_pl: Dwanaście minut przed salą na komunikatorze wpada link „od sądu” — przesłany przez koleżankę z aplikacji, nie z portalu. Irena mówi, że sala już czeka i że masz wejść, bo wokanda nie będzie powtarzana.
caption_pl: Irena: „Wchodź. Tej sali nikt drugi raz nie wywoła.”
caption_in_game_pl: Irena: „Wchodź. Tej sali nikt drugi raz nie wywoła.”
game_asset: Night16b
paint_caption: no
who: the assistant, bun, glasses with no chain, dark blouse, mouth open
where: she stands; the reception counter is behind her and soft
gesture: a phone at her ear
props: blank grey phone
pass: she is standing, not sitting at the counter; five fingers if a hand shows
fail: a glasses chain; a window skyline; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, glasses with no chain, dark blouse, stands rather than sits, a blank grey phone at her ear, mouth open, calm pressure. The reception counter is behind her and soft. No letters. Exactly five fingers if a hand shows. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain, beads, clock face, window, city skyline
```

#### Noc 17 · `17-wydruk` · Wydruk u rodziców

Sezon 1. Termin: Toner pusty, pismo na rano. Pytanie: Gdzie powstaje papier tej sprawy?

Kontekst, który czyta gracz:

> W kancelarii skończył się toner, a pismo ma leżeć rano na biurku mecenasa. Irena mówi, żebyś zabrał plik do domu i wydrukował u rodziców, bo tam drukarka działa, a rano i tak zdążysz przywieźć kartki.

**Causal:** A = plik na laptopie + pusta drukarka, **bez** kasety w ręku (setup); B = Irena **podaje** pustą kasetę + rozkaz drukuj u rodziców (pressure).

Kadr A `Night17a`, napis w grze, nie malować: Plik pisma na laptopie. W drukarce skończył się toner.

Kadr B `Night17b`, kwestia do wklejenia w grę, nie malować: Irena: „Toner padł. Wydrukuj u rodziców i rano połóż na biurku.”

### 17a `Night17a` — plik na laptopie, pusta drukarka

<!-- card
asset: Night17a
lesson: 17-wydruk
panel: a
file: Night17a.png
story: The toner is empty. The filing is due on the lawyer's desk in the morning and must not go home to be printed.
context_pl: W kancelarii skończył się toner, a pismo ma leżeć rano na biurku mecenasa. Irena mówi, żebyś zabrał plik do domu i wydrukował u rodziców, bo tam drukarka działa, a rano i tak zdążysz przywieźć kartki.
caption_pl: Plik pisma na laptopie. W drukarce skończył się toner.
caption_in_game_pl: Plik pisma na laptopie. W drukarce skończył się toner.
game_asset: Night17a
paint_caption: no
who: a young hand resting near the laptop, no face; no cartridge in hand
where: the associate's office at night; east window, rain, trams below
gesture: hands stay off any cartridge; attention on the laptop with a blank page
props: laptop with a blank page; a small office printer with its cover open or an empty slot visible; coat on the chair
pass: no toner cartridge in anyone's hand; laptop shows blank page; coat on chair; five fingers
fail: a hand holding an empty toner cartridge; a USB stick; a home interior; letters on the page; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The associate's office at night. A laptop shows a blank page. Beside it a small office printer sits with its cover open, empty of toner — no cartridge in any hand. A coat is draped on the chair. A young hand rests near the laptop, not holding a cartridge. East window, rain, trams below. Exactly five fingers. No face. No letters. No USB stick. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 17b `Night17b` — Irena podaje pustą kasetę

<!-- card
asset: Night17b
lesson: 17-wydruk
panel: b
file: Night17b.png
story: The assistant holds out the empty cartridge and tells him to print at his parents' and bring the pages in the morning.
context_pl: W kancelarii skończył się toner, a pismo ma leżeć rano na biurku mecenasa. Irena mówi, żebyś zabrał plik do domu i wydrukował u rodziców, bo tam drukarka działa, a rano i tak zdążysz przywieźć kartki.
caption_pl: Irena: „Toner padł. Wydrukuj u rodziców i rano połóż na biurku.”
caption_in_game_pl: Irena: „Toner padł. Wydrukuj u rodziców i rano połóż na biurku.”
game_asset: Night17b
paint_caption: no
who: the assistant, bun, glasses with no chain, mouth open
where: standing at the reception counter; the calendar faces her
gesture: she holds out an empty toner cartridge
props: empty toner cartridge
pass: she offers the empty cartridge; five fingers
fail: a glasses chain; a window; a full cartridge; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, glasses with no chain, holds out an empty toner cartridge, mouth open, practical. She stands at the counter. The calendar faces her. No letters. Exactly five fingers. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain, beads, window
```

#### Noc 18 · `18-odbior` · Pokwitowanie za partnera

Sezon 1. Termin: Chropot jest na sali. Pytanie: Czyje nazwisko ląduje na pokwitowaniu?

Kontekst, który czyta gracz:

> Kurier czeka z pismem za potwierdzeniem odbioru. Chropot jest na sali i pisze, żebyś pokwitował za niego, bo termin biegnie od doręczenia, a on nie zejdzie przed czwartą. Pisemka nie czytałeś.

**Causal:** A = zamknięta koperta + nietknięte pióro (setup); B = Chropot z sali, rozkaz pokwituj (pressure zdalna).

Kadr A `Night18a`, napis w grze, nie malować: Pokwitowanie odbioru na ladzie. Pismo jest jeszcze zamknięte.

Kadr B `Night18b`, kwestia do wklejenia w grę, nie malować: Chropot: „Pokwituj za mnie. Nie zejdę, a termin już liczy.”

### 18a `Night18a` — kurier, zamknięta koperta, pióro nietknięte

Plakat. Najczytelniejsza noc prawnicza.

<!-- card
asset: Night18a
lesson: 18-odbior
panel: a
file: Night18a.png
story: A courier waits for a signed receipt in the partner's name. The associate has not read the paper and must not sign.
context_pl: Kurier czeka z pismem za potwierdzeniem odbioru. Chropot jest na sali i pisze, żebyś pokwitował za niego, bo termin biegnie od doręczenia, a on nie zejdzie przed czwartą. Pisemka nie czytałeś.
caption_pl: Pokwitowanie odbioru na ladzie. Pismo jest jeszcze zamknięte.
caption_in_game_pl: Pokwitowanie odbioru na ladzie. Pismo jest jeszcze zamknięte.
game_asset: Night18a
paint_caption: no
who: a courier's hand and a younger hand in a white cuff; no lawyer's face
where: the reception counter at night, no window; closed wood door and a blank nameplate behind
gesture: the younger hand stays open and does not take the pen
props: sealed blank envelope, flap smooth; a pen that is not taken
pass: envelope still sealed; the pen untouched; five fingers on each hand
fail: the envelope opened; the pen in the younger hand; writing on the receipt; red wax; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/4e94c6cf-a83e-45d3-807f-b30ad6dd16c3/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The reception counter at night, no window. A courier's hand offers a sealed blank envelope and a pen. A younger hand, white cuff, stays open and does not take the pen. The envelope is closed, string or flap smooth, no mark. Exactly five fingers on each hand. The closed wood door and blank nameplate stay behind the counter. No face of the lawyer. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain
```

### 18b `Night18b` — Chropot w uchu, sala za plecami

<!-- card
asset: Night18b
lesson: 18-odbior
panel: b
file: Night18b.png
story: From the courtroom the partner orders the receipt signed for him, because the deadline runs from service.
context_pl: Kurier czeka z pismem za potwierdzeniem odbioru. Chropot jest na sali i pisze, żebyś pokwitował za niego, bo termin biegnie od doręczenia, a on nie zejdzie przed czwartą. Pisemka nie czytałeś.
caption_pl: Chropot: „Pokwituj za mnie. Nie zejdę, a termin już liczy.”
caption_in_game_pl: Chropot: „Pokwituj za mnie. Nie zejdę, a termin już liczy.”
game_asset: Night18b
paint_caption: no
who: the partner, overcoat, mouth open
where: a courtroom hallway, benches and a tall door, not his desk and not the Palace
gesture: phone at his ear, a short order
props: older smartphone at his ear
pass: court hallway, not an office; five fingers
fail: his office desk; the wavy roof; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man stands in a courtroom hallway, overcoat, phone at his ear, mouth open, a short order. He is not at his desk. Benches and a tall door behind him, no wavy roof, no Palace. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, desk
```
#### Noc 19 · `19-mandat` · Klient dzwoni do ciebie

Sezon 1. Termin: Mecenas jest poza biurem. Pytanie: Co mówisz klientowi o ugodzie i o piśmie w aktach?

Kontekst, który czyta gracz:

> Klient dzwoni na twój numer, nie do mecenasa. Prosi o zdanie, czy podpisać ugodę dziś, i żeby pewnego pisma „nie było jutro w aktach”, bo szkodzi rozmowie. Irena mówi, że masz go uspokoić, bo mecenas oddzwoni dopiero wieczorem.

**Causal:** A = telefon + ugoda + prośba o ukrycie pisma (setup); B = Irena naciska „uspokój go” (pressure).

Kadr A `Night19a`, napis w grze, nie malować: Telefon od klienta. Pyta o ugodę i o pismo, którego „nie ma być w aktach”.

Kadr B `Night19b`, kwestia do wklejenia w grę, nie malować: Irena: „Uspokój go. Mecenas oddzwoni wieczorem, nie teraz.”

### 19a `Night19a` — słucha, nie radzi

<!-- card
asset: Night19a
lesson: 19-mandat
panel: a
file: Night19a.png
story: The client calls the associate, not the lawyer, asking whether to sign and asking that a paper not be in the file tomorrow.
context_pl: Klient dzwoni na twój numer, nie do mecenasa. Prosi o zdanie, czy podpisać ugodę dziś, i żeby pewnego pisma „nie było jutro w aktach”, bo szkodzi rozmowie. Irena mówi, że masz go uspokoić, bo mecenas oddzwoni dopiero wieczorem.
caption_pl: Telefon od klienta. Pyta o ugodę i o pismo, którego „nie ma być w aktach”.
caption_in_game_pl: Telefon od klienta. Pyta o ugodę i o pismo, którego „nie ma być w aktach”.
game_asset: Night19a
paint_caption: no
who: the associate from the side, round glasses, messy hair, white shirt, mouth closed
where: his office, east window
gesture: listening, not advising; the phone at his ear; he does not hold the papers
props: older phone at his ear; a closed blank folder and a second loose blank sheet, apart
pass: mouth closed; papers not in his hands; five fingers
fail: mouth open as if giving advice; him sliding a paper into a drawer; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The associate's office. A young man seen from the side, round glasses, messy hair, white shirt, mouth closed, listening. An older phone at his ear. On the desk a closed blank folder and a second loose blank sheet, apart, not in his hands. East window. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### 19b `Night19b` — Irena, dłoń na słuchawce biurowej

<!-- card
asset: Night19b
lesson: 19-mandat
panel: b
file: Night19b.png
story: The assistant says to calm the client, because the lawyer will not call back until evening.
context_pl: Klient dzwoni na twój numer, nie do mecenasa. Prosi o zdanie, czy podpisać ugodę dziś, i żeby pewnego pisma „nie było jutro w aktach”, bo szkodzi rozmowie. Irena mówi, że masz go uspokoić, bo mecenas oddzwoni dopiero wieczorem.
caption_pl: Irena: „Uspokój go. Mecenas oddzwoni wieczorem, nie teraz.”
caption_in_game_pl: Irena: „Uspokój go. Mecenas oddzwoni wieczorem, nie teraz.”
game_asset: Night19b
paint_caption: no
who: the assistant, bun, glasses with no chain, calm, mouth open
where: her counter; calendar facing her; door behind
gesture: one hand on a desk phone that is still in its cradle
props: desk phone in the cradle
pass: the handset is down, not at her ear; five fingers if shown
fail: a glasses chain; a window; her speaking into the handset as the client; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, glasses with no chain, calm, mouth open, one hand on a desk phone that is still in its cradle, as if telling someone else to take the call. Counter, calendar facing her, door behind. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain, beads, window
```

#### Noc 20 · `20-nosnik` · Pendrive protokolanta

Sezon 1. Termin: Protokolant stoi i czeka. Pytanie: Co robisz z nośnikiem, który ktoś trzyma w dłoni?

Kontekst, który czyta gracz:

> Na korytarzu sądu protokolant podaje ci pendrive: „tu jest protokół, otwórz od razu, bo za chwilę zamykają”. Chropot z sali pisze, żebyś nie dyskutował i zgrał plik na laptop kancelarii, póki człowiek czeka.

**Causal:** A = pendrive w cudzej dłoni + laptop **zamknięty** pod pachą (setup / odmowa wizualna); B = Chropot z sali, rozkaz zgraj (pressure). Napis A ≠ „otwarty”.

Kadr A `Night20a`, napis w grze, nie malować: Pendrive w wyciągniętej dłoni. Laptop kancelarii zamknięty pod pachą.

Kadr B `Night20b`, kwestia do wklejenia w grę, nie malować: Chropot: „Zgraj pendrive. Człowiek czeka, nie rób z tego sprawy.”

### 20a `Night20a` — pendrive w cudzej dłoni, laptop pod pachą

<!-- card
asset: Night20a
lesson: 20-nosnik
panel: a
file: Night20a.png
story: In the court corridor a clerk offers a USB stick and says the minutes are on it. It must not go into the firm laptop.
context_pl: Na korytarzu sądu protokolant podaje ci pendrive: „tu jest protokół, otwórz od razu, bo za chwilę zamykają”. Chropot z sali pisze, żebyś nie dyskutował i zgrał plik na laptop kancelarii, póki człowiek czeka.
caption_pl: Pendrive w wyciągniętej dłoni. Laptop kancelarii zamknięty pod pachą.
caption_in_game_pl: Pendrive w wyciągniętej dłoni. Laptop kancelarii zamknięty pod pachą.
game_asset: Night20a
paint_caption: no
who: an older offered hand; a younger man turned away, white shirt, hands in pockets
where: a court corridor
gesture: the younger man does not reach; the firm laptop stays closed under his arm
props: a plain USB stick with no logo; a closed laptop with no logo
pass: USB offered and not taken; laptop shut under the arm; five fingers on the offered hand
fail: the stick plugged into the laptop; the laptop open; a logo on the stick; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A court corridor. An older hand holds out a plain USB stick, no logo. A younger man's hands stay in his pockets. A closed firm laptop is tucked under his arm, lid shut, no logo. White shirt, dark trousers. Exactly five fingers on the offered hand. The young man's face is turned away. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

### 20b `Night20b` — Chropot w drzwiach sali, gest „bierz”

<!-- card
asset: Night20b
lesson: 20-nosnik
panel: b
file: Night20b.png
story: From the courtroom door the partner says not to argue and to copy the file while the man waits.
context_pl: Na korytarzu sądu protokolant podaje ci pendrive: „tu jest protokół, otwórz od razu, bo za chwilę zamykają”. Chropot z sali pisze, żebyś nie dyskutował i zgrał plik na laptop kancelarii, póki człowiek czeka.
caption_pl: Chropot: „Zgraj pendrive. Człowiek czeka, nie rób z tego sprawy.”
caption_in_game_pl: Chropot: „Zgraj pendrive. Człowiek czeka, nie rób z tego sprawy.”
game_asset: Night20b
paint_caption: no
who: the partner, overcoat, mouth open
where: a tall courtroom doorway, no desk
gesture: half turned back, one hand gesturing to take something; no USB stick in his hand
props: none
pass: he is in the courtroom door; the gesture is to take; five fingers; no stick in his hand
fail: a desk; a USB stick in his own hand; the Palace; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man stands in a tall courtroom doorway, half turned back, mouth open, one hand gesturing to take something. Overcoat. No desk. No USB stick in his hand. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, desk
```

#### Noc 21 · `21-termin` · Zaproszenie do kalendarza

Sezon 1. Termin: Hasło skrzynki w zaproszeniu. Pytanie: Gdzie sprawdzasz, czy ten termin jest prawdziwy?

Kontekst, który czyta gracz:

> Na skrzynkę wpada zaproszenie „sekretariat sądu”: jutrzejszy termin i prośba, żebyś wpisał hasło do poczty kancelarii, „inaczej sala nie zobaczy pełnomocnika”. Irena mówi, że bez tego rano wypadniecie z listy.

**Causal:** A = zaproszenie + puste pole hasła, dłonie zdjęte (setup); B = Irena naciska wpisz (pressure).

Kadr A `Night21a`, napis w grze, nie malować: Zaproszenie na ekranie. Pod termin wstawione puste pole hasła.

Kadr B `Night21b`, kwestia do wklejenia w grę, nie malować: Irena: „Wpisz hasło. Inaczej rano nie ma nas na liście.”

### 21a `Night21a` — zaproszenie i puste pole, dłonie zdjęte

<!-- card
asset: Night21a
lesson: 21-termin
panel: a
file: Night21a.png
story: An invite from a supposed court secretariat asks for the firm mailbox password under tomorrow's date.
context_pl: Na skrzynkę wpada zaproszenie „sekretariat sądu”: jutrzejszy termin i prośba, żebyś wpisał hasło do poczty kancelarii, „inaczej sala nie zobaczy pełnomocnika”. Irena mówi, że bez tego rano wypadniecie z listy.
caption_pl: Zaproszenie na ekranie. Pod termin wstawione puste pole hasła.
caption_in_game_pl: Zaproszenie na ekranie. Pod termin wstawione puste pole hasła.
game_asset: Night21a
paint_caption: no
who: both hands flat on the wood, off the keyboard, no face
where: the associate's desk; east window, night, rain
gesture: hands stay off the keys
props: laptop showing one empty invite card and, under it, one empty password field
pass: empty card and empty field; hands off the keyboard; five fingers
fail: hands typing into the field; letters in the invite; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A laptop on the associate's desk shows one empty invite card and, under it, one empty password field, no letters. Both hands are off the keyboard, flat on the wood. East window, night, rain. Exactly five fingers. No face. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 21b `Night21b` — Irena wskazuje ekran, nie klawiaturę

<!-- card
asset: Night21b
lesson: 21-termin
panel: b
file: Night21b.png
story: The assistant says to type the password or the firm will not be on the list in the morning.
context_pl: Na skrzynkę wpada zaproszenie „sekretariat sądu”: jutrzejszy termin i prośba, żebyś wpisał hasło do poczty kancelarii, „inaczej sala nie zobaczy pełnomocnika”. Irena mówi, że bez tego rano wypadniecie z listy.
caption_pl: Irena: „Wpisz hasło. Inaczej rano nie ma nas na liście.”
caption_in_game_pl: Irena: „Wpisz hasło. Inaczej rano nie ma nas na liście.”
game_asset: Night21b
paint_caption: no
who: the assistant, bun, glasses with no chain, mouth open
where: the counter behind her
gesture: pointing at the screen; her finger does not touch the keys
props: laptop with an empty card and an empty field
pass: finger on the screen side, off the keyboard; five fingers
fail: her hand on the keyboard; a glasses chain; a window; letters; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, glasses with no chain, mouth open, pointing at a laptop screen that shows an empty card and an empty field. Her finger does not touch the keys. Counter behind her. No letters. Exactly five fingers. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain, beads, window
```

#### Noc 22 · `22-granica` · Akta drugiej sprawy

Sezon 1. Termin: Kolega jest na sali. Pytanie: Czyją sprawę wolno ci otworzyć?

Kontekst, który czyta gracz:

> Irena prosi, żebyś zajrzał w akta sprawy kolegi: on jest na sali, a klient dzwoni o sygnaturę. Do tej sprawy nie jesteś dopisany. Mówi, że to pięć minut i że mecenas i tak by pozwolił.

**Causal:** A = Irena przy biurku, prośba o cudze akta — folder/lista jeszcze **nie** otwarte jako twoje (setup); B = „Pięć minut…” (pressure). Bez premature „na ekranie już otwarte”.

Kadr A `Night22a`, napis w grze, nie malować: Irena przy twoim biurku. Prosi o akta sprawy, której nie prowadzisz.

Kadr B `Night22b`, kwestia do wklejenia w grę, nie malować: Irena: „Pięć minut. Mecenas i tak by ci te akta puścił.”

### 22a `Night22a` — prośba o cudze akta, dłonie cofnięte

<!-- card
asset: Night22a
lesson: 22-granica
panel: a
file: Night22a.png
story: The assistant asks him to open a colleague's matter he is not listed on, just for a case number.
context_pl: Irena prosi, żebyś zajrzał w akta sprawy kolegi: on jest na sali, a klient dzwoni o sygnaturę. Do tej sprawy nie jesteś dopisany. Mówi, że to pięć minut i że mecenas i tak by pozwolił.
caption_pl: Irena przy twoim biurku. Prosi o akta sprawy, której nie prowadzisz.
caption_in_game_pl: Irena przy twoim biurku. Prosi o akta sprawy, której nie prowadzisz.
game_asset: Night22a
paint_caption: no
who: two young hands, no face
where: the associate's desk; east window
gesture: both hands are pulled back to the edge of the desk, not on the keys
props: laptop with a blank list or closed catalog window; a second closed folder, unopened
pass: hands off the keys; the second folder stays closed; no open matter file filling the screen; five fingers
fail: hands on the keyboard; the second folder open; letters in the file window; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The associate's desk. A laptop shows a blank list or closed catalog window, no words, no open matter. Two young hands are pulled back to the edge of the desk, not on the keys. A second closed folder lies unopened. East window. Exactly five fingers. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 22b `Night22b` — Irena przy jego biurku, on nie sięga

<!-- card
asset: Night22b
lesson: 22-granica
panel: b
file: Night22b.png
story: She says it is five minutes and that the lawyer would have allowed it.
context_pl: Irena prosi, żebyś zajrzał w akta sprawy kolegi: on jest na sali, a klient dzwoni o sygnaturę. Do tej sprawy nie jesteś dopisany. Mówi, że to pięć minut i że mecenas i tak by pozwolił.
caption_pl: Irena: „Pięć minut. Mecenas i tak by ci te akta puścił.”
caption_in_game_pl: Irena: „Pięć minut. Mecenas i tak by ci te akta puścił.”
game_asset: Night22b
paint_caption: no
who: the assistant, bun, glasses with no chain, mouth open; the associate with hands in his lap, round glasses, face turned down
where: a smaller desk that is not the reception counter; east window soft behind them
gesture: her hand toward the laptop; he does not reach
props: a laptop he is not touching
pass: his hands stay in his lap; five fingers
fail: him typing; the reception counter; a glasses chain; the Palace; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same woman, bun, glasses with no chain, stands beside a smaller desk that is not the reception counter, mouth open, one hand toward a laptop. A younger man's hands stay in his lap, white shirt, face turned down, round glasses just visible, he does not reach. East window soft behind them. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, red glasses chain, beads, palace of culture
```

#### Noc 23 · `23-nagranie` · Notatka z rozmowy

Sezon 1. Termin: Klient mówi szybciej niż piszesz. Pytanie: Gdzie zostaje głos klienta?

Kontekst, który czyta gracz:

> Klient na głośnomówiącym dyktuje fakty do pisma. Chropot, z drugiego pokoju, mówi, żebyś nagrał to prywatnym telefonem, bo nie nadążysz, a telefon i tak zsynchronizuje nagranie z twoją chmurą.

**Causal:** A = głośnik + telefon **ekranem w dół** + ołówek (setup / gest odmowy); B = Chropot z progu, rozkaz nagraj (pressure). Napis A ≠ „gotowy nagrywać”.

Kadr A `Night23a`, napis w grze, nie malować: Głośnik na biurku. Prywatny telefon leży ekranem w dół; ołówek na papierze kancelarii.

Kadr B `Night23b`, kwestia do wklejenia w grę, nie malować: Chropot: „Nagraj prywatnym. Rano przepiszesz, klient nie będzie powtarzał.”

### 23a `Night23a` — głośnik, telefon ekranem w dół, ołówek

<!-- card
asset: Night23a
lesson: 23-nagranie
panel: a
file: Night23a.png
story: The client dictates on speaker. The partner wants it recorded on a personal phone that syncs to the cloud.
context_pl: Klient na głośnomówiącym dyktuje fakty do pisma. Chropot, z drugiego pokoju, mówi, żebyś nagrał to prywatnym telefonem, bo nie nadążysz, a telefon i tak zsynchronizuje nagranie z twoją chmurą.
caption_pl: Głośnik na biurku. Prywatny telefon leży ekranem w dół; ołówek na papierze kancelarii.
caption_in_game_pl: Głośnik na biurku. Prywatny telefon leży ekranem w dół; ołówek na papierze kancelarii.
game_asset: Night23a
paint_caption: no
who: a young hand writing, no face
where: the associate's desk; east window, night
gesture: writing with a pencil on firm paper; the personal phone stays face down
props: speaker phone with a dark screen; personal smartphone face down; pencil and blank paper
pass: phone face down; pencil on paper; no recording light; five fingers
fail: a red recording dot; the phone face up and recording; letters on the paper; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/fcfdd2be-2d44-46c0-9f4d-65a1508825f4/0_1.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The associate's desk. A small speaker phone, screen dark. Beside it a personal smartphone lies face down. A young hand writes with a pencil on blank firm paper. Exactly five fingers. East window, night. No recording light, no red dot. No face. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, face
```

### 23b `Night23b` — Chropot z drugiego pokoju, w progu

<!-- card
asset: Night23b
lesson: 23-nagranie
panel: b
file: Night23b.png
story: From the next room the partner says to record it and transcribe from the cloud in the morning.
context_pl: Klient na głośnomówiącym dyktuje fakty do pisma. Chropot, z drugiego pokoju, mówi, żebyś nagrał to prywatnym telefonem, bo nie nadążysz, a telefon i tak zsynchronizuje nagranie z twoją chmurą.
caption_pl: Chropot: „Nagraj prywatnym. Rano przepiszesz, klient nie będzie powtarzał.”
caption_in_game_pl: Chropot: „Nagraj prywatnym. Rano przepiszesz, klient nie będzie powtarzał.”
game_asset: Night23b
paint_caption: no
who: the partner, shirt and tie, overcoat off, mouth open
where: a doorway between two offices
gesture: one hand indicates a phone on a desk in the next room; he does not hold the phone
props: a phone visible on the far desk, not in his hand
pass: he stands in the doorway; the phone stays on the desk; five fingers
fail: the phone at his own ear; the Palace; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. The same stern man stands in a doorway between two offices, mouth open, one hand indicating a phone on a desk in the next room. He does not hold the phone. Overcoat off, shirt and tie. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

#### Noc 24 · `24-ekran` · Laptop na korytarzu

Sezon 1. Termin: Chropot znika na salę. Pytanie: Co robisz z otwartym laptopem, gdy obcy prosi o wokandę?

Kontekst, który czyta gracz:

> Przed salą Chropot zostawia otwarty laptop kancelarii na ławce: „zostaw klapę otwartą i pilnuj, zaraz wracam”. Na ekranie są akta. Potem podchodzi obcy i prosi, żebyś „tylko sprawdził wokandę”, bo jego telefon padł.

**Causal:** A = Chropot **zostawia** otwarty laptop / wchodzi na salę (setup); B = obcy o krok, prośba o wokandę (pressure). Nie flashback wyjścia na B.

Kadr A `Night24a`, napis w grze, nie malować: Chropot zostawia otwarty laptop na ławce. „Zaraz wracam.”

Kadr B `Night24b`, kwestia do wklejenia w grę, nie malować: Obcy: „Pokaż wokandę. Telefon padł.”

### 24a `Night24a` — otwarty laptop, Chropot w drzwiach sali

Plakat. Setup: laptop zostawiony, partner odchodzi.

<!-- card
asset: Night24a
lesson: 24-ekran
panel: a
file: Night24a.png
story: The partner leaves the firm laptop open on a court bench and steps into the courtroom.
context_pl: Przed salą Chropot zostawia otwarty laptop kancelarii na ławce: „zostaw klapę otwartą i pilnuj, zaraz wracam”. Na ekranie są akta. Potem podchodzi obcy i prosi, żebyś „tylko sprawdził wokandę”, bo jego telefon padł.
caption_pl: Chropot zostawia otwarty laptop na ławce. „Zaraz wracam.”
caption_in_game_pl: Chropot zostawia otwarty laptop na ławce. „Zaraz wracam.”
game_asset: Night24a
paint_caption: no
who: the partner seen from behind, overcoat, face not visible; open laptop on the bench in the foreground
where: a bench in a court corridor; tall courtroom door ahead
gesture: walking through a tall courtroom door; one hand raised in a short wave that means wait; laptop stays open on the bench
props: open laptop on the bench, screen a flat grey field, no logo
pass: we see his back entering the courtroom; laptop lid fully open on the bench; five fingers if the hand shows
fail: his face; a desk; the stranger already in this panel; lid already shutting; letters on the screen; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A bench in a court corridor in the foreground holds an open laptop, screen a flat grey field, no words, no logo. The same stern man seen from behind, overcoat, walks through a tall courtroom door, one hand raised in a short wave that means wait. His face is not visible. The laptop stays fully open on the bench. No stranger in this panel. No letters. Exactly five fingers if the hand shows. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face, desk
```

### 24b `Night24b` — obcy o krok, klapa w grze

<!-- card
asset: Night24b
lesson: 24-ekran
panel: b
file: Night24b.png
story: A stranger asks to check the list on the open firm laptop. The associate's hand is near the lid.
context_pl: Przed salą Chropot zostawia otwarty laptop kancelarii na ławce: „zostaw klapę otwartą i pilnuj, zaraz wracam”. Na ekranie są akta. Potem podchodzi obcy i prosi, żebyś „tylko sprawdził wokandę”, bo jego telefon padł.
caption_pl: Obcy: „Pokaż wokandę. Telefon padł.”
caption_in_game_pl: Obcy: „Pokaż wokandę. Telefon padł.”
game_asset: Night24b
paint_caption: no
who: a young man's hand near the lid; a stranger one step away, coat, face in shadow, empty hands
where: a bench in a court corridor, tall doors behind
gesture: the lid is still open or the hand hovers above it; the stranger does not touch the laptop
props: open laptop, screen a flat grey field, no logo
pass: stranger one step away with empty hands; laptop still open; five fingers on the associate's hand
fail: the stranger's hands on the keyboard; Chropot's back as the main subject; letters on the screen; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/73e52afa-6d19-4f17-8834-22988d1a488c/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference. A bench in a court corridor. An open laptop, screen a flat grey field, no words, no logo. A young man's hand hovers near the lid, not yet closing it. A stranger stands one step away, coat, face in shadow, empty hands, not touching the laptop. Tall doors behind. Exactly five fingers on the associate's hand. No letters. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, palace of culture, clock face
```

## 5. Jedna poprawka werdyktu, zanim ruszysz tekst

Noc 14, ruch trafny, dziś: pozew czeka, aż portal puści własne konto. Na sali pełnej radców to odbije się od terminu. Zostaw odmowę cudzego hasła. Dopisz, kto wysyła pozew.

`Nie wpisuję jego hasła. Proszę, żeby pozew wyszedł z jego własnej sesji, gdy zejdzie z sali. Irena dziś dopytuje wniosek o moje konto.`

Noc 9, jedno zdanie do briefingu, nie do dymka: znajomy głos nie jest drugim kanałem. Drugim kanałem jest numer z pisma, wybrany przez ciebie.

Reszty wyborów nie ruszam. Półśrodki są tu cenniejsze niż trzecia oczywista pomyłka.

## 6. Analiza

Dwie role, jeden wniosek. Edukator: paczka uczy jednego odruchu pod presją społeczną, nie quizu ze słownikiem. Radca: odruch da się obronić przed aplikantem. W dwóch miejscach sala prawników odłoży grę, jeśli briefing powie za dużo albo za mało. Niżej jest które.

Nazwy ataków (BEC, spoofing, makra, ransomware) zostają w briefingu po decyzji. W komiksie ich nie ma. Gracz ma najpierw zobaczyć gest.

### Sezon 0

1. Drugie zatwierdzenie. Edukator: to zmęczenie drugim pytaniem, nie „słabe hasło”. Jedno hasło, jedno pytanie. Drugie jest cudzym wejściem, choćby stał przy tobie ktoś zaufany. Radca: zatwierdzenie cudzej sesji w portalu sądu jest śladem partnera pod obcym ruchem. Oddzwonienie na numer z książki kancelarii, nie na numer z tej rozmowy, jest właściwym kanałem. Odmowa także własnego pytania jest niepełna, bo wyłącza ciebie, nie intruza.

2. Doklejone pismo. Edukator: zgodna sygnatura jest przynętą. Sąd nie doręcza PDF-em doklejonym przez kolegę. Radca: odpowiedź na ten mail nie potwierdza pisma i gubi termin. Wejście pod zapisany adres portalu jest właściwe. Partner w dobrej wierze nadal dokleja cudzy plik. Nie rób z Chropota złoczyńcy. On się spieszy.

3. Ugoda w asystencie. Edukator: „program się nie uczy” nie jest testem. Testem jest, czy nazwa, kwota i sygnatura opuszczają pokój. Radca: tajemnica zawodowa nie ustępuje umowie z dostawcą ani zdaniu IT. Wystarczy układ klauzul na zmyślonym przykładzie. Wycięcie samych nazwisk, przy zostawionej kwocie, jest najlepszym półśrodkiem w całej paczce. Zostaw go.

4. Hasło przed radą. Edukator: link i hasło w jednym mailu to pełny klucz dla każdego, kto odziedziczy wątek. Stare hasło z zeszłego maila jest zużyte. Radca: osobna rozmowa albo program haseł rozdziela „gdzie” od „jak wejść”. Pośpiech rady nie jest wyjątkiem.

5. Hasło klienta. Edukator: hasło w chronologii czytają ludzie, którzy nigdy nie logują się do systemu klienta. Zdjęcie tablicy żyje dłużej niż napis, który rano zetrą. Radca: to nie jest komplet akt. To kopia klucza. Zapis tylko dla dwóch osób ze sprawy jest do obrony. Ostrzejsza reguła domowa, jeśli kiedyś ją dopiszesz: kancelaria w ogóle nie przechowuje hasła klienta, klient wpisuje je sam. Noc tego nie wymaga.

6. Program w awarii. Edukator: nowe konto znanego administratora i wspomnienie marca mają wyłączyć zgłoszenie, które sam otworzyłeś. Radca: instalacja „na próbę” na laptopie aplikanta jest nadal sprzętem kancelarii. Zostaw przy zgłoszeniu.

7. Druga opłata. Edukator: SMS wymyśla ratę, której nie ma w nakazie. Znana firma płatnicza i sygnatura nie tworzą opłaty. Radca: numer z SMS-a nie jest kasą sądu. Płatność pieniędzmi klienta na taki link nie rozlicza nakazu. Porównanie z nakazem i księgą opłat jest właściwe.

8. IBAN po wyroku. Edukator: klasyczny podmian rachunku. Stopka znajoma, nadawca spoza domeny, kod zamiast numeru z orzeczenia. Radca: zapłata na rachunek spoza wyroku nie jest zapłatą kosztów należnych wierzycielowi. Potwierdzenie wysłane po przelewie pieniędzy nie cofa. Źródłem numeru jest wyrok.

9. Numer z pisma. Edukator: wyświetlacz da się podstawić. Kwota zaliczki z akt też już może być znana. WhatsApp na tym samym telefonie jest tą samą rozmową. Radca: nowy rachunek do zwrotu zaliczki bierzesz z oddzwonienia na numer zapisany przy przyjęciu sprawy. Dopisz w briefingu, że znajomy głos nie zastępuje tego numeru. Nie nazywaj każdej rozmowy deepfake’iem. Mechanizmem nocy jest podstawiony numer i presja szesnastej.

10. Makra w pozwie. Edukator: „Włącz treść” uruchamia program w pliku, nie odsłania tekstu. Portal, z którego plik przyszedł, tego nie święci. Numer w stopce jest częścią przynęty. Radca: prośba o PDF przez ten sam portal jest właściwa. Telefon wydrukowany w dokumencie nie jest sądem.

11. Skrzynka po odejściu. Edukator: zmiana hasła bez odebrania telefonu, który zatwierdza logowanie, zostawia klucz u osoby spoza firmy. „Porządny człowiek” nie jest kontrolą. Radca: odejście zamyka dostęp tego samego dnia. Ciągłość sprawy robi się przejęciem skrzynki przez partnera sprawy, nie zostawieniem zatwierdzeń na prywatnym telefonie. Kolejność w grze jest dobra: najpierw przekierowanie, potem wyłączenie, telefon wraca albo jest czyszczony.

12. Bitcoin przed rozprawą. Edukator: okup i milczenie są po to, żebyś zapłacił, zanim ktokolwiek z listy awaryjnej zobaczy ekran. Płatność nie oddaje pewnych plików. Radca: rachunek klienta nie jest na okup. Cicha zapłata z konta kancelarii i notatka „pod termin” ukrywają przed klientem to, co pełnomocnik ma powiedzieć: dostępu do pism nie ma. Bez domysłów, bez przelewu. Odłączenie od sieci jest pierwszym gestem i dlatego kadr 12a ma wyrywać kabel, nie pokazywać ikony.

### Sezon 1

13. Akta w tramwaju. Edukator: zdjęcie, którego nie wysłałeś, i tak wychodzi do chmury telefonu. Radca: prywatny telefon nie jest przedłużeniem akt. Poprawka albo powstaje na miejscu, albo teczka zostaje na biurku. Partner, który każe jechać, nie przenosi tajemnicy do kieszeni.

14. Login partnera. Edukator: cudze hasło zostawia w portalu jego nazwisko pod twoim ruchem. Szkic na jego koncie jest tym samym wejściem. Radca: polecenie nie robi z jego hasła twojego podpisu. Pozew ma wyjść z jego sesji, kiedy zejdzie z sali, albo z twojego konta, gdy portal je puści. Samo „czekam na konto” bez zdania, kto klika, brzmi jak zgubienie terminu. Stąd poprawka wyżej.

15. Jedna strona na rano. Edukator: darmowy czat jest gorszy niż firmowy asystent z nocy 3, bo firma go nie wybrała i nie wyłączyła na noc. Radca: polecenie mecenasa nie zwalnia z tajemnicy. Jedna strona dla niego nie cofa tego, co już poszło. Kwota bez nazwisk nadal jest sprawą.

16. Rozprawa na komunikatorze. Edukator: link od koleżanki nie jest zawiadomieniem sądu. Prośba, żeby ten sam link przyszedł mailem, nadal mu ufa. Radca: adres zdalnej sali bierzesz z portalu albo jedziesz na salę. Wejście w obcy pokój bywa też udostępnieniem ekranu z aktami. Tego w dymku nie tłumacz. Zostaw w briefingu.

17. Wydruk u rodziców. Edukator: domowa drukarka zostawia pismo w historii urządzenia, którego kancelaria nie ma. Pendrive „na potem” jest wyniesieniem, nawet bez druku. Radca: pusty toner nie przenosi sekretariatu do mieszkania rodziców. Papier powstaje w kancelarii albo mecenas czyta z jej ekranu.

18. Pokwitowanie za partnera. Edukator: podpis przy zamkniętej kopercie jest tym samym pokwitowaniem. Ludzie wierzą, że „nie otworzyłem” ich ratuje. Radca: to najmocniejsza noc prawnicza w paczce. Pokwitowanie stwierdza, że pismo doszło. Podpis za partnera, bez umocowania do odbioru, jest oświadczeniem, którego aplikant nie składa. Termin potrafi ruszyć od doręczenia, a potem kancelaria spiera się, czy odbiór był skuteczny. Właściwie: kurier zostawia pismo adresatowi albo Irenie, według zasad kancelarii. Nie otwierasz koperty sam.

19. Klient dzwoni do ciebie. Edukator: prośba „niech tego jutro nie będzie” jest ukryciem także wtedy, gdy ograniczysz ją do jednego przeglądu. Radca: aplikant nie ma pełnomocnictwa do rady, czy podpisać ugodę, i nie wyjmuje pisma z akt. Rozmowę zapisujesz dla mecenasa. Klient słyszy tylko, kiedy ten oddzwoni. Nie dokładaj tu artykułów kodeksu karnego. Wystarczy granica mandatu.

20. Pendrive protokolanta. Edukator: czekający człowiek i „nie rób sceny” są presją, nie sprawdzeniem nośnika. Poczta z cudzego komputera na sali jest tym samym plikiem. Radca: protokół bierzesz z portalu albo na papierze. Laptop kancelarii nie jest czytnikiem cudzego nośnika, także gdy podaje go ktoś z sądu.

21. Zaproszenie do kalendarza. Edukator: prawdziwy termin nie prosi o hasło skrzynki. Przepisanie daty utrwala fakt, którego nie sprawdziłeś, i potrafisz przez to przegapić prawdziwą salę. Radca: sąd nie zbiera haseł pełnomocników w kalendarzu. Hasła nie wpisujesz. Termin bierzesz z portalu. Zaproszenie zgłaszasz i nic więcej w nim nie klikasz.

22. Akta drugiej sprawy. Edukator: „tylko sprawdzić” jest tym samym wejściem. Pięć minut nie jest małym dostępem. Radca: nie jesteś dopisany do sprawy, więc jej nie otwierasz. Sygnaturę podaje ten, kto ją prowadzi. Zdanie, że mecenas by pozwolił, nie dopisuje cię wstecz. Prośbę zapisujesz.

23. Notatka z rozmowy. Edukator: chmura prywatnego telefonu nie jest zeszytem kancelarii. Nagranie na laptopie firmy, bez zgody i bez decyzji mecenasa, też zostawia głos w aktach, których nikt tak nie zamówił. Radca: nie ucz, że nagranie rozmowy, w której uczestniczysz, jest przestępstwem. Surowsza jest tajemnica zawodowa i brak decyzji pełnomocnika. Właściwy odruch tej nocy: przerywasz, prosisz o wolniejsze dyktando, piszesz na papierze kancelarii, telefon leży ekranem w dół.

24. Laptop na korytarzu. Edukator: zamknięta klapa bez blokady wraca do tych samych akt. „Tylko wokanda” oddaje otwarty ekran obcemu. Radca: pilnowanie znaczy sprzęt przy tobie i ekran zablokowany. Korytarz sądu nie jest przedłużeniem gabinetu.

### Czego nie zmieniać

Trzy werdykty zostają. Półśrodek ma być kuszący: szkic na cudzym koncie, podpis przy zamkniętej kopercie, nowe hasło bez odebrania telefonu, termin przepisany bez portalu. To jest warstwa, której quizy nie mają.

Nie wkładaj do dymków nazw ataków ani artykułów. Nie maluj czerwieni. Nie dokładaj trzeciego kadru do silnika, dopóki te pary nie wejdą. Dwa kadry wystarczą, jeśli A jest gestem, a B jest człowiekiem w innym pokoju.
