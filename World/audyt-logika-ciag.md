# Audyt logiki ciągu — causal A→B + pokrycie edukacyjne (S0 + S1 Free)

**Stan:** 02.10.2026 (UTC+2)  
**Zakres:** Season 0 (Night01–12) + Season 1 (Night13–24). Compliance poza zakresem.  
**Źródła:** `tools/macos-studio/komiks-sezony.md` (karty panelu: gesture / props / story) + `Resources/Lessons.json` (context, beats/Napis A·B, `innerVoice`, flags, choices, awareness).  
**Tryb:** tylko raport. **Bez** zmian Lessons, **bez** Midjourney.  
**Poprzedni audyt:** `World/audyt-dialogi-czytelnosc.md` (napis ↔ płyta ↔ czytelność). Ten dokument idzie **dalej**: chronologia/causal A→B + most pytanie↔lekcja.

### Kryteria

1. **Causal A→B (klasyczny komiks):** panel A = setup (stan / rekwizyt / gest wyjściowy); panel B = pressure (postać, rozkaz, eskalacja). Czas płynie do przodu. Gracz nie zgaduje łańcucha przyczyn.
2. **Pytanie ↔ kontekst ↔ napisy ↔ lekcja:** `innerVoice` + captions + context prowadzą do tego samego odruchu cyber/compliance (awareness.threat / practice), bez sprzecznych wskazówek.
3. **Bez zgadywania:** po przeczytaniu A→B + Q gracz wie, *co* jest stawką i *dlaczego* wybór ma sens.

**Skala:** Critical / Medium / OK.

---

## 1. Critical — odwrócona przyczyna albo lekcja nie do odczytania z ciągu

### C1. Night14 · `14-cudze` · Login partnera — **odwrócona chronologia (wzorzec)**

| Pole | Teraz |
|---|---|
| Context | *Chropot **kładzie** kartkę z własnym hasłem i mówi…* |
| Napis A | *Kartka z hasłem partnera obok pustych pól logowania.* → skutek już leży |
| Panel A | dłonie z dala od klawiatury; slip już na biurku |
| Napis B | *Chropot: „Wejdź jako ja…”* |
| Panel B | **Chropot kładzie kartkę** (`gesture: standing, setting a small slip`) |
| Q | *Czyim hasłem wchodzisz do portalu?* |
| Lekcja | nie loguj się cudzym hasłem / tylko własne konto |

**Problem:** A pokazuje **skutek** (kartka już na biurku). B pokazuje **przyczynę** (kładzenie kartki). Czas biegnie wstecz. Gracz widzi najpierw gotowy rekwizyt, potem akt, który ten rekwizyt dopiero wprowadza. To jest wzorcowy błąd causal — cytowany też w briefie Grega.

**Propozycja (wybór jednej ścieżki):**

1. **Swap A/B (zalecane):**  
   - **A (setup):** Chropot stoi przy biurku aplikanta i **kładzie** kartkę; napis: `Chropot kładzie kartkę z hasłem. Portal nie ma jeszcze twojego konta.`  
   - **B (pressure):** kartka już leży; dłonie nad klawiaturą / pustymi polami; napis: `Chropot: „Wejdź jako ja. Wniosek o twoje konto leży od tygodnia.”`  
2. **Bez swapu — zmiana gestu B:** A zostaje (kartka leży). B: Chropot **wskazuje** kartkę / mówi, **bez** „setting a slip”. Przepisać kartę 14b i szary blok.  
3. **Split beatów:** A = puste pola logowania (bez kartki); B = Chropot kładzie kartkę + kwestia. Wtedy Napis A: `Puste pola logowania. Twojego konta w portalu jeszcze nie ma.`

**MJ:** nie generować Night14a/b, dopóki karta nie ma zgodnego A→B. Kolejka `s1-mj-queue.md` (Next=Night14a) stoi na tej decyzji.

---

### C2. Night17 · `17-wydruk` · Wydruk u rodziców — ten sam wzorzec (kaseta)

| Pole | Teraz |
|---|---|
| Napis A / panel A | pusta kaseta **już w dłoni** aplikanta (`holding an empty toner cartridge`) |
| Napis B / panel B | Irena **podaje** pustą kasetę (`she holds out an empty toner cartridge`) |

**Problem:** A = skutek przekazania; B = akt przekazania. Identyczny błąd jak Night14.

**Propozycja:**

- **Swap:** A = Irena podaje / pokazuje pustą kasetę + laptop z pismem; B = aplikant z kasetą / płaszcz na krześle + kwestia *„Wydrukuj u rodziców…”* **albo**  
- **Bez swapu:** A = pusta drukarka / laptop z pismem, **bez** kasety w ręku; B = Irena podaje kasetę i mówi. Napis A: `Plik pisma na laptopie. W drukarce skończył się toner.`

Q (*Gdzie powstaje papier tej sprawy?*) i lekcja (druk tylko w kancelarii) — OK po naprawie ciągu.

---

### C3. Night24 · `24-ekran` · Laptop na korytarzu — B wcześniej niż A

| Pole | Teraz |
|---|---|
| Context | Chropot **zostawia** otwarty laptop → potem podchodzi obcy |
| Panel A | ława, **klapa w drodze w dół**, obcy o krok |
| Panel B | **plecy Chropota w drzwiach sali** (gest „wait”) — moment **wcześniejszy** |
| Napis B | *„Zostaw klapę otwartą i pilnuj…”* — rozkaz z chwili wyjścia |
| Q | *Co jest na ekranie, kiedy odchodzisz od ławki?* — skutek, nie decyzja |

**Problem:** Klasyczny komiks wymaga: najpierw zostawienie laptopa (setup), potem presja obcego / pokusa. Dziś B to flashback wyjścia Chropota, A to już reakcja (domykanie klapy). Gracz dostaje skutek przed przyczyną.

**Propozycja:**

- **A (setup):** otwarty laptop na ławce; Chropot w półkroku do sali / plecy w drzwiach; napis: `Chropot zostawia otwarty laptop na ławce. „Zaraz wracam.”`  
- **B (pressure):** obcy o krok; klapa jeszcze otwarta **albo** ręka aplikanta nad klapą; napis: kwestia obcego o wokandę **albo** echo Chropota *„Zostaw klapę otwartą…”* jako balon z offu.  
- **Q:** `Co robisz z otwartym laptopem, gdy obcy prosi o wokandę?` (zgodnie z audytem czytelności).

Lekcja (blokada / nie dawaj ekranu obcemu) jest dobra — most Q naprawić razem z ciągiem.

---

### C4. Night13 · `13-chmura` · Akta w tramwaju — A zawiera beat B + Q poza płytą

*(Częściowo w `audyt-dialogi-czytelnosc.md` C1; tu: causal + edukacja.)*

| Pole | Teraz |
|---|---|
| Napis A | *…Chropot **już** w płaszczu.* — stan z B wpisany w A |
| Panel B | Chropot w drzwiach, wychodzi |
| Q | *Czy akta **wsiądą** z tobą do **tramwaju**?* |
| Lekcja (awareness) | zdjęcie akt → chmura prywatnego telefonu |

**Problem:** (1) A zapowiada / dubluje B („już w płaszczu”). (2) Pytanie i tytuł budują metaforę tramwaju, której nie ma na płytach; threat edukacyjny to **chmura / BYOD**, nie pojazd. Gracz zgaduje most.

**Propozycja:** jak w audycie czytelności — wyczyścić tramwaj z Q/tytułu; Napis A bez „już w płaszczu” (`Prywatny telefon nad otwartymi stronami akt.`); B bez „wsiadaj”. Causal: A = telefon nad aktami; B = Chropot w płaszczu / rozkaz wyjścia — OK **po** usunięciu dublowania w A.

---

### C5. Night20 · `20-nosnik` · tekst vs zamierzona płyta + lekcja „nie wkładaj”

| Pole | Teraz |
|---|---|
| Napis A / Flags | laptop **otwarty** |
| Karta A | laptop **zamknięty** pod pachą |
| Lekcja | nie podłączaj cudzego pendrive’a |

**Problem:** Po przyjęciu grafiki napis zaprzeczy płycie; odmowa (zamknięty sprzęt) zniknie z mostu wizualnego. Causal A→B (oferta nośnika → rozkaz Chropota) jest OK — psuje się **zgodność tekstu z lekcją**.

**Propozycja:** Napis A + Flags → „zamknięty” (jak audyt czytelności C2). Nie generować 20a, dopóki tekst nie jest zsynchronizowany.

---

### C6. Night09 · `09-glos` · dwa „numery” w jednym beat B

*(Szczegóły: audyt czytelności C3.)* Q pyta o rachunek; B pcha w komórkę. Lekcja = oddzwoń na numer z akt / nie bierz IBAN z głosu — most wymaga rozdzielenia w B i Q.

---

## 2. Medium — słaby setup, naciągany most, lekcja wisi na samym kontekście

### M1. Night11 · `11-konta` — brak kadru-setupu

Oba beady to balony presji (Irena, Chropot). Panel A wizualnie: cudzy telefon na ladzie — nie mówi wprost „MFA u byłego”. Q (*Co robisz z tym logowaniem przed nocą?*) siedzi na kontekście.  
**Propozycja:** Napis A sceniczny (`Skrzynka po odejściu. Przy logowaniu wciąż pyta jego prywatny telefon.`); B = presja Chropota. Ewentualnie zamienić kolejność głosów, jeśli UI trzyma Irenę na A.

### M2. Night08 · `08-qr` — A nie pokazuje pary źródeł

Lekcja BEC: numer z **wyroku** vs kod z PDF. Napis A opisuje tylko ekran z kodem; karta chciała wyrok + kartkę. Gracz musi wyciągnąć parę z briefingu.  
**Propozycja:** Napis A z parą (`Wyrok z numerem rachunku obok. Na ekranie PDF — kod do skanu.`).

### M3. Night19 · `19-mandat` — Q żargonem; A nie niesie ukrycia pisma

Lekcja: brak pełnomocnictwa + nie ukrywaj pisma. Context ma prośbę „niech nie będzie w aktach”; Napis A tylko *Telefon… Ugoda… pismo*.  
**Propozycja:** Q bez „pełnomocnictwa”; Napis A z prośbą o ukrycie (audyt czytelności M4).

### M4. Night23 · `23-nagranie` — napis vs gest

Napis A: *gotowy nagrywać*; karta: telefon **ekranem w dół**, ołówek na papierze. Causal A→B OK (setup → rozkaz z progu); most lekcji (nie nagrywaj → chmura) słabnie, gdy napis opisuje pokusę zamiast gestu odmowy.  
**Propozycja:** Napis A zgodny z gestem (`…telefon leży ekranem w dół; ołówek na papierze kancelarii.`).

### M5. Night04 · `04-haslo` — dryf płyty (nie causal)

Ciąg A (kartka osobno) → B (presja Chropota) jest poprawny. Medium tylko przy retuszu MJ (telefon / przerwa) — jak audyt czytelności.

### M6. Night12 · `12-okup` — bitcoin poza napisem A

Causal OK. Lekcja ransomware czytelna z context/Q; słowo *bitcoin* warto dokleić do A dla mostu z tytułem.

### M7. Night13 (dopisek) — po naprawie C4 zostać Medium, jeśli context dalej mówi „jedź” bez mostu do chmury w napisach.

### M8. Night22 · `22-granica` — lekki premature access

Napis A: *Na ekranie akta, których nie prowadzisz* — wygląda, jakby akta **już** otwarte, podczas gdy decyzja = nie otwierać.  
**Propozycja:** A = Irena wskazuje folder/listę spraw na ekranie logowania lub zamknięty katalog; B = „Pięć minut…”. Albo napis: `Irena przy twoim biurku. Prosi o akta sprawy, której nie prowadzisz.` (bez „na ekranie”).

---

## 3. OK — ciąg A→B + most edukacyjny trzymają

| Noc | Causal | Lekcja (skrót) | Dlaczego gra |
|---|---|---|---|
| **01-kod** | A: dwa pytania MFA → B: Iglica naciska | zatwierdź tylko własne | setup→presja; Q o „które pytanie” |
| **02-list** | A: dwa pliki → B: „otwórz oba” | pismo z portalu, nie doklejka | klasyczny |
| **03-prompt** | A: teczka zamknięta → B: Iglica pcha do wklejenia | AI bez tajemnicy sprawy | gest A = odmowa, B = eskalacja |
| **04-haslo** | A: link poszedł / kartka → B: wpisz pod linkiem | hasło osobnym kanałem | OK (płyta: patrz M5) |
| **05-arkusz** | A: tablica + telefon w dół → B: Irena / chronologia | hasło ≠ akta | setup→presja |
| **06-pomoc** | A: zgłoszenie vs plik → B: instaluj | zostań przy własnym ticketcie | OK |
| **07-sms** | A: kciuk nad linkiem → B: Irena | zestaw z nakazem | OK |
| **08-qr** | A→B chronologicznie OK | BEC / IBAN z wyroku | most wizualny słaby → M2 |
| **10-okno** | A: palec przed paskiem → B: Włącz treść | bez makr / PDF | OK |
| **15-polecenie** | A: pismo + pusty czat → B: wrzucaj | nie wklejaj do obcego czatu | OK |
| **16-link** | A: link od koleżanki → B: wchodź | adres z portalu | OK |
| **18-odbior** | A: zamknięta koperta → B: pokwituj za mnie | nie kwituj cudzego | setup→presja zdalna OK |
| **21-termin** | A: pole hasła pod zaproszeniem → B: wpisz | termin z portalu, nie hasło | OK |

\* Night14–24 bez własnej grafiki (`artPending`): ocena vs **zamierzona** karta.

---

## 4. Tabela skrótowa S0+S1 (ten audyt)

| # | id | Causal | Edukacja / most | Werdykt |
|---|---|---|---|---|
| 01 | 01-kod | OK | OK | **OK** |
| 02 | 02-list | OK | OK | **OK** |
| 03 | 03-prompt | OK | OK | **OK** |
| 04 | 04-haslo | OK | OK (dryf płyty) | Medium |
| 05 | 05-arkusz | OK | OK | **OK** |
| 06 | 06-pomoc | OK | OK | **OK** |
| 07 | 07-sms | OK | OK | **OK** |
| 08 | 08-qr | OK | słaba para źródeł na A | Medium |
| 09 | 09-glos | OK | komórka vs rachunek | **Critical** |
| 10 | 10-okno | OK | OK | **OK** |
| 11 | 11-konta | brak setupu | Q na kontekście | Medium |
| 12 | 12-okup | OK | bitcoin poza A | Medium |
| 13 | 13-chmura | A dubluje B | Q tramwaj ≠ chmura | **Critical** |
| 14 | 14-cudze | **A skutek / B przyczyna** | lekcja OK po swapie | **Critical** |
| 15 | 15-polecenie | OK | OK | **OK** |
| 16 | 16-link | OK | OK | **OK** |
| 17 | 17-wydruk | **A skutek / B podanie kasety** | OK po swapie | **Critical** |
| 18 | 18-odbior | OK | OK | **OK** |
| 19 | 19-mandat | OK | Q żargon; ukrycie tylko w CTX | Medium |
| 20 | 20-nosnik | OK | otwarty≠zamknięty | **Critical** |
| 21 | 21-termin | OK | OK | **OK** |
| 22 | 22-granica | premature „na ekranie” | OK | Medium |
| 23 | 23-nagranie | OK | napis≠gest | Medium |
| 24 | 24-ekran | **B wcześniejsze niż A** | Q skutkowe | **Critical** |

---

## 5. Priorytet nocy do przepisywania (następny krok — nie w tym commicie)

Kolejność dla poprawek tekstu / kart w `komiks-sezony.md` (+ potem `build_lessons` / Lessons), **zanim** MJ Night14+:

1. **Night14** — Critical causal (wzorzec); blokuje kolejkę MJ (`Next=Night14a`).
2. **Night17** — ten sam wzorzec (kaseta).
3. **Night24** — odwrócony exit Chropota vs obcy; poprawić Q.
4. **Night13** — tramwaj / dublowanie płaszcza (tekst; 13a/b już Accepted — retusz napisów + ewentualny reroll później).
5. **Night20** — „otwarty”→„zamknięty” w A+Flags.
6. **Night09** — rozdzielić komórkę i rachunek.
7. Medium: 08, 11, 19, 23, 22, 12, 04.

Proces generacji po poprawkach kart: `World/s1-mj-process.md` (pętla z QA + max 5 cykli / panel).

---

## 6. Poza zakresem

- Przepisanie Lessons / caption_pl w tym commicie.  
- Regeneracja Midjourney.  
- Compliance / S2+.  
- Zmiany werdyktów / delta / Ratio.
