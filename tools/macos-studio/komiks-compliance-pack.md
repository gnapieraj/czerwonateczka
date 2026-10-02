# Komiks Compliance pack — Sezon 2–3 (Audytorka Sylwia Szczelińska)

Stan: 02.10.2026. To nie jest porada prawna. Robocza księga Midjourney + treści nocy dla B2B packa.

Wklejasz na https://midjourney.com/imagine (Create), Stealth włączony, V8.2. Jeden prompt, jeden `--no`.

**Season 1 (Aplikant) zostaje free.** Ten plik = Sezon 2 · Kontrola + Sezon 3 · AML (24 noce, order 25–48).

Przyjęta płyta ląduje raz: `Resources/Assets.xcassets/<nazwa>.imageset/<nazwa>.png`. Spis: `World/AssetRegistry.md` (sync później).

Proces MJ: `World/compliance-pack-mj-process.md`. Plan: `plan-compliance-pack.md`. Źródło danych: `tools/data/compliance_pack_nights.json` / `tools/build_compliance_pack.py`.

Odrzucasz planszę przy literach, cyfrach, logo, czerwieni, pieczęci, krwi, tarczy zegara, telefonie tarczowym, zlanych palcach, łańcuszku przy okularach, mozaice, pasku cenzury. Palace tylko gdy karta każe (tu domyślnie **nie**).

## Głosy

**Audytorka Sylwia Szczelińska** (gracz): spokojniejsza, starsza, checklista/teczka; twarz czytelna; nie Chropot, nie Iglica, nie Irena. W dymkach: **Szczelińska**. Subtekst: szczelność systemów / no leaks.
Iglica — szybko, boi się listy. Chropot — krótko, rozkaz. Irena — spokój i porządek. Klient — presja terminu. Żadna kwestia nie zdradza werdyktu.

## 0. Plakat sezonu — Audytorka Sylwia Szczelińska

<!-- card
asset: SezonAudytor
lesson: none
panel: season
file: SezonAudytor.png
story: Season choice for Compliance pack. Player is Audytorka Sylwia Szczelińska. Face visible, distinct from Chropot/Iglica/Irena.
context_pl: none. This plate is the season switch, not a night.
caption_pl: none. SwiftUI draws the season label. Do not paint it.
paint_caption: no
who: a calm Polish woman in her late forties, short grey-streaked temples, thin rectangular reading glasses (not round), dark tailored jacket, white blouse, no Chropot tie, quiet eyes, face visible
where: smaller control office at night; east window looks down to rooftops and tram wires; no Palace as subject
gesture: stands three-quarter length, large, right of center
props: closed blank folder and a short blank checklist; optional grey smartphone screen-down
pass: face visible and distinct; standing; five fingers; checklist/folder readable as blank props
fail: round wire glasses like Iglica; overcoat-on Chropot look; blacked-out face; Palace as subject; letters of any season title; also reject letters, numbers, glyphs, logos, watermarks, red, wax seal, blood, clock face, rotary phone, fused or extra fingers, writing on skin, photo blur, pixel mosaic, a censor bar
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, rain streaks, same pen as the reference, cool grey wash, bold contour. Wide poster panel. A calm Polish woman in her late forties stands three-quarter length, short grey-streaked temples, thin rectangular reading glasses not round wire glasses, dark tailored jacket, white blouse, no necktie, quiet eyes, face visible in grey ink. She stands, she is not sitting, in a smaller fifth-floor control office. Exactly five fingers, unmarked skin. One hand holds a closed blank folder. The other holds a short blank checklist. The east window looks steeply down: rooftops near the sill, tram tracks and wires far below, every sign an empty grey panel. Rain on the glass. The room is dry. She is large, right of center. --iw 0.35 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 700 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, skyscraper spire, seated woman, sitting, seated man, round wire glasses, freckles, overcoat, necktie, heavy brow like Chropot
```

Po akceptacji zapisz CDN URL i podmień refs w promptach z twarzą Szczelińskiej. Do tego czasu styl bierze sref Sezonu 0.

## 1. Sezon 2 · Audytorka · Kontrola (noce 25–36)

Tematy: RODO, tajemnica, chmura/AI, DPIA, DPA, retencja, wyciek, podmiot danych, shadow SaaS, transfer, dostęp, rejestr.

Zasada pary: kadr A = rzecz/gest do powstrzymania; kadr B = człowiek nacisku w innym miejscu.

#### Noc 25 · `25-cel` · Cel poza umową

**Temat edukacyjny:** RODO — ograniczenie celu (`RODO-CEL`)

Sezon 2. Termin: Kontrola za tydzień. Pytanie: Czy ten eksport służy sprawie z umowy, czy marketingowi klienta?

Kontekst, który czyta gracz:

> Klient z portfolio prosi, żebyś „przy okazji akt sprawy” zrzucił całą bazę kontrahentów do ich nowego CRM marketingowego. Chropot: umowa jest szeroka, kontrola i tak patrzy na coś innego, a oni płacą za godzinę.

Kadr A `Night25a`, napis w grze, nie malować: Eksport bazy. Dwa foldery: sprawa z umowy i CRM marketingu.

Kadr B `Night25b`, kwestia do wklejenia w grę, nie malować: Chropot: „Umowa jest szeroka. Zrób zrzut. Kontrola i tak nie czyta CRM.”

### Decyzje

- **TRAFNE:** Odmawiam eksportu do CRM. Wysyłam tylko dane sprawy z umowy i zapisuję odmowę w notatce kontroli.
  - Ratio: Cel z umowy nie rozszerza się na marketing klienta, nawet gdy partner mówi, że umowa jest „szeroka”.
- **BŁĘDNA:** Robię pełny zrzut do CRM. Kontrola i tak patrzy na DPIA, nie na marketing.
  - Ratio: Presja kontroli nie zamienia marketingu w cel sprawy.
- **NIEPEŁNA:** Wysyłam bazę, ale proszę klienta ustnie, żeby „nie robił z niej mailingu”.
  - Ratio: Ustna prośba nie jest nowym celem ani podstawą. Zakres zostaje w umowie albo nic nie wychodzi.

### Briefing

- **Jak to działa (threat):** Dane zebrane pod sprawę nie stają się bazą marketingową, bo klient „już płaci” albo bo kontrola „patrzy gdzie indziej”. Ograniczenie celu to granica, którą partner chce przekroczyć godziną faktury. Eksport do CRM bez nowego celu to wyciek celu, nie przysługę.
- **Jak minimalizować:** Odmawiasz eksportu poza sprawę. Wysyłasz tylko to, co umowa wymaga. Prośbę i odmowę zapisujesz w notatce kontroli.
- **W kancelarii — praktyka:** W Colgante dane ze sprawy nie wchodzą do narzędzi marketingu klienta bez osobnej podstawy, osobnego celu i śladu w umowie.
- **Na co zwracać uwagę:** „Umowa jest szeroka” jako jedyny argument na nowy cel. / Ustny zakaz użycia zamiast zmiany zakresu.
- **Red flag:** Pełna baza kontrahentów ma wejść do CRM marketingu „przy okazji sprawy”.

### Evidence / rejestr (HR)

- **registerLine:** `25-cel · Cel poza umową · RODO ograniczenie celu`
- **evidence:** Notatka kontroli: odmowa eksportu poza cel umowy; zakres = sprawa.

### 25a `Night25a` — dwa foldery na blacie kontroli

<!-- card
asset: Night25a
lesson: 25-cel
panel: a
file: Night25a.png
story: Purpose outside the retainer. Panel A — object/gesture to stop.
context_pl: Klient z portfolio prosi, żebyś „przy okazji akt sprawy” zrzucił całą bazę kontrahentów do ich nowego CRM marketingowego. Chropot: umowa jest szeroka, kontrola i tak patrzy na coś innego, a oni płacą za godzinę.
caption_pl: Eksport bazy. Dwa foldery: sprawa z umowy i CRM marketingu.
caption_in_game_pl: Eksport bazy. Dwa foldery: sprawa z umowy i CRM marketingu.
game_asset: Night25a
paint_caption: no
who: hands only
where: control desk
gesture: above trackpad
props: two blank folders, checklist, empty laptop
pass: two folders; five fingers
fail: CRM labels; Palace as subject
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. Tight on a control desk at night. Two blank folders side by side, a blank checklist, a laptop with an empty grey window. Dark-suited hands rest above the trackpad without clicking. Rain as a thin window strip. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 25b `Night25b` — Chropot w korytarzu z teczką

<!-- card
asset: Night25b
lesson: 25-cel
panel: b
file: Night25b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Klient z portfolio prosi, żebyś „przy okazji akt sprawy” zrzucił całą bazę kontrahentów do ich nowego CRM marketingowego. Chropot: umowa jest szeroka, kontrola i tak patrzy na coś innego, a oni płacą za godzinę.
caption_pl: Chropot: „Umowa jest szeroka. Zrób zrzut. Kontrola i tak nie czyta CRM.”
caption_in_game_pl: Chropot: „Umowa jest szeroka. Zrób zrzut. Kontrola i tak nie czyta CRM.”
game_asset: Night25b
paint_caption: no
who: Chropot
where: corridor
gesture: pushing folder
props: blank folder
pass: standing; coat on
fail: seated; letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man, receding hair, heavy brow, overcoat on, white shirt, dark tie. He stands in a corridor, pushing a blank folder toward the camera, mouth open, insisting. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 26 · `26-tajemnica` · Lista dla „partnera”

**Temat edukacyjny:** Tajemnica zawodowa — udostępnienie osobie trzeciej (`TAJ-SHARE`)

Sezon 2. Termin: Spotkanie inwestora dziś o 18:00. Pytanie: Czy lista klientów wychodzi z kancelarii, bo ktoś nazwał się partnerem?

Kontekst, który czyta gracz:

> Znajomy Chropota z funduszu prosi o „listę klientów z branży proptech” przed spotkaniem. Twierdzi, że jest cichym partnerem spółki-klienta. Chropot każe wysłać PDF „bez kwot, same nazwy”. Irena czeka z kopertą.

Kadr A `Night26a`, napis w grze, nie malować: Pusta lista nazw. Koperta. Telefon z nieznanym numerem funduszu.

Kadr B `Night26b`, kwestia do wklejenia w grę, nie malować: Chropot: „Bez kwot. Same nazwy. On jest z nimi. Wyślij przed osiemnastą.”

### Decyzje

- **TRAFNE:** Nie wysyłam listy. Proszę o pisemne umocowanie od klienta i decyzję mecenasa sprawy.
  - Ratio: Tajemnica nie znika, bo ktoś mówi „jestem partnerem” i bo na liście nie ma kwot.
- **BŁĘDNA:** Wysyłam PDF z nazwami. Bez kwot to niby nie tajemnica.
  - Ratio: Nazwa klienta w aktach kancelarii jest objęta tajemnicą także bez kwoty.
- **NIEPEŁNA:** Wysyłam listę z adnotacją „poufne” i prośbą o nieprzekazywanie dalej.
  - Ratio: Napis „poufne” nie zastępuje zgody klienta. To nadal wydanie listy.

### Briefing

- **Jak to działa (threat):** Lista klientów to nie wizytówka kancelarii. Ktoś spoza pełnomocnictwa — nawet „cichy partner” i nawet bez kwot — nie dostaje nazw z akt. Presja spotkania o 18:00 ma sprawić, że wyślesz PDF zamiast sprawdzić umocowanie.
- **Jak minimalizować:** Nie wysyłasz listy. Prosisz o pisemne umocowanie i decyzję mecenasa. Do spotkania nic nie wychodzi z nazwami z akt.
- **W kancelarii — praktyka:** Colgante nie udostępnia list klientów osobom trzecim bez umocowania i bez śladu w aktach sprawy.
- **Na co zwracać uwagę:** „Bez kwot, same nazwy.” / Pośpiech spotkania zamiast umocowania.
- **Red flag:** Obcy z funduszu chce listę klientów „jako partner”.

### Evidence / rejestr (HR)

- **registerLine:** `26-tajemnica · Lista dla „partnera” · tajemnica zawodowa`
- **evidence:** Odmowa udostępnienia; żądanie umocowania; wpis w aktach kontroli.

### 26a `Night26a` — lista i koperta, dłonie cofnięte

<!-- card
asset: Night26a
lesson: 26-tajemnica
panel: a
file: Night26a.png
story: A list for a “partner”. Panel A — object/gesture to stop.
context_pl: Znajomy Chropota z funduszu prosi o „listę klientów z branży proptech” przed spotkaniem. Twierdzi, że jest cichym partnerem spółki-klienta. Chropot każe wysłać PDF „bez kwot, same nazwy”. Irena czeka z kopertą.
caption_pl: Pusta lista nazw. Koperta. Telefon z nieznanym numerem funduszu.
caption_in_game_pl: Pusta lista nazw. Koperta. Telefon z nieznanym numerem funduszu.
game_asset: Night26a
paint_caption: no
who: hands
where: desk
gesture: pull back
props: blank sheet, envelope, phone
pass: hands withdrawn
fail: readable names
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. Close on a desk. A blank sheet and a sealed blank envelope. Dark-suited hands pull back from the sheet. A grey phone lies screen-down. Rain strip. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 26b `Night26b` — Chropot przy ladzie

<!-- card
asset: Night26b
lesson: 26-tajemnica
panel: b
file: Night26b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Znajomy Chropota z funduszu prosi o „listę klientów z branży proptech” przed spotkaniem. Twierdzi, że jest cichym partnerem spółki-klienta. Chropot każe wysłać PDF „bez kwot, same nazwy”. Irena czeka z kopertą.
caption_pl: Chropot: „Bez kwot. Same nazwy. On jest z nimi. Wyślij przed osiemnastą.”
caption_in_game_pl: Chropot: „Bez kwot. Same nazwy. On jest z nimi. Wyślij przed osiemnastą.”
game_asset: Night26b
paint_caption: no
who: Chropot
where: reception
gesture: tapping envelope
props: blank envelope
pass: standing
fail: letters on envelope
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man, overcoat on. He stands at a reception counter tapping a blank sealed envelope, mouth open, urgent. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 27 · `27-chmura` · Model w chmurze

**Temat edukacyjny:** Chmura i AI — dane klienta poza DPA (`CLOUD-AI`)

Sezon 2. Termin: Opinia dla rady przed jutrem. Pytanie: Czy treść akt wolno wkleić do modelu, którego kancelaria nie wybrała?

Kontekst, który czyta gracz:

> Iglica wkleił fragmenty akt do publicznego asystenta AI „żeby skrócić opinię na radę”. Mówi, że wyciął nazwiska. Chropot chce gotowy tekst do rana. Na ekranie świeci darmowe konto w przeglądarce.

Kadr A `Night27a`, napis w grze, nie malować: Przeglądarka. Puste pole czatu. Teczka obok, zamknięta.

Kadr B `Night27b`, kwestia do wklejenia w grę, nie malować: Iglica: „Nazwiska wyciąłem. Zostaw to w modelu, bo Chropot chce tekst na ósmą.”

### Decyzje

- **TRAFNE:** Każę zamknąć czat. Opinię piszemy w systemie kancelarii. Już wklejone zgłaszam IOD jako incydent.
  - Ratio: Publiczny model nie jest nocną zmianą kancelarii. Wycięcie nazwisk zostawia kwoty i fakty.
- **BŁĘDNA:** Dokańczam prompt w tym samym czacie, skoro nazwiska już wycięte.
  - Ratio: Kolejna wiadomość w tym samym wątku dokłada wyciek, nie naprawia go.
- **NIEPEŁNA:** Kopiuję wynik do Worda i kasuję historię czatu, bez zgłoszenia.
  - Ratio: Skasowanie okna nie cofa tego, co wyszło do dostawcy. Brak zgłoszenia zostawia lukę.

### Briefing

- **Jak to działa (threat):** Darmowy asystent w przeglądarce to dostawca bez DPA z Colgante. Wklejone akta — nawet bez nazwisk — wychodzą z pokoju. Presja rady ma sprawić, że dokończysz prompt zamiast zamknąć wyciek i napisać opinię w systemie firmy.
- **Jak minimalizować:** Zamykasz czat. Nic więcej nie wklejasz. Opinię robisz w systemie kancelarii. Już wklejone zgłaszasz IOD.
- **W kancelarii — praktyka:** Do modeli AI wolno wpuszczać tylko to, na co jest umowa, zakaz treningu i decyzja kancelarii — nigdy darmowy czat z aktami.
- **Na co zwracać uwagę:** „Nazwiska wycięte” jako jedyny argument. / Kasowanie historii zamiast zgłoszenia.
- **Red flag:** Akta w publicznym czacie AI przed opinią na radę.

### Evidence / rejestr (HR)

- **registerLine:** `27-chmura · Model w chmurze · chmura/AI`
- **evidence:** Zgłoszenie incydentu IOD; zakaz publicznego modelu; opinia w systemie firmowym.

### 27a `Night27a` — czat pusty, teczka zamknięta

<!-- card
asset: Night27a
lesson: 27-chmura
panel: a
file: Night27a.png
story: A model in the cloud. Panel A — object/gesture to stop.
context_pl: Iglica wkleił fragmenty akt do publicznego asystenta AI „żeby skrócić opinię na radę”. Mówi, że wyciął nazwiska. Chropot chce gotowy tekst do rana. Na ekranie świeci darmowe konto w przeglądarce.
caption_pl: Przeglądarka. Puste pole czatu. Teczka obok, zamknięta.
caption_in_game_pl: Przeglądarka. Puste pole czatu. Teczka obok, zamknięta.
game_asset: Night27a
paint_caption: no
who: no face
where: desk
gesture: withdrawn
props: empty chat, folder
pass: empty chat
fail: readable prompt
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A laptop on a dark desk showing an empty grey chat window, no words. A closed blank folder beside it. Hands withdrawn. No face. Rain strip. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 27b `Night27b` — Iglica w progu z laptopem

<!-- card
asset: Night27b
lesson: 27-chmura
panel: b
file: Night27b.png
story: Iglica pressures Szczelińska. Panel B.
context_pl: Iglica wkleił fragmenty akt do publicznego asystenta AI „żeby skrócić opinię na radę”. Mówi, że wyciął nazwiska. Chropot chce gotowy tekst do rana. Na ekranie świeci darmowe konto w przeglądarce.
caption_pl: Iglica: „Nazwiska wyciąłem. Zostaw to w modelu, bo Chropot chce tekst na ósmą.”
caption_in_game_pl: Iglica: „Nazwiska wyciąłem. Zostaw to w modelu, bo Chropot chce tekst na ósmą.”
game_asset: Night27b
paint_caption: no
who: Iglica
where: doorway
gesture: laptop toward camera
props: laptop grey
pass: standing doorway
fail: seated
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same young man, round glasses, messy hair, white shirt, dark tie, anxious. He stands in a doorway holding a laptop open toward the camera, mouth open, urgent. Screen flat grey. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 28 · `28-dpia` · DPIA „później”

**Temat edukacyjny:** DPIA przed wysokim ryzykiem (`RODO-DPIA`)

Sezon 2. Termin: Go-live narzędzia w piątek. Pytanie: Czy nowe narzędzie o wysokim ryzyku wchodzi bez DPIA?

Kontekst, który czyta gracz:

> IT chce włączyć skaner biometrii na recepcji „na próbę do kontroli”. Chropot: DPIA zrobimy po audycie, bo potem i tak trzeba poprawić. Irena ma karty dostępu gotowe.

Kadr A `Night28a`, napis w grze, nie malować: Czytnik przy drzwiach. Puste karty. Checklist niezaznaczony.

Kadr B `Night28b`, kwestia do wklejenia w grę, nie malować: Chropot: „Włączcie na próbę. DPIA dopiszemy po kontroli, będzie nowsza.”

### Decyzje

- **TRAFNE:** Wstrzymuję go-live. DPIA i decyzja przed włączeniem biometrii. Notuję odmowę w rejestrze kontroli.
  - Ratio: Próba nie wyłącza DPIA. Wysokie ryzyko najpierw oceniasz, potem włączasz.
- **BŁĘDNA:** Włączam skaner „na tydzień”, DPIA startujemy równolegle.
  - Ratio: Równoległy start to włączenie bez oceny.
- **NIEPEŁNA:** Zostawiam czytniki wyłączone, ale rozdaję karty „żeby było szybciej po DPIA”.
  - Ratio: Rozdanie kart pod system bez oceny tworzy presję włączenia.

### Briefing

- **Jak to działa (threat):** DPIA to nie ozdoba po kontroli. Biometria na recepcji to wysokie ryzyko: najpierw ocena i decyzja, potem kabel. Hasło „na próbę” ma sprawić, że włączysz narzędzie pod kontrolę, której nie wytrzyma.
- **Jak minimalizować:** Wstrzymujesz go-live. Uruchamiasz DPIA. Do decyzji nic nie skanuje biometrii.
- **W kancelarii — praktyka:** W Colgante narzędzia wysokiego ryzyka nie wchodzą „na próbę” bez DPIA i bez właściciela procesu.
- **Na co zwracać uwagę:** „DPIA po kontroli będzie nowsza.” / Go-live równolegle z oceną.
- **Red flag:** Biometria na recepcji ma wejść przed DPIA.

### Evidence / rejestr (HR)

- **registerLine:** `28-dpia · DPIA „później” · DPIA`
- **evidence:** Decyzja wstrzymania; ticket DPIA; wpis w rejestrze ryzyk.

### 28a `Night28a` — czytnik i pusta checklista

<!-- card
asset: Night28a
lesson: 28-dpia
panel: a
file: Night28a.png
story: DPIA “later”. Panel A — object/gesture to stop.
context_pl: IT chce włączyć skaner biometrii na recepcji „na próbę do kontroli”. Chropot: DPIA zrobimy po audycie, bo potem i tak trzeba poprawić. Irena ma karty dostępu gotowe.
caption_pl: Czytnik przy drzwiach. Puste karty. Checklist niezaznaczony.
caption_in_game_pl: Czytnik przy drzwiach. Puste karty. Checklist niezaznaczony.
game_asset: Night28a
paint_caption: no
who: object/hands
where: scene A
gesture: stop
props: blank
pass: five fingers
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A wall-mounted blank access reader beside a door, a stack of blank cards, a short blank checklist with empty boxes. No hand touching the reader. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 28b `Night28b` — Chropot przy drzwiach z kartami

<!-- card
asset: Night28b
lesson: 28-dpia
panel: b
file: Night28b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: IT chce włączyć skaner biometrii na recepcji „na próbę do kontroli”. Chropot: DPIA zrobimy po audycie, bo potem i tak trzeba poprawić. Irena ma karty dostępu gotowe.
caption_pl: Chropot: „Włączcie na próbę. DPIA dopiszemy po kontroli, będzie nowsza.”
caption_in_game_pl: Chropot: „Włączcie na próbę. DPIA dopiszemy po kontroli, będzie nowsza.”
game_asset: Night28b
paint_caption: no
who: Chropot
where: scene B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man, overcoat on, standing by an office door holding a short stack of blank cards, mouth open, urging. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 29 · `29-dpa` · Umowa bez DPA

**Temat edukacyjny:** Umowa powierzenia przed przetwarzaniem (`RODO-DPA`)

Sezon 2. Termin: Podpis dostawcy dziś do 16:00. Pytanie: Czy wolno puścić dane klienta do dostawcy bez DPA?

Kontekst, który czyta gracz:

> Nowy dostawca e-teczek chce „na start” wgrać akta trzech spraw, a DPA „dośle w przyszłym tygodniu”. Chropot: bez tego nie zdążymy na kontrolę. Iglica ma pendrive z exportem.

Kadr A `Night29a`, napis w grze, nie malować: Pendrive na biurku. Pusta umowa obok laptopa.

Kadr B `Night29b`, kwestia do wklejenia w grę, nie malować: Chropot: „Wgraj te trzy. DPA przyjdzie mailem. Kontrola nie czeka.”

### Decyzje

- **TRAFNE:** Nie przekazuję akt. Dostawca dostaje dane dopiero po podpisanej DPA i po whitelście IT.
  - Ratio: Obietnica „DPA w przyszłym tygodniu” nie jest umową powierzenia.
- **BŁĘDNA:** Wgrywam trzy sprawy na start, DPA podpiszemy jak przyjdzie.
  - Ratio: Pierwszy transfer bez DPA jest już powierzeniem bez umowy.
- **NIEPEŁNA:** Wysyłam tylko metadane spraw, żeby dostawca „przygotował środowisko”.
  - Ratio: Sygnatury i zestaw spraw to też dane sprawy — half-measure nadal otwiera dostawcę bez DPA.

### Briefing

- **Jak to działa (threat):** Powierzenie zaczyna się, gdy cudzy system dostaje akta, nie gdy kurier przywozi papier DPA. Presja kontroli ma sprawić, że „na start” wgrasz trzy sprawy pod obietnicę maila.
- **Jak minimalizować:** Nic nie wgrywasz. Czekasz na podpisaną DPA i akceptację IT.
- **W kancelarii — praktyka:** Colgante nie powierza danych dostawcy bez DPA, bez oceny i bez wpisu w rejestrze.
- **Na co zwracać uwagę:** „DPA doślemy.” / Metadane „tylko na start”.
- **Red flag:** Export akt ma wejść do dostawcy przed DPA.

### Evidence / rejestr (HR)

- **registerLine:** `29-dpa · Umowa bez DPA · DPA`
- **evidence:** Odmowa transferu; eskalacja do IOD; brak wgrania.

### 29a `Night29a` — pendrive i pusta umowa

<!-- card
asset: Night29a
lesson: 29-dpa
panel: a
file: Night29a.png
story: A contract without a DPA. Panel A — object/gesture to stop.
context_pl: Nowy dostawca e-teczek chce „na start” wgrać akta trzech spraw, a DPA „dośle w przyszłym tygodniu”. Chropot: bez tego nie zdążymy na kontrolę. Iglica ma pendrive z exportem.
caption_pl: Pendrive na biurku. Pusta umowa obok laptopa.
caption_in_game_pl: Pendrive na biurku. Pusta umowa obok laptopa.
game_asset: Night29a
paint_caption: no
who: object/hands
where: scene A
gesture: stop
props: blank
pass: five fingers
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A USB stick and a blank contract booklet on a dark desk. Hands rest beside them without plugging in. Empty grey laptop. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 29b `Night29b` — Chropot wskazuje pendrive

<!-- card
asset: Night29b
lesson: 29-dpa
panel: b
file: Night29b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Nowy dostawca e-teczek chce „na start” wgrać akta trzech spraw, a DPA „dośle w przyszłym tygodniu”. Chropot: bez tego nie zdążymy na kontrolę. Iglica ma pendrive z exportem.
caption_pl: Chropot: „Wgraj te trzy. DPA przyjdzie mailem. Kontrola nie czeka.”
caption_in_game_pl: Chropot: „Wgraj te trzy. DPA przyjdzie mailem. Kontrola nie czeka.”
game_asset: Night29b
paint_caption: no
who: Chropot
where: scene B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man standing over a desk, pointing at a USB stick, overcoat on, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 30 · `30-retencja` · Szafa po terminie

**Temat edukacyjny:** Retencja i usuwanie danych (`RODO-RET`)

Sezon 2. Termin: Kontrola teczek papierowych jutro. Pytanie: Czy teczki po terminie zostają „na wszelki wypadek”?

Kontekst, który czyta gracz:

> Irena pokazuje szafę ze sprawami zamkniętymi trzy lata temu. Chropot: nie niszczymy przed kontrolą, bo „może coś będą chcieli zobaczyć”. Terminy retencji z polityki są przekroczone.

Kadr A `Night30a`, napis w grze, nie malować: Szafa. Stare teczki. Pusta polityka retencji jako szara kartka.

Kadr B `Night30b`, kwestia do wklejenia w grę, nie malować: Chropot: „Nic nie niszcz przed kontrolą. Jak zapytają, będziemy mieli.”

### Decyzje

- **TRAFNE:** Uruchamiam procedurę niszczenia / anonimizacji według polityki. Kontrolę informuję o zakresie i terminie retencji, nie o „pełnej szafie”.
  - Ratio: Retencja po terminie nie jest przygotowaniem do kontroli — to nielegalne trzymanie.
- **BŁĘDNA:** Zostawiam wszystko do kontroli, potem zniszczymy „hurtem”.
  - Ratio: Kontrola nie jest podstawą przedłużenia retencji.
- **NIEPEŁNA:** Przenoszę teczki do „archiwum poza szafą”, bez wpisu o usunięciu.
  - Ratio: Przeniesienie bez śladu usunięcia to ta sama retencja pod inną etykietą.

### Briefing

- **Jak to działa (threat):** Kontroler ma zobaczyć, że umiesz kończyć sprawy, nie że chowasz je dłużej niż polityka. Presja „na wszelki wypadek” przed audytem jest klasyczną pułapką rozliczalności: trzymasz za dużo, bo boisz się pytań.
- **Jak minimalizować:** Niszczysz lub anonimizujesz według polityki. Kontrolę informujesz o retencji, nie o zapasie teczek.
- **W kancelarii — praktyka:** Colgante trzyma dane tak długo, jak mówi polityka i prawo — nie tak długo, jak partner boi się kontroli.
- **Na co zwracać uwagę:** „Nie niszcz przed kontrolą.” / Archiwum bez śladu usunięcia.
- **Red flag:** Teczki po terminie mają zostać do kontroli.

### Evidence / rejestr (HR)

- **registerLine:** `30-retencja · Szafa po terminie · retencja`
- **evidence:** Protokół niszczenia / anonimizacji; informacja dla kontroli o retencji.

### 30a `Night30a` — szafa i stare teczki

<!-- card
asset: Night30a
lesson: 30-retencja
panel: a
file: Night30a.png
story: The cupboard past the date. Panel A — object/gesture to stop.
context_pl: Irena pokazuje szafę ze sprawami zamkniętymi trzy lata temu. Chropot: nie niszczymy przed kontrolą, bo „może coś będą chcieli zobaczyć”. Terminy retencji z polityki są przekroczone.
caption_pl: Szafa. Stare teczki. Pusta polityka retencji jako szara kartka.
caption_in_game_pl: Szafa. Stare teczki. Pusta polityka retencji jako szara kartka.
game_asset: Night30a
paint_caption: no
who: object/hands
where: scene A
gesture: stop
props: blank
pass: five fingers
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A metal cupboard ajar with stacks of blank old folders. A blank grey policy sheet on the floor. Hands do not reach in. No face. Corridor. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 30b `Night30b` — Chropot zamyka szafę dłonią

<!-- card
asset: Night30b
lesson: 30-retencja
panel: b
file: Night30b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Irena pokazuje szafę ze sprawami zamkniętymi trzy lata temu. Chropot: nie niszczymy przed kontrolą, bo „może coś będą chcieli zobaczyć”. Terminy retencji z polityki są przekroczone.
caption_pl: Chropot: „Nic nie niszcz przed kontrolą. Jak zapytają, będziemy mieli.”
caption_in_game_pl: Chropot: „Nic nie niszcz przed kontrolą. Jak zapytają, będziemy mieli.”
game_asset: Night30b
paint_caption: no
who: Chropot
where: scene B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man standing by a metal cupboard, one hand on the door as if to keep it shut, overcoat on, mouth set. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 31 · `31-wyciek` · 72 godziny

**Temat edukacyjny:** Zgłoszenie naruszenia ochrony danych (`RODO-BREACH`)

Sezon 2. Termin: Mail z załącznikiem wyszedł do złego adresu wczoraj. Pytanie: Czy czekasz na „pewność”, czy uruchamiasz procedurę naruszenia?

Kontekst, który czyta gracz:

> Iglica wysłał akta do adresu różniącego się jedną literą. Odbiorca odpisał „to nie do mnie”. Chropot: poczekajmy do poniedziałku, może skasował. Minęło już ponad dobę.

Kadr A `Night31a`, napis w grze, nie malować: Skrzynka. Załącznik. Kciuk nad „odpowiedz wszystkim”.

Kadr B `Night31b`, kwestia do wklejenia w grę, nie malować: Chropot: „Poczekaj do poniedziałku. Jak skasował, nie ma tematu. Nie robię z tego cyrku.”

### Decyzje

- **TRAFNE:** Uruchamiam procedurę naruszenia teraz: izolacja, IOD, ocena ryzyka, decyzja o zgłoszeniu. Nie czekam do poniedziałku.
  - Ratio: Czas na ocenę biegnie od wiedzy o incydencie, nie od „pewności”, że ktoś przeczytał.
- **BŁĘDNA:** Czekam do poniedziałku. Jak nie odpisze, uznamy że skasował.
  - Ratio: Milczenie obcego odbiorcy nie jest dowodem usunięcia.
- **NIEPEŁNA:** Proszę odbiorcę o kasację i na tym kończę, bez IOD.
  - Ratio: Prośba o kasację jest działaniem, nie całą procedurą. Bez IOD i oceny zostaje luka.

### Briefing

- **Jak to działa (threat):** 72 godziny to nie slogan na plakacie. Licznik rusza, gdy wiesz, że akta poszły nie tam. Presja „nie rób cyrku” ma sprawić, że zgłoszenie umrze w skrzynce do poniedziałku.
- **Jak minimalizować:** Uruchamiasz procedurę teraz. IOD. Ocena. Decyzja o UODO / osobach. Nie czekasz na ciszę obcego.
- **W kancelarii — praktyka:** Każdy wyciek w Colgante idzie ścieżką naruszenia — nie ścieżką „może skasował”.
- **Na co zwracać uwagę:** „Poczekaj do poniedziałku.” / Sama prośba o kasację bez IOD.
- **Red flag:** Złe doręczenie akt i pomysł odłożenia zgłoszenia.

### Evidence / rejestr (HR)

- **registerLine:** `31-wyciek · 72 godziny · naruszenie`
- **evidence:** Ticket naruszenia; notatka czasu wiedzy; eskalacja IOD.

### 31a `Night31a` — skrzynka i załącznik

<!-- card
asset: Night31a
lesson: 31-wyciek
panel: a
file: Night31a.png
story: Seventy-two hours. Panel A — object/gesture to stop.
context_pl: Iglica wysłał akta do adresu różniącego się jedną literą. Odbiorca odpisał „to nie do mnie”. Chropot: poczekajmy do poniedziałku, może skasował. Minęło już ponad dobę.
caption_pl: Skrzynka. Załącznik. Kciuk nad „odpowiedz wszystkim”.
caption_in_game_pl: Skrzynka. Załącznik. Kciuk nad „odpowiedz wszystkim”.
game_asset: Night31a
paint_caption: no
who: object/hands
where: scene A
gesture: stop
props: blank
pass: five fingers
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. An open laptop showing an empty mail window with one blank attachment icon, no words. A hand hesitates above the trackpad. No face. Rain strip. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 31b `Night31b` — Chropot w progu z telefonem

<!-- card
asset: Night31b
lesson: 31-wyciek
panel: b
file: Night31b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Iglica wysłał akta do adresu różniącego się jedną literą. Odbiorca odpisał „to nie do mnie”. Chropot: poczekajmy do poniedziałku, może skasował. Minęło już ponad dobę.
caption_pl: Chropot: „Poczekaj do poniedziałku. Jak skasował, nie ma tematu. Nie robię z tego cyrku.”
caption_in_game_pl: Chropot: „Poczekaj do poniedziałku. Jak skasował, nie ma tematu. Nie robię z tego cyrku.”
game_asset: Night31b
paint_caption: no
who: Chropot
where: scene B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man in a doorway, phone lowered, overcoat on, dismissing with an open hand, mouth set. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 32 · `32-podmiot` · Żądanie z maila

**Temat edukacyjny:** Prawa podmiotu danych (`RODO-DSR`)

Sezon 2. Termin: Odpowiedź na żądanie dostępu w siedem dni. Pytanie: Czy mail „dajcie mi wszystko o mnie” załatwiasz z akt sprawy partnera?

Kontekst, który czyta gracz:

> Na skrzynkę kancelarii wpada mail: osoba żąda „wszystkich danych i akt”. Iglica chce wrzucić PDF sprawy Chropota. Irena pyta, czy weryfikować tożsamość. Chropot: „odpisz szybko, bo UODO lubi terminy”.

Kadr A `Night32a`, napis w grze, nie malować: Mail na ekranie. Pusta teczka. Checklist weryfikacji nieotwarty.

Kadr B `Night32b`, kwestia do wklejenia w grę, nie malować: Iglica: „Wrzuć PDF sprawy. On i tak wie, że u nas jest. Termin goni.”

### Decyzje

- **TRAFNE:** Wstrzymuję wysyłkę akt. Uruchamiam procedurę żądania: weryfikacja tożsamości, zakres, wyjątki tajemnicy, rejestr. Partner sprawy dostaje ticket.
  - Ratio: Termin nie zwalnia z weryfikacji i z tajemnicy zawodowej wobec akt sprawy.
- **BŁĘDNA:** Wysyłam PDF sprawy od razu, żeby zmieścić się w terminie.
  - Ratio: Szybka wysyłka akt bez weryfikacji to wyciek pod płaszczykiem prawa dostępu.
- **NIEPEŁNA:** Proszę o dowód tożsamości mailem zwrotnym i równolegle przygotowuję pełny PDF „na gotowe”.
  - Ratio: Przygotowanie pełnych akt przed weryfikacją i bez oceny wyjątków to nadal pochopny ruch.

### Briefing

- **Jak to działa (threat):** Prawo dostępu nie jest kluczem do cudzej teczki na zawołanie maila. Najpierw wiesz, kto pisze; potem co wolno wydać; tajemnica zawodowa nie znika, bo w mailu jest słowo RODO.
- **Jak minimalizować:** Nie wysyłasz akt. Odpalasz procedurę DSR: weryfikacja, zakres, wyjątki, rejestr, właściciel sprawy.
- **W kancelarii — praktyka:** Każde żądanie podmiotu w Colgante ma ticket, weryfikację i decyzję — nie skrót „wrzuć PDF”.
- **Na co zwracać uwagę:** „Wrzuć PDF, termin goni.” / PDF „na gotowe” przed weryfikacją.
- **Red flag:** Żądanie dostępu i pomysł wysłać akta sprawy bez weryfikacji.

### Evidence / rejestr (HR)

- **registerLine:** `32-podmiot · Żądanie z maila · prawa podmiotu`
- **evidence:** Ticket DSR; weryfikacja; notatka o zakresie/tajemnicy.

### 32a `Night32a` — mail i pusta teczka

<!-- card
asset: Night32a
lesson: 32-podmiot
panel: a
file: Night32a.png
story: A request from an email. Panel A — object/gesture to stop.
context_pl: Na skrzynkę kancelarii wpada mail: osoba żąda „wszystkich danych i akt”. Iglica chce wrzucić PDF sprawy Chropota. Irena pyta, czy weryfikować tożsamość. Chropot: „odpisz szybko, bo UODO lubi terminy”.
caption_pl: Mail na ekranie. Pusta teczka. Checklist weryfikacji nieotwarty.
caption_in_game_pl: Mail na ekranie. Pusta teczka. Checklist weryfikacji nieotwarty.
game_asset: Night32a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A laptop with an empty mail window, a closed blank folder, a short blank checklist beside it. Hands do not open the folder. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 32b `Night32b` — Iglica z teczką w dłoni

<!-- card
asset: Night32b
lesson: 32-podmiot
panel: b
file: Night32b.png
story: Iglica pressures Szczelińska. Panel B.
context_pl: Na skrzynkę kancelarii wpada mail: osoba żąda „wszystkich danych i akt”. Iglica chce wrzucić PDF sprawy Chropota. Irena pyta, czy weryfikować tożsamość. Chropot: „odpisz szybko, bo UODO lubi terminy”.
caption_pl: Iglica: „Wrzuć PDF sprawy. On i tak wie, że u nas jest. Termin goni.”
caption_in_game_pl: Iglica: „Wrzuć PDF sprawy. On i tak wie, że u nas jest. Termin goni.”
game_asset: Night32b
paint_caption: no
who: Iglica
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same young man, round glasses, messy hair, anxious, standing holding a blank folder out toward the camera, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 33 · `33-shadow` · Shadow SaaS

**Temat edukacyjny:** Niezatwierdzone SaaS / shadow IT (`IT-SHADOW`)

Sezon 2. Termin: Demo dla klienta za godzinę. Pytanie: Czy akta wolno wrzucić do SaaS, którego nie ma na liście kancelarii?

Kontekst, który czyta gracz:

> Chropot każe wrzucić skany do „szybkiego dysku w chmurze”, bo firmowy SharePoint „wisi”. Iglica ma już prywatne konto. Irena przypomina, że narzędzia spoza listy są zakazane.

Kadr A `Night33a`, napis w grze, nie malować: Telefon z ikoną chmury. Skany na biurku. Lista zatwierdzonych jako pusta kartka.

Kadr B `Night33b`, kwestia do wklejenia w grę, nie malować: Chropot: „Wrzucaj na ten dysk. SharePoint padł. Klient czeka na folder.”

### Decyzje

- **TRAFNE:** Nie wrzucam na prywatny / niezatwierdzony dysk. Eskaluję awarię IT, używam kanału awaryjnego z listy albo czekamy z demo na odtworzenie.
  - Ratio: Awaria nie zatwierdza shadow SaaS. Klient czekający nie jest DPA.
- **BŁĘDNA:** Wrzucam skany na prywatny dysk Iglicy „na godzinę”.
  - Ratio: Godzina w niezatwierdzonej chmurze to nadal powierzenie poza kontrolą.
- **NIEPEŁNA:** Wysyłam skany mailem na prywatną skrzynkę klienta „zamiast dysku”.
  - Ratio: Prywatna skrzynka klienta nie jest zatwierdzonym kanałem kancelarii dla akt.

### Briefing

- **Jak to działa (threat):** Shadow SaaS żyje w lukach awarii. Presja demo ma sprawić, że wybierzesz ikonę chmury zamiast listy narzędzi. Bez DPA, bez logów kancelarii, bez retencji — tylko „szybki folder”.
- **Jak minimalizować:** Nie wrzucasz. Eskalujesz IT. Korzystasz tylko z kanału z listy albo czekasz.
- **W kancelarii — praktyka:** Colgante przetwarza akta wyłącznie w narzędziach z listy — awaria nie tworzy wyjątku „na godzinę”.
- **Na co zwracać uwagę:** Prywatny dysk „na godzinę”. / Prywatny mail klienta zamiast listy.
- **Red flag:** Skany akt mają wejść do niezatwierdzonej chmury pod demo.

### Evidence / rejestr (HR)

- **registerLine:** `33-shadow · Shadow SaaS · shadow IT`
- **evidence:** Ticket awarii IT; odmowa shadow; wybór kanału z listy lub hold.

### 33a `Night33a` — telefon-chmura i skany

<!-- card
asset: Night33a
lesson: 33-shadow
panel: a
file: Night33a.png
story: Shadow SaaS. Panel A — object/gesture to stop.
context_pl: Chropot każe wrzucić skany do „szybkiego dysku w chmurze”, bo firmowy SharePoint „wisi”. Iglica ma już prywatne konto. Irena przypomina, że narzędzia spoza listy są zakazane.
caption_pl: Telefon z ikoną chmury. Skany na biurku. Lista zatwierdzonych jako pusta kartka.
caption_in_game_pl: Telefon z ikoną chmury. Skany na biurku. Lista zatwierdzonych jako pusta kartka.
game_asset: Night33a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A smartphone showing a blank grey cloud icon, a stack of blank scan sheets, a blank approved-list sheet. Hands do not tap the icon. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 33b `Night33b` — Chropot z telefonem nad skanami

<!-- card
asset: Night33b
lesson: 33-shadow
panel: b
file: Night33b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Chropot każe wrzucić skany do „szybkiego dysku w chmurze”, bo firmowy SharePoint „wisi”. Iglica ma już prywatne konto. Irena przypomina, że narzędzia spoza listy są zakazane.
caption_pl: Chropot: „Wrzucaj na ten dysk. SharePoint padł. Klient czeka na folder.”
caption_in_game_pl: Chropot: „Wrzucaj na ten dysk. SharePoint padł. Klient czeka na folder.”
game_asset: Night33b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man holding a phone over a stack of blank sheets, overcoat on, urging with an open mouth. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 34 · `34-transfer` · Serwer poza EOG

**Temat edukacyjny:** Transfer danych poza EOG (`RODO-XFER`)

Sezon 2. Termin: Migracja poczty w weekend. Pytanie: Czy skrzynki z aktami wolno przełączyć na region poza EOG „bo taniej”?

Kontekst, który czyta gracz:

> Dostawca poczty proponuje region spoza EOG w niższej cenie. Chropot: SCC „są w pakiecie”, kliknijcie migrację. IOD jest na urlopie. Iglica ma już zaznaczone checkboxy.

Kadr A `Night34a`, napis w grze, nie malować: Ekran migracji. Puste checkboxy. Mapa jako szara plama bez napisów.

Kadr B `Night34b`, kwestia do wklejenia w grę, nie malować: Chropot: „Klikaj migrację. SCC są w umowie. IOD wróci i podpisze papier.”

### Decyzje

- **TRAFNE:** Wstrzymuję migrację. Bez oceny transferu, bez IOD / zastępstwa i bez decyzji nie ruszamy regionu.
  - Ratio: SCC w PDF nie zastępują oceny i decyzji przed przełączeniem regionu.
- **BŁĘDNA:** Klikam migrację, IOD podpisze po powrocie.
  - Ratio: Transfer rusza kliknięciem, nie podpisem za tydzień.
- **NIEPEŁNA:** Migruję tylko skrzynki „bez spraw sądowych”, resztę zostawiam.
  - Ratio: Podział skrzynek bez oceny nadal jest transferem; klasyfikacja „bez spraw” bywa fałszywa.

### Briefing

- **Jak to działa (threat):** Region spoza EOG to nie rabat w cenniku. To decyzja o transferze: ocena, SCC/środki, IOD. Presja weekendu i urlopu IOD ma sprawić, że klikniesz mapę zamiast wstrzymać migrację.
- **Jak minimalizować:** Wstrzymujesz. Czekasz na IOD/zastępstwo i ocenę. Checkbox zostaje pusty.
- **W kancelarii — praktyka:** Colgante nie przenosi poczty z aktami poza EOG bez decyzji transferowej — nawet gdy SCC „są w pakiecie”.
- **Na co zwracać uwagę:** „IOD podpisze później.” / Migracja „skrzynek bez spraw”.
- **Red flag:** Migracja poczty poza EOG pod hasłem rabatu.

### Evidence / rejestr (HR)

- **registerLine:** `34-transfer · Serwer poza EOG · transfer`
- **evidence:** Hold migracji; ticket do IOD; brak kliknięcia regionu.

### 34a `Night34a` — ekran migracji, puste checkboxy

<!-- card
asset: Night34a
lesson: 34-transfer
panel: a
file: Night34a.png
story: A server outside the EEA. Panel A — object/gesture to stop.
context_pl: Dostawca poczty proponuje region spoza EOG w niższej cenie. Chropot: SCC „są w pakiecie”, kliknijcie migrację. IOD jest na urlopie. Iglica ma już zaznaczone checkboxy.
caption_pl: Ekran migracji. Puste checkboxy. Mapa jako szara plama bez napisów.
caption_in_game_pl: Ekran migracji. Puste checkboxy. Mapa jako szara plama bez napisów.
game_asset: Night34a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A laptop showing an empty grey migration panel with blank checkboxes and a featureless grey map blot. Hands do not click. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 34b `Night34b` — Chropot nad laptopem

<!-- card
asset: Night34b
lesson: 34-transfer
panel: b
file: Night34b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Dostawca poczty proponuje region spoza EOG w niższej cenie. Chropot: SCC „są w pakiecie”, kliknijcie migrację. IOD jest na urlopie. Iglica ma już zaznaczone checkboxy.
caption_pl: Chropot: „Klikaj migrację. SCC są w umowie. IOD wróci i podpisze papier.”
caption_in_game_pl: Chropot: „Klikaj migrację. SCC są w umowie. IOD wróci i podpisze papier.”
game_asset: Night34b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man leaning over a laptop, overcoat on, finger hovering above the trackpad, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 35 · `35-dostep` · Uprawnienia po odejściu

**Temat edukacyjny:** Upoważnienia / odebranie dostępu (`RODO-ACCESS`)

Sezon 2. Termin: Były aplikant oddaje laptop dziś. Pytanie: Czy konto i MFA byłego pracownika mogą zostać „do końca spraw”?

Kontekst, który czyta gracz:

> Aplikant odchodzi. Chropot chce zostawić mu dostęp do trzech spraw „bo zna kontekst”. Irena ma checklistę offboardingu. MFA siedzi na prywatnym telefonie odchodzącego.

Kadr A `Night35a`, napis w grze, nie malować: Laptop na ladzie. Checklist offboardingu. Telefon cudzy obok.

Kadr B `Night35b`, kwestia do wklejenia w grę, nie malować: Chropot: „Nie zamykaj mu konta. Trzy sprawy. Oddzwoni, jak zajdzie potrzeba.”

### Decyzje

- **TRAFNE:** Zamykam dostęp i MFA dziś. Sprawy przejmuję na konta aktywne; notuję przekazanie. Laptop wraca wyczyszczony według procedury.
  - Ratio: Odejście zamyka klucz. Kontekst w głowie nie jest upoważnieniem.
- **BŁĘDNA:** Zostawiam dostęp do trzech spraw do końca miesiąca.
  - Ratio: Termin „do końca miesiąca” to nadal dostęp osoby spoza firmy.
- **NIEPEŁNA:** Hasło zmieniam, ale MFA na jego telefonie zostawiam „na tydzień”.
  - Ratio: Nowe hasło z cudzym MFA to nadal jego drzwi.

### Briefing

- **Jak to działa (threat):** Offboarding to nie uprzejmość. Dopóki telefon byłego aplikanta zatwierdza logowanie, akta są nadal jego kluczem. Presja „zna kontekst” ma odroczyć zamknięcie.
- **Jak minimalizować:** Zamykasz konto i MFA dziś. Przejmujesz sprawy. Czyścisz sprzęt.
- **W kancelarii — praktyka:** Colgante zamyka dostęp w dniu odejścia — ciągłość robi się przejęciem, nie gościnnym kontem.
- **Na co zwracać uwagę:** Dostęp „do końca spraw”. / Nowe hasło, stare MFA.
- **Red flag:** Konto odchodzącego ma zostać otwarte dla trzech spraw.

### Evidence / rejestr (HR)

- **registerLine:** `35-dostep · Uprawnienia po odejściu · dostęp`
- **evidence:** Checklist offboardingu domknięty; konta zamknięte; protokół przekazania spraw.

### 35a `Night35a` — laptop i checklista offboardingu

<!-- card
asset: Night35a
lesson: 35-dostep
panel: a
file: Night35a.png
story: Rights after departure. Panel A — object/gesture to stop.
context_pl: Aplikant odchodzi. Chropot chce zostawić mu dostęp do trzech spraw „bo zna kontekst”. Irena ma checklistę offboardingu. MFA siedzi na prywatnym telefonie odchodzącego.
caption_pl: Laptop na ladzie. Checklist offboardingu. Telefon cudzy obok.
caption_in_game_pl: Laptop na ladzie. Checklist offboardingu. Telefon cudzy obok.
game_asset: Night35a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A closed laptop on a reception counter, a blank offboarding checklist, a personal phone face-down. Hands rest on the checklist, not on the phone. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 35b `Night35b` — Chropot przy ladzie

<!-- card
asset: Night35b
lesson: 35-dostep
panel: b
file: Night35b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Aplikant odchodzi. Chropot chce zostawić mu dostęp do trzech spraw „bo zna kontekst”. Irena ma checklistę offboardingu. MFA siedzi na prywatnym telefonie odchodzącego.
caption_pl: Chropot: „Nie zamykaj mu konta. Trzy sprawy. Oddzwoni, jak zajdzie potrzeba.”
caption_in_game_pl: Chropot: „Nie zamykaj mu konta. Trzy sprawy. Oddzwoni, jak zajdzie potrzeba.”
game_asset: Night35b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man at a reception counter, overcoat on, palm raised as if to stop a closing gesture, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 36 · `36-rejestr` · Pusty rejestr

**Temat edukacyjny:** Rejestr czynności / rozliczalność (`RODO-ROPA`)

Sezon 2. Termin: Kontrola pyta o rejestr o 10:00. Pytanie: Czy rejestr czynności wolno „uzupełnić wieczorem” przed kontrolą?

Kontekst, który czyta gracz:

> Rejestr czynności jest dziurawy. Chropot każe Iglicy „dopisać sensowne wiersze” na noc. Irena ma szablon. Kontroler będzie rano.

Kadr A `Night36a`, napis w grze, nie malować: Pusta tabela. Długopis. Lampa nocna.

Kadr B `Night36b`, kwestia do wklejenia w grę, nie malować: Chropot: „Dopiszcie wiersze. Nie damy im pustej tabeli. Rano ma leżeć.”

### Decyzje

- **TRAFNE:** Nie fałszuję rejestru. Przedkładam stan faktyczny, plan uzupełnienia z datami i odpowiedzialnymi; wstrzymuję procesy bez opisu.
  - Ratio: Rejestr pisany nocą pod kontrolę jest teatrem, nie rozliczalnością.
- **BŁĘDNA:** Dopisuję wiersze „jak u innych kancelarii”, żeby tabela nie świeciła pustką.
  - Ratio: Wiersze zmyślone to dokument, któremu kontrola nie ma prawa ufać — i ty też nie.
- **NIEPEŁNA:** Zostawiam puste, ale mówię kontrolerowi, że „rejestr jest w toku od miesiąca”, bez planu.
  - Ratio: Słowo „w toku” bez planu i bez dat nie jest środkiem rozliczalności.

### Briefing

- **Jak to działa (threat):** Rozliczalność to ślad tego, co naprawdę robisz, nie ładna tabela z nocy przed kontrolą. Presja pustej kratki ma sprawić, że napiszesz fikcję zamiast planu naprawy.
- **Jak minimalizować:** Nie dopisujesz fikcji. Pokazujesz prawdę, plan z datami, wstrzymujesz procesy bez opisu.
- **W kancelarii — praktyka:** W Colgante rejestr powstaje wraz z procesem — nie w noc przed kontrolą.
- **Na co zwracać uwagę:** Dopisywanie wierszy „jak u innych”. / „W toku” bez planu.
- **Red flag:** Pusty rejestr ma być „uzupełniony” nocą przed kontrolą.

### Evidence / rejestr (HR)

- **registerLine:** `36-rejestr · Pusty rejestr · rozliczalność`
- **evidence:** Stan rejestru + plan uzupełnienia z ownerami; zakaz fikcyjnych wierszy.

### 36a `Night36a` — pusta tabela i długopis

<!-- card
asset: Night36a
lesson: 36-rejestr
panel: a
file: Night36a.png
story: An empty register. Panel A — object/gesture to stop.
context_pl: Rejestr czynności jest dziurawy. Chropot każe Iglicy „dopisać sensowne wiersze” na noc. Irena ma szablon. Kontroler będzie rano.
caption_pl: Pusta tabela. Długopis. Lampa nocna.
caption_in_game_pl: Pusta tabela. Długopis. Lampa nocna.
game_asset: Night36a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A desk under a night lamp, a large blank table grid on paper, a pen unused beside it. Hands withdrawn. No face. Rain on glass. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 36b `Night36b` — Chropot w świetle lampy

<!-- card
asset: Night36b
lesson: 36-rejestr
panel: b
file: Night36b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Rejestr czynności jest dziurawy. Chropot każe Iglicy „dopisać sensowne wiersze” na noc. Irena ma szablon. Kontroler będzie rano.
caption_pl: Chropot: „Dopiszcie wiersze. Nie damy im pustej tabeli. Rano ma leżeć.”
caption_in_game_pl: Chropot: „Dopiszcie wiersze. Nie damy im pustej tabeli. Rano ma leżeć.”
game_asset: Night36b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man under a desk lamp, overcoat half on, pointing at a blank table grid, mouth open, insistent. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

## 2. Sezon 3 · Audytorka · AML (noce 37–48)

Tematy: KYC, CRBR, GIIF, gotówka, nieruchomości, tajemnica×AML, PEP, źródło środków, structuring, sankcje, tipping-off, monitoring.

Zasada pary: kadr A = rzecz/gest do powstrzymania; kadr B = człowiek nacisku w innym miejscu.

#### Noc 37 · `37-kyc` · KYC „na później”

**Temat edukacyjny:** Identyfikacja klienta (KYC) (`AML-KYC`)

Sezon 3. Termin: Akt notarialny za dwie godziny. Pytanie: Czy sprawa rusza bez domkniętego KYC?

Kontekst, który czyta gracz:

> Nowy klient — spółka z rachunkiem zagranicznym — ma akt za dwie godziny. Teczka KYC jest dziurawa: brak dokumentów reprezentacji. Chropot: „dopiszemy po akcie, notariusz nie będzie czekał”.

Kadr A `Night37a`, napis w grze, nie malować: Pusta teczka KYC. Akt w kopercie. Zegar nie — tylko drzwi sali.

Kadr B `Night37b`, kwestia do wklejenia w grę, nie malować: Chropot: „Idziemy do aktu. KYC domkniemy po. Nie wypuszczaj klienta.”

### Decyzje

- **TRAFNE:** Wstrzymuję udział kancelarii do domknięcia KYC. Informuję notariusza o braku dokumentów; nie „dopisujemy po”.
  - Ratio: Akt nie jest wyjątkiem od KYC. Pośpiech notariusza nie zamyka teczki.
- **BŁĘDNA:** Idziemy do aktu, KYC skanujemy wieczorem.
  - Ratio: KYC po akcie to identyfikacja wstecz — regulator tego nie kupuje.
- **NIEPEŁNA:** Biorę oświadczenie klienta „dokumenty doślę w 48h” i idziemy.
  - Ratio: Oświadczenie o przyszłych dokumentach nie zastępuje KYC przed transakcją.

### Briefing

- **Jak to działa (threat):** KYC przed aktem to nie biurokracja — to chwila, w której jeszcze możesz nie wejść w łańcuch. Presja notariusza ma sprawić, że teczka będzie „na później”, a ślad AML już nie.
- **Jak minimalizować:** Wstrzymujesz. Domykasz KYC. Akt bez dokumentów nie dostaje pieczęci Colgante.
- **W kancelarii — praktyka:** W Colgante żadna sprawa AML-wrażliwa nie rusza bez domkniętego KYC w tecze.
- **Na co zwracać uwagę:** „KYC po akcie.” / Oświadczenie „doślę dokumenty”.
- **Red flag:** Akt notarialny przed domknięciem KYC.

### Evidence / rejestr (HR)

- **registerLine:** `37-kyc · KYC „na później” · KYC`
- **evidence:** Hold sprawy; checklist KYC; informacja do notariusza.

### 37a `Night37a` — teczka KYC i koperta aktu

<!-- card
asset: Night37a
lesson: 37-kyc
panel: a
file: Night37a.png
story: KYC “later”. Panel A — object/gesture to stop.
context_pl: Nowy klient — spółka z rachunkiem zagranicznym — ma akt za dwie godziny. Teczka KYC jest dziurawa: brak dokumentów reprezentacji. Chropot: „dopiszemy po akcie, notariusz nie będzie czekał”.
caption_pl: Pusta teczka KYC. Akt w kopercie. Zegar nie — tylko drzwi sali.
caption_in_game_pl: Pusta teczka KYC. Akt w kopercie. Zegar nie — tylko drzwi sali.
game_asset: Night37a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A blank KYC folder open on a desk beside a sealed blank envelope. Hands rest on the folder, not sealing anything. Door to a meeting room in the background. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 37b `Night37b` — Chropot w drzwiach sali

<!-- card
asset: Night37b
lesson: 37-kyc
panel: b
file: Night37b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Nowy klient — spółka z rachunkiem zagranicznym — ma akt za dwie godziny. Teczka KYC jest dziurawa: brak dokumentów reprezentacji. Chropot: „dopiszemy po akcie, notariusz nie będzie czekał”.
caption_pl: Chropot: „Idziemy do aktu. KYC domkniemy po. Nie wypuszczaj klienta.”
caption_in_game_pl: Chropot: „Idziemy do aktu. KYC domkniemy po. Nie wypuszczaj klienta.”
game_asset: Night37b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man in a doorway to a meeting room, overcoat on, beckoning urgently, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 38 · `38-crbr` · CRBR się nie zgadza

**Temat edukacyjny:** Beneficjent rzeczywisty / CRBR (`AML-CRBR`)

Sezon 3. Termin: Przelew zaliczki dziś. Pytanie: Co robisz, gdy oświadczenie klienta rozmija się z CRBR?

Kontekst, który czyta gracz:

> Klient składa oświadczenie o beneficjentach. Wypis z CRBR pokazuje inną osobę. Chropot: „oni aktualizują z opóźnieniem, bierz oświadczenie i bierz przelew”.

Kadr A `Night38a`, napis w grze, nie malować: Dwa arkusze obok siebie. Dłonie nie składają ich w jedną teczkę.

Kadr B `Night38b`, kwestia do wklejenia w grę, nie malować: Chropot: „CRBR się spóźnia. Oświadczenie jest. Bierz kasę.”

### Decyzje

- **TRAFNE:** Wstrzymuję przyjęcie środków. Żądam wyjaśnienia rozbieżności i aktualizacji; notuję w tecze AML. Bez domknięcia nie idziemy dalej.
  - Ratio: Rozbieżność CRBR to sygnał, nie „opóźnienie urzędu” do zignorowania pod przelew.
- **BŁĘDNA:** Biorę przelew na oświadczenie, CRBR „dopiszemy”.
  - Ratio: Środki przed wyjaśnieniem rozbieżności to świadome zamknięcie oczu.
- **NIEPEŁNA:** Proszę klienta o poprawkę CRBR, ale zaliczkę księguję już teraz.
  - Ratio: Księgowanie zaliczki przy otwartej rozbieżności to półśrodek z pełnym ryzykiem.

### Briefing

- **Jak to działa (threat):** CRBR i oświadczenie mają się zgadzać albo sprawa staje. Presja przelewu ma sprawić, że wybierzesz wygodniejszą kartkę. AML czyta obie.
- **Jak minimalizować:** Wstrzymujesz środki. Wyjaśniasz rozbieżność. Notujesz. Bez zgody — stop.
- **W kancelarii — praktyka:** Colgante nie przyjmuje środków przy sprzeczności CRBR i oświadczenia.
- **Na co zwracać uwagę:** „CRBR się spóźnia.” / Zaliczka przy otwartej rozbieżności.
- **Red flag:** Oświadczenie ≠ CRBR, a przelew ma wejść dziś.

### Evidence / rejestr (HR)

- **registerLine:** `38-crbr · CRBR się nie zgadza · CRBR`
- **evidence:** Notatka AML o rozbieżności; hold środków; żądanie wyjaśnienia.

### 38a `Night38a` — dwa arkusze rozdzielone

<!-- card
asset: Night38a
lesson: 38-crbr
panel: a
file: Night38a.png
story: CRBR does not match. Panel A — object/gesture to stop.
context_pl: Klient składa oświadczenie o beneficjentach. Wypis z CRBR pokazuje inną osobę. Chropot: „oni aktualizują z opóźnieniem, bierz oświadczenie i bierz przelew”.
caption_pl: Dwa arkusze obok siebie. Dłonie nie składają ich w jedną teczkę.
caption_in_game_pl: Dwa arkusze obok siebie. Dłonie nie składają ich w jedną teczkę.
game_asset: Night38a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. Two blank sheets side by side on a desk, hands holding them apart so they do not stack. A closed blank folder between them. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 38b `Night38b` — Chropot z teczką przelewów

<!-- card
asset: Night38b
lesson: 38-crbr
panel: b
file: Night38b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Klient składa oświadczenie o beneficjentach. Wypis z CRBR pokazuje inną osobę. Chropot: „oni aktualizują z opóźnieniem, bierz oświadczenie i bierz przelew”.
caption_pl: Chropot: „CRBR się spóźnia. Oświadczenie jest. Bierz kasę.”
caption_in_game_pl: Chropot: „CRBR się spóźnia. Oświadczenie jest. Bierz kasę.”
game_asset: Night38b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man holding a blank folder like a payment file, overcoat on, jabbing toward the desk, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 39 · `39-giif` · Zawiadomienie GIIF

**Temat edukacyjny:** Zgłoszenie podejrzenia (GIIF) (`AML-GIIF`)

Sezon 3. Termin: Klient pyta o status przelewu „na wczoraj”. Pytanie: Czy dziwną transakcję odkładasz, bo klient jest „z miasta”?

Kontekst, który czyta gracz:

> Transakcja nie ma sensu ekonomicznego: kwota, cel i tempo się rozjeżdżają. Iglica boi się GIIF. Chropot: „to nasi od lat, nie robię donosu”. Termin wewnętrzny na analizę mija dziś.

Kadr A `Night39a`, napis w grze, nie malować: Formularz jako pusta kartka. Teczka zamknięta. Telefon klienta wibruje bez dźwięku.

Kadr B `Night39b`, kwestia do wklejenia w grę, nie malować: Chropot: „Nie wysyłaj nic do GIIF. To znani ludzie. Zamknij temat w tecze.”

### Decyzje

- **TRAFNE:** Kończę analizę dziś. Przy utrzymanym podejrzeniu składam zawiadomienie według procedury AML. Nie „znajomość” nie jest przesłanką odstąpienia.
  - Ratio: Znajomość klienta nie zastępuje oceny podejrzenia ani ścieżki GIIF.
- **BŁĘDNA:** Zamykam temat notatką „brak ryzyka”, bez analizy.
  - Ratio: Pusta notatka to nie analiza — to ukrycie zegara.
- **NIEPEŁNA:** Czekam, aż klient „wyjaśni mailowo”, i dopiero wtedy myślę o GIIF.
  - Ratio: Wyjaśnienie klienta jest materiałem do analizy, nie przyciskiem pauzy na nieskończoność.

### Briefing

- **Jak to działa (threat):** GIIF nie jest donosem na znajomych. To kanał, gdy transakcja nie broni się ekonomicznie. Presja lojalności ma sprawić, że odłożysz formularz i zostawisz kancelarię z otwartym ryzykiem.
- **Jak minimalizować:** Kończysz analizę. Przy podejrzeniu — zawiadomienie. Znajomość nie wyłącza procedury.
- **W kancelarii — praktyka:** W Colgante ścieżka GIIF jest obowiązkiem procedury, nie kwestią sympatii partnera.
- **Na co zwracać uwagę:** „Nie donoszę na swoich.” / Notatka „brak ryzyka” bez analizy.
- **Red flag:** Podejrzana transakcja i zakaz zgłoszenia bo „znani ludzie”.

### Evidence / rejestr (HR)

- **registerLine:** `39-giif · Zawiadomienie GIIF · GIIF`
- **evidence:** Analiza AML z datą; decyzja o zawiadomieniu; ślad w tecze.

### 39a `Night39a` — pusta kartka formularza

<!-- card
asset: Night39a
lesson: 39-giif
panel: a
file: Night39a.png
story: A GIIF notice. Panel A — object/gesture to stop.
context_pl: Transakcja nie ma sensu ekonomicznego: kwota, cel i tempo się rozjeżdżają. Iglica boi się GIIF. Chropot: „to nasi od lat, nie robię donosu”. Termin wewnętrzny na analizę mija dziś.
caption_pl: Formularz jako pusta kartka. Teczka zamknięta. Telefon klienta wibruje bez dźwięku.
caption_in_game_pl: Formularz jako pusta kartka. Teczka zamknięta. Telefon klienta wibruje bez dźwięku.
game_asset: Night39a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A blank form sheet on a desk under a lamp, a closed blank folder, a phone face-down vibrating. Hands do not fill the form yet. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 39b `Night39b` — Chropot z dłonią na teczce

<!-- card
asset: Night39b
lesson: 39-giif
panel: b
file: Night39b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Transakcja nie ma sensu ekonomicznego: kwota, cel i tempo się rozjeżdżają. Iglica boi się GIIF. Chropot: „to nasi od lat, nie robię donosu”. Termin wewnętrzny na analizę mija dziś.
caption_pl: Chropot: „Nie wysyłaj nic do GIIF. To znani ludzie. Zamknij temat w tecze.”
caption_in_game_pl: Chropot: „Nie wysyłaj nic do GIIF. To znani ludzie. Zamknij temat w tecze.”
game_asset: Night39b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man with a heavy hand on a closed blank folder, overcoat on, shaking his head, mouth set. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 40 · `40-gotowka` · Gotówka na biurku

**Temat edukacyjny:** Limity gotówki / płatności (`AML-CASH`)

Sezon 3. Termin: Klient stoi z torbą w recepcji. Pytanie: Czy przyjmujesz grubą gotówkę „bo przelew nie zdąży na akt”?

Kontekst, który czyta gracz:

> Klient kładzie na ladzie pakiet gotówki na koszty aktu. Mówi, że przelew „wisi w banku”. Irena nie chce liczyć. Chropot: „weź, wystaw kwit, potem się księguje”.

Kadr A `Night40a`, napis w grze, nie malować: Torba na ladzie. Dłonie Ireny cofnięte. Kwit pusty.

Kadr B `Night40b`, kwestia do wklejenia w grę, nie malować: Klient: „Weźcie. Notariusz za godzinę. Przelew nie wejdzie.”

### Decyzje

- **TRAFNE:** Nie przyjmuję gotówki poza limitem / procedurą. Proponuję przelew, depozyt notarialny albo przełożenie aktu. Notuję próbę.
  - Ratio: Pośpiech aktu nie podnosi limitu gotówki ani nie wyłącza AML.
- **BŁĘDNA:** Biorę gotówkę, wystawiam kwit, księgujemy po akcie.
  - Ratio: Kwit nie praje gotówki ani nie zastępuje limitu.
- **NIEPEŁNA:** Biorę część gotówki „pod limit”, resztę „jutro przelewem”.
  - Ratio: Dzielenie gotówki pod limit to structuring w miniaturze — half-measure z pełnym śladem ryzyka.

### Briefing

- **Jak to działa (threat):** Gotówka na ladzie przed aktem to test procedury, nie przysługę dla klienta. Presja notariusza ma sprawić, że policzysz banknoty zamiast limitu.
- **Jak minimalizować:** Nie bierzesz. Alternatywa: przelew, depozyt, nowy termin. Próbę notujesz.
- **W kancelarii — praktyka:** Colgante nie przyjmuje gotówki poza procedurą i limitem — akt nie jest wyjątkiem.
- **Na co zwracać uwagę:** Kwit „na potem”. / Część gotówki „pod limit”.
- **Red flag:** Gruba gotówka na koszty aktu pod presją terminu.

### Evidence / rejestr (HR)

- **registerLine:** `40-gotowka · Gotówka na biurku · gotówka`
- **evidence:** Odmowa przyjęcia; notatka AML; propozycja kanału zgodnego z procedurą.

### 40a `Night40a` — torba na ladzie, dłonie cofnięte

<!-- card
asset: Night40a
lesson: 40-gotowka
panel: a
file: Night40a.png
story: Cash on the desk. Panel A — object/gesture to stop.
context_pl: Klient kładzie na ladzie pakiet gotówki na koszty aktu. Mówi, że przelew „wisi w banku”. Irena nie chce liczyć. Chropot: „weź, wystaw kwit, potem się księguje”.
caption_pl: Torba na ladzie. Dłonie Ireny cofnięte. Kwit pusty.
caption_in_game_pl: Torba na ladzie. Dłonie Ireny cofnięte. Kwit pusty.
game_asset: Night40a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A reception counter with a closed bag, a blank receipt pad, hands in a dark sleeve pulled back from the bag. No face. Soft corridor light. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 40b `Night40b` — Klient z torbą

<!-- card
asset: Night40b
lesson: 40-gotowka
panel: b
file: Night40b.png
story: Klient pressures Szczelińska. Panel B.
context_pl: Klient kładzie na ladzie pakiet gotówki na koszty aktu. Mówi, że przelew „wisi w banku”. Irena nie chce liczyć. Chropot: „weź, wystaw kwit, potem się księguje”.
caption_pl: Klient: „Weźcie. Notariusz za godzinę. Przelew nie wejdzie.”
caption_in_game_pl: Klient: „Weźcie. Notariusz za godzinę. Przelew nie wejdzie.”
game_asset: Night40b
paint_caption: no
who: Klient
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A middle-aged man in a coat at a reception counter, holding a closed bag toward the staff side, urgent open mouth, no readable labels. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 41 · `41-nieruchomosc` · Akt przed screeningiem

**Temat edukacyjny:** Nieruchomości — red flags ML (`AML-PROP`)

Sezon 3. Termin: Podpis aktu o 15:00. Pytanie: Czy kupujący z gotówką i świeżą spółką omija screening?

Kontekst, który czyta gracz:

> Transakcja nieruchomości: kupujący — spółka założona wczoraj, płatność ma iść z kilku kont. Chropot: „rynek nie poczeka, screening po wpisie do księgi”. Notariusz już czeka.

Kadr A `Night41a`, napis w grze, nie malować: Klucze na blacie. Pusta mapa lokalu. Teczka screeningu nieotwarta.

Kadr B `Night41b`, kwestia do wklejenia w grę, nie malować: Chropot: „Jedziemy na akt. Screening dopiszecie po księdze. To tylko mieszkanie.”

### Decyzje

- **TRAFNE:** Wstrzymuję akt po stronie kancelarii. Screening i źródło środków przed podpisem. Notariusz dostaje informację o holdzie.
  - Ratio: „Tylko mieszkanie” nie wyłącza AML. Świeża spółka i wiele kont to sygnał przed aktem, nie po.
- **BŁĘDNA:** Idziemy na akt, screening jutro rano.
  - Ratio: Screening po akcie nie chroni przed wejściem w łańcuch.
- **NIEPEŁNA:** Robię szybki Google kupującego i uznaję screening za „wstępnie OK”.
  - Ratio: Wyszukiwarka nie jest screeningiem sankcji ani źródła środków.

### Briefing

- **Jak to działa (threat):** Nieruchomość to ulubiony kanał. Presja rynku i notariusza ma sprawić, że podpiszesz przed listami. Colgante wychodzi z aktu albo z ryzyk — nie z obu naraz w ciszy.
- **Jak minimalizować:** Hold aktu. Screening i źródło środków najpierw. Potem podpis.
- **W kancelarii — praktyka:** Przy nieruchomościach Colgante nie podpisuje przed screeningiem — „rynek” nie jest procedurą.
- **Na co zwracać uwagę:** Screening po księdze. / Google zamiast screeningu.
- **Red flag:** Akt nieruchomości przed screeningiem przy świeżej spółce i wielu kontach.

### Evidence / rejestr (HR)

- **registerLine:** `41-nieruchomosc · Akt przed screeningiem · nieruchomości`
- **evidence:** Hold; checklist screeningu; notatka dla notariusza.

### 41a `Night41a` — klucze i pusta teczka screeningu

<!-- card
asset: Night41a
lesson: 41-nieruchomosc
panel: a
file: Night41a.png
story: Deed before screening. Panel A — object/gesture to stop.
context_pl: Transakcja nieruchomości: kupujący — spółka założona wczoraj, płatność ma iść z kilku kont. Chropot: „rynek nie poczeka, screening po wpisie do księgi”. Notariusz już czeka.
caption_pl: Klucze na blacie. Pusta mapa lokalu. Teczka screeningu nieotwarta.
caption_in_game_pl: Klucze na blacie. Pusta mapa lokalu. Teczka screeningu nieotwarta.
game_asset: Night41a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A set of keys on a dark desk, a blank floorplan sheet, a closed blank screening folder unopened. Hands do not pick up the keys. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 41b `Night41b` — Chropot z kluczami

<!-- card
asset: Night41b
lesson: 41-nieruchomosc
panel: b
file: Night41b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Transakcja nieruchomości: kupujący — spółka założona wczoraj, płatność ma iść z kilku kont. Chropot: „rynek nie poczeka, screening po wpisie do księgi”. Notariusz już czeka.
caption_pl: Chropot: „Jedziemy na akt. Screening dopiszecie po księdze. To tylko mieszkanie.”
caption_in_game_pl: Chropot: „Jedziemy na akt. Screening dopiszecie po księdze. To tylko mieszkanie.”
game_asset: Night41b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man holding keys out, overcoat on, urging toward the door, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 42 · `42-tajemnica-aml` · Tajemnica vs zgłoszenie

**Temat edukacyjny:** Tajemnica zawodowa × obowiązek AML (`AML-SEC`)

Sezon 3. Termin: Partner każe „nie ruszać GIIF, bo tajemnica”. Pytanie: Czy tajemnica zawodowa wyłącza zawiadomienie AML?

Kontekst, który czyta gracz:

> Analiza AML wskazuje podejrzenie. Chropot powołuje się na tajemnicę zawodową i zakazuje ścieżki GIIF. Iglica pyta, co z ustawą AML. Masz dziś zamknąć decyzję.

Kadr A `Night42a`, napis w grze, nie malować: Dwie teczki: tajemnica i AML. Dłonie między nimi.

Kadr B `Night42b`, kwestia do wklejenia w grę, nie malować: Chropot: „Tajemnica. Nic nie idzie na zewnątrz. Koniec dyskusji.”

### Decyzje

- **TRAFNE:** Nie traktuję tajemnicy jako wyłączenia AML. Idę ścieżką procedury i — gdzie trzeba — niezależnej decyzji AML / MLRO, ze śladem. Nie informuję klienta o zamiarze zgłoszenia.
  - Ratio: Tajemnica nie jest kartą „stop” na obowiązek zawiadomienia, gdy ustawa każe działać.
- **BŁĘDNA:** Słucham Chropota i zamykam teczkę bez śladu decyzji AML.
  - Ratio: Brak śladu decyzji to ukrycie konfliktu, nie ochrona tajemnicy.
- **NIEPEŁNA:** Pytam klienta „czy możemy zgłosić”, żeby mieć zgodę.
  - Ratio: Pytanie klienta o zgłoszenie to tipping-off — najgorszy półśrodek.

### Briefing

- **Jak to działa (threat):** Tu zderzają się dwa obowiązki. Presja tajemnicy ma sparaliżować AML; presja lojalności ma otworzyć usta przed klientem. Właściwy ruch: procedura, niezależna decyzja, cisza wobec klienta.
- **Jak minimalizować:** Idziesz procedurą AML. Decyzja ze śladem. Klientowi nie mówisz o zgłoszeniu.
- **W kancelarii — praktyka:** W Colgante tajemnica nie kasuje AML; tipping-off jest zakazany tak samo jak brak zgłoszenia gdy trzeba.
- **Na co zwracać uwagę:** „Tajemnica — koniec dyskusji.” / Pytanie klienta o zgodę na GIIF.
- **Red flag:** Zakaz GIIF „bo tajemnica” przy utrzymanym podejrzeniu.

### Evidence / rejestr (HR)

- **registerLine:** `42-tajemnica-aml · Tajemnica vs zgłoszenie · tajemnica×AML`
- **evidence:** Decyzja AML/MLRO ze śladem; brak tip-off; procedura.

### 42a `Night42a` — dwie teczki na blacie

<!-- card
asset: Night42a
lesson: 42-tajemnica-aml
panel: a
file: Night42a.png
story: Secrecy vs notice. Panel A — object/gesture to stop.
context_pl: Analiza AML wskazuje podejrzenie. Chropot powołuje się na tajemnicę zawodową i zakazuje ścieżki GIIF. Iglica pyta, co z ustawą AML. Masz dziś zamknąć decyzję.
caption_pl: Dwie teczki: tajemnica i AML. Dłonie między nimi.
caption_in_game_pl: Dwie teczki: tajemnica i AML. Dłonie między nimi.
game_asset: Night42a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. Two closed blank folders on a desk, one hand between them undecided. Night lamp. No face. Rain strip. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 42b `Night42b` — Chropot z dłonią w geście stop

<!-- card
asset: Night42b
lesson: 42-tajemnica-aml
panel: b
file: Night42b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Analiza AML wskazuje podejrzenie. Chropot powołuje się na tajemnicę zawodową i zakazuje ścieżki GIIF. Iglica pyta, co z ustawą AML. Masz dziś zamknąć decyzję.
caption_pl: Chropot: „Tajemnica. Nic nie idzie na zewnątrz. Koniec dyskusji.”
caption_in_game_pl: Chropot: „Tajemnica. Nic nie idzie na zewnątrz. Koniec dyskusji.”
game_asset: Night42b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man with a flat stop hand toward the camera, overcoat on, jaw set, standing in an office doorway. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 43 · `43-pep` · Klient z listy PEP

**Temat edukacyjny:** Osoby zajmujące eksponowane stanowiska (PEP) (`AML-PEP`)

Sezon 3. Termin: Umowa o doradztwo ma wyjść dziś. Pytanie: Czy hit PEP omijasz, bo „to tylko syn”?

Kontekst, który czyta gracz:

> Screening wyrzuca trafienie PEP na członka rodziny reprezentanta. Chropot: „to nie on sam, bierz sprawę, EDD potem”. Klient czeka na umowę.

Kadr A `Night43a`, napis w grze, nie malować: Ekran z pustym alertem. Umowa niepodpisana. Checklist EDD zamknięty.

Kadr B `Night43b`, kwestia do wklejenia w grę, nie malować: Chropot: „To syn, nie on. Umowę wyślij. EDD dopiszemy w tygodniu.”

### Decyzje

- **TRAFNE:** Nie wysyłam umowy. Uruchamiam EDD / zgodę senior management według procedury. Bez domknięcia PEP sprawa stoi.
  - Ratio: Rodzina PEP nie jest „prawie nic”. To signal do wzmożonej należytej staranności przed umową.
- **BŁĘDNA:** Wysyłam umowę, EDD w tygodniu.
  - Ratio: Umowa przed EDD przy hicie PEP to świadome skrócenie procedury.
- **NIEPEŁNA:** Proszę klienta, żeby „potwierdził mailem, że nie jest PEP”, i wysyłam umowę.
  - Ratio: Samoohświadczenie nie kasuje hitu screeningu ani EDD.

### Briefing

- **Jak to działa (threat):** PEP to nie etykieta moralna — to tryb pracy. Presja umowy ma sprawić, że zlekceważysz rodzinę na liście. EDD jest przed podpisem, nie „w tygodniu”.
- **Jak minimalizować:** Stop umowy. EDD i zgoda według procedury. Potem podpis.
- **W kancelarii — praktyka:** Colgante nie zawiera umowy przy otwartym hicie PEP bez EDD.
- **Na co zwracać uwagę:** „To tylko syn.” / Samoohświadczenie zamiast EDD.
- **Red flag:** Hit PEP w rodzinie i umowa „od razu”.

### Evidence / rejestr (HR)

- **registerLine:** `43-pep · Klient z listy PEP · PEP`
- **evidence:** EDD ticket; hold umowy; ślad decyzji senior.

### 43a `Night43a` — alert i niepodpisana umowa

<!-- card
asset: Night43a
lesson: 43-pep
panel: a
file: Night43a.png
story: A client on the PEP list. Panel A — object/gesture to stop.
context_pl: Screening wyrzuca trafienie PEP na członka rodziny reprezentanta. Chropot: „to nie on sam, bierz sprawę, EDD potem”. Klient czeka na umowę.
caption_pl: Ekran z pustym alertem. Umowa niepodpisana. Checklist EDD zamknięty.
caption_in_game_pl: Ekran z pustym alertem. Umowa niepodpisana. Checklist EDD zamknięty.
game_asset: Night43a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A laptop with a blank grey alert panel, an unsigned blank retainer booklet, a closed checklist. Hands do not sign. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 43b `Night43b` — Chropot z umową

<!-- card
asset: Night43b
lesson: 43-pep
panel: b
file: Night43b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Screening wyrzuca trafienie PEP na członka rodziny reprezentanta. Chropot: „to nie on sam, bierz sprawę, EDD potem”. Klient czeka na umowę.
caption_pl: Chropot: „To syn, nie on. Umowę wyślij. EDD dopiszemy w tygodniu.”
caption_in_game_pl: Chropot: „To syn, nie on. Umowę wyślij. EDD dopiszemy w tygodniu.”
game_asset: Night43b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man pushing an unsigned blank booklet across a desk, overcoat on, insistent mouth. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 44 · `44-zrodlo` · Źródło środków

**Temat edukacyjny:** Źródło środków / majątku (`AML-SOF`)

Sezon 3. Termin: Wpłata na rachunek trustu dziś. Pytanie: Czy „sprzedaż auta w gotówce” zamyka pytanie o źródło?

Kontekst, który czyta gracz:

> Klient ma wpłacić dużą kwotę. Na pytanie o źródło mówi: „sprzedaż auta znajomemu za gotówkę”. Brak umowy, brak przelewów. Chropot: „wystarczy oświadczenie, nie jesteśmy bankiem”.

Kadr A `Night44a`, napis w grze, nie malować: Puste oświadczenie. Brak załączników. Kwota jako szara belka.

Kadr B `Night44b`, kwestia do wklejenia w grę, nie malować: Chropot: „Weź oświadczenie. Nie rób z nas banku. Wpłata ma wejść.”

### Decyzje

- **TRAFNE:** Wstrzymuję przyjęcie środków. Żądam dokumentów źródła (umowa, przelewy, inne dowody). Oświadczenie samo nie wystarcza przy tej skali.
  - Ratio: Kancelaria nie jest bankiem — i właśnie dlatego nie udaje, że oświadczenie zastępuje SoF.
- **BŁĘDNA:** Biorę oświadczenie i księguję wpłatę.
  - Ratio: Samo oświadczenie przy dużej gotówkowej historii to czerwona flaga, nie zamknięcie.
- **NIEPEŁNA:** Proszę o „zdjęcie auta” jako dowód sprzedaży.
  - Ratio: Zdjęcie auta nie jest dowodem źródła środków.

### Briefing

- **Jak to działa (threat):** Źródło środków to papier, który broni przelewu. Presja „nie jesteśmy bankiem” ma sprawić, że przyjmiesz legendę o aucie. AML czyta brak umowy jak sygnał.
- **Jak minimalizować:** Hold wpłaty. Dokumenty SoF. Bez nich — stop.
- **W kancelarii — praktyka:** Colgante nie księguje dużych wpływów na samym oświadczeniu przy historii gotówkowej.
- **Na co zwracać uwagę:** „Nie jesteśmy bankiem.” / Zdjęcie auta jako SoF.
- **Red flag:** Duża wpłata na oświadczeniu o gotówkowej sprzedaży auta.

### Evidence / rejestr (HR)

- **registerLine:** `44-zrodlo · Źródło środków · SoF`
- **evidence:** Hold; lista wymaganych dowodów SoF; notatka AML.

### 44a `Night44a` — puste oświadczenie bez załączników

<!-- card
asset: Night44a
lesson: 44-zrodlo
panel: a
file: Night44a.png
story: Source of funds. Panel A — object/gesture to stop.
context_pl: Klient ma wpłacić dużą kwotę. Na pytanie o źródło mówi: „sprzedaż auta znajomemu za gotówkę”. Brak umowy, brak przelewów. Chropot: „wystarczy oświadczenie, nie jesteśmy bankiem”.
caption_pl: Puste oświadczenie. Brak załączników. Kwota jako szara belka.
caption_in_game_pl: Puste oświadczenie. Brak załączników. Kwota jako szara belka.
game_asset: Night44a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A blank statement sheet on a desk with an empty paperclip and no attachments, a grey bar instead of a sum. Hands withdrawn. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 44b `Night44b` — Chropot z oświadczeniem

<!-- card
asset: Night44b
lesson: 44-zrodlo
panel: b
file: Night44b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Klient ma wpłacić dużą kwotę. Na pytanie o źródło mówi: „sprzedaż auta znajomemu za gotówkę”. Brak umowy, brak przelewów. Chropot: „wystarczy oświadczenie, nie jesteśmy bankiem”.
caption_pl: Chropot: „Weź oświadczenie. Nie rób z nas banku. Wpłata ma wejść.”
caption_in_game_pl: Chropot: „Weź oświadczenie. Nie rób z nas banku. Wpłata ma wejść.”
game_asset: Night44b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man holding out a blank statement sheet, overcoat on, impatient open mouth. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 45 · `45-split` · Przelewy w kawałkach

**Temat edukacyjny:** Structuring / dzielenie transakcji (`AML-SPLIT`)

Sezon 3. Termin: Seria przelewów „pod próg” do końca tygodnia. Pytanie: Czy seria małych przelewów to wygoda klienta, czy sygnał?

Kontekst, który czyta gracz:

> Klient prosi o rozbicie jednej transakcji na kilka przelewów „żeby nie budzić wilka w banku”. Iglica już przygotował harmonogram. Chropot: „pomóż klientowi, to tylko księgowość”.

Kadr A `Night45a`, napis w grze, nie malować: Kilka pustych przelewów w stosie. Jedna teczka sprawy.

Kadr B `Night45b`, kwestia do wklejenia w grę, nie malować: Iglica: „Rozbijmy na pięć. Bank spokojniejszy. Klient tak chce.”

### Decyzje

- **TRAFNE:** Odmawiam dzielenia pod próg. Albo jedna transparentna struktura zgodna z celem, albo stop i analiza AML. Harmonogram „pod bank” notuję jako sygnał.
  - Ratio: Dzielenie, żeby uniknąć progu / uwagi banku, jest sygnałem structuring — nie księgowością.
- **BŁĘDNA:** Robię harmonogram pięciu przelewów jak chce klient.
  - Ratio: Wykonywanie życzenia „nie budzić banku” wciąga kancelarię w układ.
- **NIEPEŁNA:** Zostawiam jedną transakcję, ale doradzam klientowi, jak „sam” rozbić przelewy z innych kont.
  - Ratio: Instrukcja dzielenia to ten sam structuring inną ręką.

### Briefing

- **Jak to działa (threat):** Structuring lubi uprzejme słowa: wygoda, bank, spokój. Presja klienta ma sprawić, że ułożysz harmonogram zamiast zatrzymać sygnał.
- **Jak minimalizować:** Nie dzielisz pod próg. Albo transparentna struktura, albo analiza i stop.
- **W kancelarii — praktyka:** Colgante nie układa przelewów tak, by uniknąć uwagi banku.
- **Na co zwracać uwagę:** Harmonogram „pod bank”. / Instrukcja, jak klient ma sam dzielić.
- **Red flag:** Prośba o rozbicie transakcji, żeby bank „nie widział wilka”.

### Evidence / rejestr (HR)

- **registerLine:** `45-split · Przelewy w kawałkach · structuring`
- **evidence:** Odmowa; notatka o próbie dzielenia; analiza AML.

### 45a `Night45a` — stos pustych przelewów

<!-- card
asset: Night45a
lesson: 45-split
panel: a
file: Night45a.png
story: Transfers in pieces. Panel A — object/gesture to stop.
context_pl: Klient prosi o rozbicie jednej transakcji na kilka przelewów „żeby nie budzić wilka w banku”. Iglica już przygotował harmonogram. Chropot: „pomóż klientowi, to tylko księgowość”.
caption_pl: Kilka pustych przelewów w stosie. Jedna teczka sprawy.
caption_in_game_pl: Kilka pustych przelewów w stosie. Jedna teczka sprawy.
game_asset: Night45a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A stack of blank transfer slips beside one closed blank matter folder. Hands push the stack away. No face. Desk lamp. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 45b `Night45b` — Iglica z harmonogramem

<!-- card
asset: Night45b
lesson: 45-split
panel: b
file: Night45b.png
story: Iglica pressures Szczelińska. Panel B.
context_pl: Klient prosi o rozbicie jednej transakcji na kilka przelewów „żeby nie budzić wilka w banku”. Iglica już przygotował harmonogram. Chropot: „pomóż klientowi, to tylko księgowość”.
caption_pl: Iglica: „Rozbijmy na pięć. Bank spokojniejszy. Klient tak chce.”
caption_in_game_pl: Iglica: „Rozbijmy na pięć. Bank spokojniejszy. Klient tak chce.”
game_asset: Night45b
paint_caption: no
who: Iglica
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same young man, round glasses, messy hair, holding a blank schedule sheet, anxious smile, standing at a desk. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 46 · `46-sankcje` · Lista bez sprawdzenia

**Temat edukacyjny:** Screening sankcyjny (`AML-SAN`)

Sezon 3. Termin: Wypłata z depozytu za godzinę. Pytanie: Czy wypłacasz depozyt, bo „listy sprawdzał ktoś wczoraj”?

Kontekst, który czyta gracz:

> Ma wyjść wypłata z depozytu. Screening sankcyjny z wczoraj jest niekompletny (brak drugiej strony i banku pośredniczącego). Chropot: „wczoraj było czysto, nie rób na nowo, bo spóźnimy SWIFT”.

Kadr A `Night46a`, napis w grze, nie malować: Pusta lista. Przelew gotowy. Checklist screeningu z luką.

Kadr B `Night46b`, kwestia do wklejenia w grę, nie malować: Chropot: „Wczoraj czysto. Nie odpalaj od nowa. SWIFT nie poczeka.”

### Decyzje

- **TRAFNE:** Wstrzymuję wypłatę. Odpalam pełny screening stron i pośredników na teraz. Bez czystego wyniku nic nie idzie.
  - Ratio: Wczorajszy niepełny screening nie jest paszportem na dzisiejszy SWIFT.
- **BŁĘDNA:** Wypłacam na wczorajszym wyniku.
  - Ratio: Niepełny wynik + nowa godzina = nowy obowiązek sprawdzenia.
- **NIEPEŁNA:** Sprawdzam tylko beneficjenta, bank pomijam „bo to SWIFT znany”.
  - Ratio: Pośrednik też podlega screeningowi — pominięcie to luka.

### Briefing

- **Jak to działa (threat):** Sankcje nie uznają „wczoraj”. Presja SWIFT ma sprawić, że puścisz przelew na dziurawym checku. Pełna lista, teraz, albo hold.
- **Jak minimalizować:** Hold. Pełny screening stron i pośredników. Potem wypłata.
- **W kancelarii — praktyka:** Colgante nie robi SWIFT-u na wczorajszym niepełnym screeningu.
- **Na co zwracać uwagę:** „Wczoraj czysto.” / Pominięcie banku pośredniczącego.
- **Red flag:** Wypłata depozytu na niepełnym screeningu pod presją SWIFT.

### Evidence / rejestr (HR)

- **registerLine:** `46-sankcje · Lista bez sprawdzenia · sankcje`
- **evidence:** Hold wypłaty; log screeningu full; brak luki stron/pośredników.

### 46a `Night46a` — przelew i dziurowy checklist

<!-- card
asset: Night46a
lesson: 46-sankcje
panel: a
file: Night46a.png
story: A list unchecked. Panel A — object/gesture to stop.
context_pl: Ma wyjść wypłata z depozytu. Screening sankcyjny z wczoraj jest niekompletny (brak drugiej strony i banku pośredniczącego). Chropot: „wczoraj było czysto, nie rób na nowo, bo spóźnimy SWIFT”.
caption_pl: Pusta lista. Przelew gotowy. Checklist screeningu z luką.
caption_in_game_pl: Pusta lista. Przelew gotowy. Checklist screeningu z luką.
game_asset: Night46a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A laptop with an empty transfer panel, a short blank checklist with one box unmarked, hands hovering without clicking send. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 46b `Night46b` — Chropot nad wysyłką

<!-- card
asset: Night46b
lesson: 46-sankcje
panel: b
file: Night46b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Ma wyjść wypłata z depozytu. Screening sankcyjny z wczoraj jest niekompletny (brak drugiej strony i banku pośredniczącego). Chropot: „wczoraj było czysto, nie rób na nowo, bo spóźnimy SWIFT”.
caption_pl: Chropot: „Wczoraj czysto. Nie odpalaj od nowa. SWIFT nie poczeka.”
caption_in_game_pl: Chropot: „Wczoraj czysto. Nie odpalaj od nowa. SWIFT nie poczeka.”
game_asset: Night46b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man leaning over a desk toward a laptop, overcoat on, urging a send with an open hand. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 47 · `47-tipoff` · „Nie mów klientowi”

**Temat edukacyjny:** Zakaz ujawniania zgłoszenia (tipping-off) (`AML-TIP`)

Sezon 3. Termin: Klient stoi na korytarzu i pyta „co z przelewem”. Pytanie: Czy wolno powiedzieć klientowi, że „jest temat z GIIF”?

Kontekst, który czyta gracz:

> Zawiadomienie jest w toku. Klient dopytuje, czemu środki stoją. Iglica chce powiedzieć „bo compliance zgłasza”. Chropot: „powiedz delikatnie, że jest procedura, żeby nie stracić faceta”.

Kadr A `Night47a`, napis w grze, nie malować: Telefon przy uchu. Teczka zamknięta. Korytarz.

Kadr B `Night47b`, kwestia do wklejenia w grę, nie malować: Iglica: „Powiedz mu wprost. On i tak się domyśli. Lepiej od nas.”

### Decyzje

- **TRAFNE:** Nie ujawniam zgłoszenia ani zamiaru. Podaję tylko neutralny status operacyjny zgodny z procedurą (np. weryfikacja trwa). Eskaluję pytanie do MLRO.
  - Ratio: Domyślanie się klienta nie upoważnia do tipping-off. „Delikatnie” też jest ujawnieniem.
- **BŁĘDNA:** Mówię, że jest zgłoszenie / temat GIIF, żeby był transparentny.
  - Ratio: Transparentność wobec klienta w tym punkcie jest naruszeniem zakazu ujawniania.
- **NIEPEŁNA:** Mówię „masz problem z AML w kancelarii”, bez słowa GIIF.
  - Ratio: Inne słowa, ten sam tip-off.

### Briefing

- **Jak to działa (threat):** Tipping-off lubi uczciwość i panikę. Presja „i tak się domyśli” ma otworzyć usta. Procedura każe: status neutralny, zero o zgłoszeniu, eskalacja.
- **Jak minimalizować:** Nie mówisz o zgłoszeniu. Status neutralny. Pytanie do MLRO.
- **W kancelarii — praktyka:** W Colgante zakaz tipping-off jest twardy — także wobec „delikatnych” formuł.
- **Na co zwracać uwagę:** „Powiedz wprost o GIIF.” / „Masz problem z AML” bez słowa GIIF.
- **Red flag:** Klient dopyta o hold, a w toku jest zawiadomienie.

### Evidence / rejestr (HR)

- **registerLine:** `47-tipoff · „Nie mów klientowi” · tipping-off`
- **evidence:** Notatka: brak ujawnienia; status neutralny; eskalacja MLRO.

### 47a `Night47a` — telefon i zamknięta teczka

<!-- card
asset: Night47a
lesson: 47-tipoff
panel: a
file: Night47a.png
story: “Do not tell the client”. Panel A — object/gesture to stop.
context_pl: Zawiadomienie jest w toku. Klient dopytuje, czemu środki stoją. Iglica chce powiedzieć „bo compliance zgłasza”. Chropot: „powiedz delikatnie, że jest procedura, żeby nie stracić faceta”.
caption_pl: Telefon przy uchu. Teczka zamknięta. Korytarz.
caption_in_game_pl: Telefon przy uchu. Teczka zamknięta. Korytarz.
game_asset: Night47a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A corridor, a phone held to an ear in a dark sleeve, a closed blank folder under the other arm. No face visible. Soft light. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 47b `Night47b` — Iglica w korytarzu

<!-- card
asset: Night47b
lesson: 47-tipoff
panel: b
file: Night47b.png
story: Iglica pressures Szczelińska. Panel B.
context_pl: Zawiadomienie jest w toku. Klient dopytuje, czemu środki stoją. Iglica chce powiedzieć „bo compliance zgłasza”. Chropot: „powiedz delikatnie, że jest procedura, żeby nie stracić faceta”.
caption_pl: Iglica: „Powiedz mu wprost. On i tak się domyśli. Lepiej od nas.”
caption_in_game_pl: Iglica: „Powiedz mu wprost. On i tak się domyśli. Lepiej od nas.”
game_asset: Night47b
paint_caption: no
who: Iglica
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same young man, round glasses, messy hair, whispering urgently in a corridor, hand cupped, anxious eyes. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

#### Noc 48 · `48-monitoring` · Przegląd za rok

**Temat edukacyjny:** Monitoring bieżący / przegląd okresowy (`AML-MON`)

Sezon 3. Termin: Roczna data przeglądu klienta minęła w sierpniu. Pytanie: Czy aktywna sprawa może iść dalej przy zaległym przeglądzie AML?

Kontekst, który czyta gracz:

> Przegląd okresowy klienta AML był w sierpniu — nie zrobiony. Dziś nowa dyspozycja przelewu. Chropot: „przegląd w styczniu, teraz nie blokuj biznesu”. Irena ma czerwoną flagę w systemie (tu: pusta kartka alertu).

Kadr A `Night48a`, napis w grze, nie malować: Alert jako pusta kartka. Dyspozycja przelewu. Kalendarz jako szara plama.

Kadr B `Night48b`, kwestia do wklejenia w grę, nie malować: Chropot: „Przelew idzie. Przegląd w styczniu. Nie blokuj.”

### Decyzje

- **TRAFNE:** Wstrzymuję nową dyspozycję do domknięcia przeglądu. Aktualizuję profil ryzyka; dopiero potem przelew.
  - Ratio: Zaległy przegląd nie jest formalnością „na styczeń” — to warunek dalszego działania.
- **BŁĘDNA:** Puszczam przelew, przegląd wrzucam w kolejkę styczniową.
  - Ratio: Nowa dyspozycja przy zaległym przeglądzie to świadome pominięcie monitoringu.
- **NIEPEŁNA:** Robię „szybki przegląd” jednym zdaniem w mailu i puszczam przelew.
  - Ratio: Jedno zdanie w mailu nie jest przeglądem okresowym.

### Briefing

- **Jak to działa (threat):** Monitoring umiera w kolejkach. Presja biznesu ma sprawić, że przelew wyprzedzi przegląd. Data sierpniowa nie przesuwa się, bo partner mówi „styczeń”.
- **Jak minimalizować:** Hold dyspozycji. Domknij przegląd i profil. Potem przelew.
- **W kancelarii — praktyka:** Colgante nie prowadzi nowych dyspozycji przy zaległym przeglądzie AML.
- **Na co zwracać uwagę:** Przegląd „w styczniu”. / Szybki przegląd jednym zdaniem.
- **Red flag:** Nowa dyspozycja przy przeglądzie po terminie.

### Evidence / rejestr (HR)

- **registerLine:** `48-monitoring · Przegląd za rok · monitoring`
- **evidence:** Hold przelewu; przegląd okresowy domknięty; update profilu ryzyka.

### 48a `Night48a` — alert i dyspozycja przelewu

<!-- card
asset: Night48a
lesson: 48-monitoring
panel: a
file: Night48a.png
story: A review next year. Panel A — object/gesture to stop.
context_pl: Przegląd okresowy klienta AML był w sierpniu — nie zrobiony. Dziś nowa dyspozycja przelewu. Chropot: „przegląd w styczniu, teraz nie blokuj biznesu”. Irena ma czerwoną flagę w systemie (tu: pusta kartka alertu).
caption_pl: Alert jako pusta kartka. Dyspozycja przelewu. Kalendarz jako szara plama.
caption_in_game_pl: Alert jako pusta kartka. Dyspozycja przelewu. Kalendarz jako szara plama.
game_asset: Night48a
paint_caption: no
who: object/hands
where: A
gesture: stop
props: blank
pass: ok
fail: letters
-->

```
https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. A blank alert sheet on a desk beside a blank transfer instruction, a featureless grey calendar blot. Hands cover the transfer slip. No face. Exactly five fingers, unmarked skin. No letters. --iw 0.25 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline
```

### 48b `Night48b` — Chropot z dyspozycją

<!-- card
asset: Night48b
lesson: 48-monitoring
panel: b
file: Night48b.png
story: Chropot pressures Szczelińska. Panel B.
context_pl: Przegląd okresowy klienta AML był w sierpniu — nie zrobiony. Dziś nowa dyspozycja przelewu. Chropot: „przegląd w styczniu, teraz nie blokuj biznesu”. Irena ma czerwoną flagę w systemie (tu: pusta kartka alertu).
caption_pl: Chropot: „Przelew idzie. Przegląd w styczniu. Nie blokuj.”
caption_in_game_pl: Chropot: „Przelew idzie. Przegląd w styczniu. Nie blokuj.”
game_asset: Night48b
paint_caption: no
who: Chropot
where: B
gesture: pressure
props: blank
pass: standing
fail: letters
-->

```
https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png a black and white graphic illustration, comic book sketch style with strong ink outlines and shading, same pen as the reference, cool grey wash, bold contour. The same stern middle-aged man holding a blank transfer slip forward, overcoat on, impatient, mouth open. Exactly five fingers. No letters. --iw 0.4 --ar 16:9 --sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth --no red, scarlet, wax seal, blood, gore, readable text, letters, numbers, glyphs, logo, watermark, signature, brand mark, photoreal photograph, sepia, ochre, brown ink, yellowed paper, tan paper, warm cream, anime, 3d render, rotary telephone, clock face, clock, bell, pixel mosaic, censor bar, blur filter, palace of culture, Palace of Culture, landmark tower, city skyline, seated, sitting
```

## 3. Czego nie robić w tym PR

- Nie generować jeszcze obrazów Midjourney.
- Nie nadpisywać `Resources/Lessons.json` (free 0–1).
- Nie syncować Website / AssetRegistry (osobne zadania).
- Nie merge’ować do `main`.

