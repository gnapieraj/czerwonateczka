# Audyt dialogów — czytelność (S0 + S1 Free)

**Stan:** 02.10.2026 (UTC+2)  
**Zakres:** Season 0 (Night01–12) + Season 1 (Night13–24) — Free → App Store. Compliance pominięte.  
**Źródła:** `Resources/Lessons.json` (context, beats/Napis A·B, `innerVoice` = pytanie nocy, redFlags) + karty w `tools/macos-studio/komiks-sezony.md` (gesture / props / story = **zamierzona** akcja płyty).  
**Tryb:** tylko raport. **Bez** zmian tekstów w Lessons / bez Midjourney.  
**Uwaga S1 grafika:** Night14–24 to jeszcze kopia `SezonMecenas` (`artPending`). Dla tych nocy audyt napisu = zamierzona płyta z karty, nie pikseli placeholdera. Night13a/b mają własne pliki.

### Kryteria

1. Czy Napis A/B opisuje to, co płyta ma pokazywać (nie metaforę spoza kadru)?  
2. Czy napisy + kontekst + pytanie nocy mówią o tym samym dylemacie?  
3. Czy gracz rozumie stawkę bez zgadywania? Metafora / slang IT / potoczny OK, jeśli most jest w napisie albo w pytaniu osadzony w tym, co widać.

---

## 1. Critical — gracz nie rozumie / napis ≠ płyta

### C1. Night13 · 13-chmura · „Akta w tramwaju”

| Pole | Teraz |
|---|---|
| Napis A | *Prywatny telefon nad otwartymi aktami. Chropot już w płaszczu.* |
| Napis B | *Chropot: „Zrób zdjęcie i **wsiadaj**. Rano ma leżeć na mojej skrzynce.”* |
| Pytanie | *Czy akta **wsiądą** z tobą do **tramwaju**?* |
| Płyta A (plik) | Telefon w ręku przy oknie / deszcz / dachy; otwarte akta na biurku — **nie** klarowna poza „fotografuję strony”. Tramwaju brak (w karcie: *tram wires* w tle, nie pojazd). |
| Płyta B | Chropot w płaszczu przy klamce, odwraca się — wyjście z pokoju, nie wsiadanie. |

**Problem:** Tramwaj i „wsiadaj” żyją w tytule, pytaniu i balonie B; na płytach ich nie ma. Napis A obiecuje „telefon **nad** aktami” (gest fotografowania), a bieżąca A pokazuje raczej telefon przy oknie. Gracz łączy „wsiadaj” z drzwiami / płaszczem albo zgaduje metaforę chmury.

**Propozycja (tekst, bez MJ):**

- **Napis A:** `Prywatny telefon nad otwartymi stronami akt. Płaszcz Chropota już na haku.`  
  *(Gdy będzie retusz MJ: telefon nad kartkami, nie w stronę szyby.)*  
- **Napis B:** `Chropot: „Zrób zdjęcie stron i jedź. Rano ma leżeć na mojej skrzynce.”`  
  *(Albo bez „jedź”: `„Zrób zdjęcie i wyślij. Rano ma leżeć na mojej skrzynce.”`)*  
- **Pytanie:** `Czy robisz zdjęcie akt prywatnym telefonem?`  
  *(Albo: `Dokąd jedzie zdjęcie akt z prywatnego telefonu?` — bliżej threatu o chmurze.)*  
- **Tytuł (opcjonalnie):** `Zdjęcie akt` / `Akta w chmurze` zamiast `Akta w tramwaju`.  
- **Flags:** zostawić *Akta na biurku. W kieszeni prywatny telefon.* — OK.

---

### C2. Night20 · 20-nosnik · Napis A / Flags vs zamierzona płyta

| Pole | Teraz |
|---|---|
| Napis A | *Pendrive w wyciągniętej dłoni. Laptop kancelarii jest **otwarty**.* |
| Flags | *… Laptop kancelarii jest **otwarty**.* |
| Karta A | *laptop stays **closed** under his arm*; fail: *the laptop open* |

**Problem:** Tekst gry mówi „otwarty”, płyta ma pokazywać laptop **zamknięty** pod pachą (odmowa włożenia pendrive’a). Po przyjęciu grafiki napis będzie kłamał kadrowi; dziś placeholder i tak myli.

**Propozycja:**

- **Napis A:** `Pendrive w wyciągniętej dłoni. Laptop kancelarii zamknięty pod pachą.`  
- **Flags:** `Protokolant trzyma pendrive. Laptop kancelarii jest zamknięty.`  
- Napis B i pytanie (*Co robisz z nośnikiem…*) — OK.  
- Context już mówi „zgraj na laptop” — zostawić; kontrast robi zamknięty sprzęt na A.

---

### C3. Night09 · 09-glos · „Numer z pisma” — który numer?

| Pole | Teraz |
|---|---|
| Tytuł | *Numer z pisma* (niejasne: komórka vs rachunek) |
| Napis A | *Słuchawka. Głos jest jego, kwota zaliczki też. Numer rachunku słyszysz pierwszy raz.* — OK |
| Napis B | *Iglica: „To jego **komórka**. Stary **rachunek** puści zaliczkę w próżnię.”* — miesza dwa numery w jednym zdaniu |
| Pytanie | *Skąd bierzesz numer **rachunku** do zwrotu?* |
| Werdykt | Oddzwoń na numer Chropota **z pisma w aktach** (weryfikacja rozmówcy), nie bierz rachunku z głosu |

**Problem:** Bez dokładnego czytania kontekstu gracz myśli, że stawką jest „czy to na pewno jego komórka”, a nie „skąd bierzesz IBAN”. Balon B pcha w stronę komórki; pytanie pyta o rachunek. Tytuł nie rozstrzyga.

**Propozycja:**

- **Napis B:** `Iglica: „Wyświetlacz pokazuje Chropota. Weź nowy rachunek, stary puści zaliczkę w próżnię.”`  
- **Pytanie:** `Skąd bierzesz numer rachunku — z głosu czy z akt?`  
- **Tytuł:** `Rachunek z telefonu` albo `Zwrot z głosu`  
- **Napis A:** zostawić; ewentualnie dodać papier: `Słuchawka przy uchu. Na biurku pismo z numerem Chropota. Numer rachunku słyszysz pierwszy raz.`

---

## 2. Medium — niezręczne / naciągane / słaby most

### M1. Night08 · 08-qr · IBAN / kod — jeden ekran zamiast dwóch źródeł

- **Napis A:** *Laptop… kod do zeskanowania* — zgadza się z **obecną** płytą (laptop + kwadrat + pole).  
- **Karta** chciała: wyrok + osobna kartka z kodem + telefon odwrócony.  
- **Flags / Q / context** wymagają pary **wyrok vs PDF**. Na A nie widać wyroku; gracz musi to wyciągnąć z briefingu.  
- Tytuł *IBAN* nie pada w napisach (OK dla prawnika; laik idzie w „numer rachunku”).

**Propozycja (tekst):**  
`Napis A: Wyrok z numerem rachunku obok. Na ekranie PDF — kod do skanu i puste pole.`  
Albo krócej: `Obok wyroku PDF z kodem do skanu. Numer z wyroku jest osobno.`  
Napis B OK. Pytanie OK.

### M2. Night11 · 11-konta · brak Napisu A-sceny

Oba beaty to balony presji (Irena, Chropot). Płyta A: Irena przy laptopie + drugi telefon — nie mówi wprost „były aplikant / MFA u niego”. Pytanie *Co robisz z tym logowaniem przed nocą?* wisi na kontekście.

**Propozycja:**  
`Napis A: Skrzynka po odejściu. Przy logowaniu wciąż pyta jego prywatny telefon.`  
`Napis B:` zostawić Chropota *albo* przenieść Irenę na B:  
`Irena: „Zostaw skrzynkę do rana. Bez tych pism nie ma wejścia.”`  
i Chropota jako drugi beat / zostawić jak jest, jeśli UI trzyma 2 panele.

### M3. Night12 · 12-okup · bitcoin tylko w tytule / kontekście

Napis A: kłódka + żądanie zapłaty — płyta OK. Słowo *bitcoin* nie ma w A/B; tytuł i flags ratują. Pytanie długie, ale czytelne przy kontekście.

**Propozycja (lekka):**  
`Napis A: Laptop na biurku. Kłódka na ekranie i żądanie zapłaty w bitcoinach.`

### M4. Night19 · 19-mandat · pytanie żargonem

*Co obiecyjesz człowiekowi, który nie ma twojego pełnomocnictwa?* — poprawne merytorycznie, dla gracza-aplikanta bywa „zgadnij termin”. Napisy nie mówią o ukryciu pisma (to tylko context).

**Propozycja:**  
`Pytanie: Co mówisz klientowi o ugodzie i o piśmie w aktach?`  
`Napis A: Telefon od klienta. Pyta o ugodę i o pismo, którego „nie ma być w aktach”.`

### M5. Night23 · 23-nagranie · „gotowy nagrywać” vs zamierzona płyta

Karta A: telefon **ekranem w dół**, ołówek na papierze. Napis: *…gotowy nagrywać* — opisuje pokusę, nie gest na płycie.

**Propozycja:**  
`Napis A: Głośnik na biurku. Prywatny telefon leży ekranem w dół; ołówek na papierze kancelarii.`  
Albo zostawić pokusę, ale wtedy płyta powinna pokazać telefon gotowy do REC (świadomy wybór przy MJ).

### M6. Night24 · 24-ekran · pytanie vs decyzja

Pytanie: *Co jest na ekranie, kiedy odchodzisz od ławki?* — meta / skutek. Wybór to zamknąć klapę / nie dawać wokandy obcemu. Napis A mówi „otwarty”, gest karty = klapa w pół drogi (domykanie) — lekkie tarcia z B (*Zostaw klapę otwartą*).

**Propozycja:**  
`Pytanie: Co robisz z otwartym laptopem, gdy obcy prosi o wokandę?`  
Napis A OK jako stan wyjściowy; B OK jako presja.

### M7. Night04 · 04-haslo · dryf płyty vs napis

Napis A OK (*mail poszedł / cztery słowa na kartce*). Karta: duża przerwa, telefon **bokiem**. Bieżąca A: stos papierów + telefon **ekranem do góry**. Nie psuje sens, ale most „nie trzymaj hasła przy linku” jest słabszy wizualnie.

**Propozycja tekstowa (opcjonalnie):** bez zmian napisu; przy retuszu MJ przywrócić przerwę i telefon odwrócony.

### M8. Night13 (dopisek medium do C1)

Context mówi *„zrób zdjęcie stron i jedź, rano samo się wyśle”* — threat to **chmura**, nie tramwaj. Nawet po usunięciu „wsiadaj” warto w pytaniu/flagach trzymać prywatny telefon / zdjęcie, nie pojazd.

---

## 3. OK — czytelne mosty (przykłady)

| Noc | Dlaczego gra |
|---|---|
| **01-kod** | A: dwa pytania po jednym haśle. B: presja Iglicy. Q: *które jest twoim logowaniem?* — bez metafory spoza kadru. |
| **02-list** | A: sąd + doklejony PDF. B: „otwórz oba”. Q: *który plik?* |
| **03-prompt** | A: ugoda niejawna. B: wklej. Q: *co wklejasz?* — wybór o anonimizacji wynika wprost. |
| **06-pomoc** | A: zgłoszenie vs plik z obcego numeru. Q: *której instrukcji?* |
| **07-sms** | Sygnatura z akt vs rata spoza nakazu — flags i Q spójne. |
| **10-okno** | A/B o „Włącz treść”; tytuł tłumaczy makra; Q o sposobie czytania. |
| **14-cudze** | A: cudze hasło przy polach. B: „wejdź jako ja”. Q: *czyim hasłem?* (gdy wejdzie prawdziwa grafika). |
| **16-link** | A: nadawca = koleżanka, nie sąd. B: wchodź. Q: *skąd adres rozprawy?* |
| **17-wydruk** | Toner / rodzice / biurko — Q *gdzie powstaje papier* czytelne. |
| **18-odbior** | Zamknięte pismo + „pokwituj za mnie”. Q o nazwisku na pokwitowaniu. |
| **21-termin** | Pole hasła pod zaproszeniem — Q *gdzie sprawdzasz termin*. |
| **22-granica** | A: akta, których nie prowadzisz. B: „pięć minut”. Q: *czyją sprawę wolno otworzyć?* |

---

## 4. Tabela skrótowa S0+S1

| # | id | Werdykt | Główny zarzut |
|---|---|---|---|
| 01 | 01-kod | OK | — |
| 02 | 02-list | OK | — |
| 03 | 03-prompt | OK | — |
| 04 | 04-haslo | Medium | dryf płyty (telefon / przerwa) |
| 05 | 05-arkusz | OK | puste boksy na tablicy = zamierzony brak liter |
| 06 | 06-pomoc | OK | — |
| 07 | 07-sms | OK | — |
| 08 | 08-qr | Medium | A nie pokazuje pary wyrok/PDF |
| 09 | 09-glos | **Critical** | komórka vs rachunek w B + tytuł |
| 10 | 10-okno | OK | — |
| 11 | 11-konta | Medium | brak napisu-sceny; Q na samym kontekście |
| 12 | 12-okup | Medium | bitcoin poza A (tytuł ratuje) |
| 13 | 13-chmura | **Critical** | tramwaj/wsiadaj poza płytą; A ≠ gest zdjęcia |
| 14 | 14-cudze | OK* | *gdy art; tekst OK |
| 15 | 15-polecenie | OK* | — |
| 16 | 16-link | OK* | — |
| 17 | 17-wydruk | OK* | — |
| 18 | 18-odbior | OK* | — |
| 19 | 19-mandat | Medium* | Q żargon; A nie niesie prośby o ukrycie |
| 20 | 20-nosnik | **Critical*** | A/Flags „otwarty” vs karta „zamknięty” |
| 21 | 21-termin | OK* | — |
| 22 | 22-granica | OK* | — |
| 23 | 23-nagranie | Medium* | „gotowy nagrywać” vs ekran w dół |
| 24 | 24-ekran | Medium* | Q skutkowe; lekkie tarcia otwarty/domykany |

\* S1 Night14–24: grafika `artPending` — oceniony **tekst vs zamierzona płyta**.

---

## 5. Priorytet poprawek tekstu (bez Lessons w tym commicie)

1. **Night13** — wyrzucić / zastąpić tramwaj i „wsiadaj”; wyrównać A do gestu zdjęcia.  
2. **Night20** — „otwarty” → „zamknięty” w A + Flags.  
3. **Night09** — rozdzielić komórkę i rachunek w B; doprecyzować Q/tytuł.  
4. Night08, 11, 19, 23, 24, 12 — medium z §2.  

Źródło prawdy po decyzjach Grega: najpierw `tools/build_lessons.py` / generator, potem `Lessons.json` + `caption_pl` w `komiks-sezony.md` (spójność napisów).

---

## 6. Poza zakresem

- Compliance / dalsze sezony.  
- Retusz Midjourney (poza notatką, że Night13a i Night20 wymagają kadru zgodnego z napisem **po** poprawce tekstu).  
- Zmiany werdyktów / delta / Ratio — nie ruszane.
