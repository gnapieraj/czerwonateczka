# Słownik pozycji w grze

Mapa pól i ekranów Czerwonej Teczki: co dana pozycja oznacza i jakie ma zastosowanie w mechanice. To nie jest poradnik merytoryczny ani porada prawna.

Stan opisu: 11.09.2026.

---

## Jak idzie sesja

1. **Splash** (ekran otwarcia)
2. **Biblia wizualna** — tylko za pierwszym razem
3. **Biurko / wokanda** — lista ośmiu teczek
4. **Komiks** — 4 kadry, 2 strony
5. **Teczka** — dokument i decyzja
6. **Ratio** — uzasadnienie po wyborze
7. opcjonalnie **Briefing** i **Źródła**
8. powrót na wokandę (stempel zostaje)

---

## Splash

Pierwszy kadr po starcie. Nie ma przycisku — stuknięcie albo ok. 7 sekund przenosi dalej.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| **CZERWONA TECZKA** | Tytuł gry (kicker) | Identyfikacja produktu, nie treść sprawy |
| **The Red File** | Podtytuł | Wersja językowa lustrzana (PL pokazuje EN i odwrotnie) |
| **Kancelaria Colgante i Wspólnicy** | Fikcyjna kancelaria | Kanoniczne miejsce akcji; nie wskazuje prawdziwej firmy |
| **Za żaluzją: PKiN w deszczu** | Klimat miejsca | Tylko świat gry, zero mechaniki |
| **Adres** | 5. piętro, biurowiec od Świętokrzyskiej | Fikcja; nie jest lokalizacją prawdziwej kancelarii |
| **Disclaimer fikcji** | Informacja, że osoby i adres są zmyślone | Ochrona przed skojarzeniem z realną kancelarią |

---

## Biurko / wokanda

Główny hub. Wokanda = lista wszystkich teczek na biurku. Nie ma osobnego ekranu o nazwie „Wokanda” — to właśnie to biurko.

### Nagłówek kancelarii

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| Nazwa kancelarii | Colgante i Wspólnicy | Stały kanon, ten sam we wszystkich teczkach |
| Adres | Fikcyjna lokalizacja | Świat gry |
| Disclaimer | „Podobieństwo niezamierzone” | Informacja, nie zadanie |

### Liczniki (metry)

Cztery paski 0–100. Start: **100**. Po decyzji doliczają się delty wybranej opcji (nie spadają poniżej 0, nie rosną powyżej 100). To **nie jest ocena prawna** — gra sama to pisze na ekranie Ratio.

| Licznik | Co mierzy w symulacji | Kiedy spada / rośnie |
|---|---|---|
| **Tajemnica** | Ochrona informacji objętych tajemnicą zawodową / danymi | Spada przy wklejeniu akt do chmury, USB bez szyfrowania itd. |
| **Sąd** | Rzetelność wobec sądu / wokandy | Spada przy fałszywych cytatach, nieredagowanym PDF itd. |
| **Klient** | Relacja i zaufanie klienta | Spada przy gołym odrzucie bez wyjaśnienia albo przy szkodzie dla klienta |
| **Rozliczalność** | Dokumentowanie decyzji, ślad, odpowiedzialność | Rośnie przy weryfikacji i drugim kanale; spada przy ślepym stemplu |

**Liczniki kampanii** (w Ustawieniach):

- **wyłączone** (domyślnie, na spotkanie): każda teczka startuje od 100
- **włączone**: liczniki niosą się przez wieczór między teczkami

Stemple na wokandzie zapisują się **zawsze**, niezależnie od tego przełącznika.

### Obsada — biblia wizualna

Przycisk na wokandzie i ikona ludzi u góry. Za pierwszym uruchomieniem otwiera się sama, zanim dojdziesz do biurka.

To **nie jest materiał edukacyjny**. Służy do rozpoznania twarzy, zanim otworzysz teczkę.

| Kadry | Kim jest | Rola w fabułach |
|---|---|---|
| **Ty — mecenas przy biurku** | Gracz. Nigdy pełna twarz | Decydujesz: stempel / odrzut / drugi kanał |
| **Aplikant Filip Iglica** | Nerwowy aplikant | Przynosi apelację, prompt, memo |
| **Partner Chropot** | Partner w pociągu | Presja czasu („stempel do północy”) |
| **Irena, sekretariat** | Sekretariat | USB, HR, fizyczne nośniki |
| **OfficeNight** | Piąte piętro, żaluzja, PKiN | Miejsce, nie postać |

Przycisk **Do biurka — wokanda** zamyka biblię i wraca do listy teczek.

### Karta teczki na wokandzie

Każda z 8 pozycji to jedna sprawa.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| **Miniatura** | Grafika misji (`Mission01`…`08`) | Wejście w komiks tej teczki |
| **Numer `01`…`08`** | Kolejność na wokandzie | Identyfikator sprawy, nie sygnatura sądowa |
| **PRO BONO** | Znacznik tonu | Tylko teczka 08 (HR / emotion AI). Sygnał: inna presja niż „klient płaci” |
| **Tytuł** | Nazwa sprawy | Np. „Sygnatura z niebytu” |
| **Podtytuł** | Gatunek + temat | Np. „Apelacja · prawa autorskie” — orientacja, nie treść decyzji |
| **Termin (czerwony)** | Presja czasu w fabule | Uzasadnia pośpiech; **nie** jest prawdziwym terminem procesowym |
| **Stempel TRAFNE / NIEPEŁNE / BŁĘDNE** | Werdykt ostatniej decyzji | Zostaje na wokandzie, aż zdejmiesz stemple w ustawieniach |
| **Ikona info** | Wejście do briefingu | Możesz przeczytać zagrożenie **bez** grania teczki |
| **Folder / pieczęć** | Stan: nierozstrzygnięta vs rozstrzygnięta | Czerwona pieczęć = ostatni werdykt był błędny |

Osiem teczek:

| Nr | Tytuł | Typ dowodu (wewnętrznie) | O czym jest decyzja |
|---|---|---|---|
| 01 | Sygnatura z niebytu | pismo (`pleading`) | Halucynacje orzeczeń w apelacji |
| 02 | Szept w chmurze | prompt | SPA wklejone do publicznego ChatGPT |
| 03 | Głos z lotniska | telefon | Polecenie „przelej teraz” |
| 04 | Czerwone prostokąty | PDF | Czarne ramki zamiast trwałej redakcji |
| 05 | Pendrive w koszulce | USB | Niezaszyfrowany nośnik |
| 06 | Mail prawie od mecenasa | e-mail | BEC / zmiana rachunku |
| 07 | Nasz Copilot też kłamie | memo | Halucynacja w narzędziu kancelarii |
| 08 | Kamera na minie | HR | Emotion AI (AI Act) |

Flaga **demo** (01, 03, 04) jest w danych, nie na ekranie: to trzy teczki „na wieczór / spotkanie”. Wokanda i tak pokazuje wszystkie osiem.

---

## Komiks

Po stuknięciu teczki. Dwie strony po dwa kadry. **Nie spoiluje rozwiązania** — kończy się pytaniem, nie instrukcją.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| **Tytuł u góry** | Tytuł teczki | Orientacja: w której sprawie jesteś |
| **PRO BONO** | Jak na wokandzie | Tylko 08 |
| **Kadr z podpisem prostokątnym** | Narracja (`caption`) | Głos narratora / opis sytuacji |
| **Kadr z dymkiem okrągłym, kursywa** | Replika (`balloon`) | Ktoś mówi: Iglica, Chropot, Irena |
| **`01 · 1/2`** | Numer teczki i strony | Nawigacja komiksu, nie sygnatura |
| **Dalej / Poprzednia** | Strony komiksu | Nie wychodzi z teczki |
| **Otwórz teczkę** | Na ostatniej stronie | Przejście do dokumentu i decyzji |
| **Wstecz** | Powrót | Na wokandę (z pierwszego ekranu komiksu) |

Komiks **nie ocenia**. Daje kontekst emocjonalny i presję, zanim zobaczysz akt.

---

## Teczka (ekran decyzji)

Tu podejmujesz decyzję. To jest właściwa „czerwona teczka”.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| **Tytuł (chrome)** | Nazwa sprawy | Nagłówek ekranu |
| **PRO BONO** | Ton sprawy | Jak wyżej |
| **Podtytuł** | Gatunek | Szybkie przypomnienie tematu |
| **Termin** | Deadline fabularny | Presja; nie uruchamia zegara |
| **Kontekst** | Akapit fabuły | Kto, gdzie, co leży na biurku. To **scenariusz**, nie norma prawna |
| **Etykieta dowodu** (czerwona, np. `APELACJA — fragment`) | Co leży na papierze | Rodzaj exhibit: pismo, prompt, mail, PDF… |
| **Tekst dowodu** (jasna karta) | Fragment aktu / maila / promptu | To, na czym opierasz decyzję. Często zawiera pułapkę |
| **GŁOS WEWNĘTRZNY** | Pytanie mecenasa do siebie | **Nie podpowiada odpowiedzi.** Ma skierować uwagę na fakt do sprawdzenia |
| **Trzy przyciski decyzji** | Wybór mechaniczny | Zapisuje stempel, rusza liczniki, otwiera Ratio |

Głos wewnętrzny **nie jest briefingiem** i **nie jest ratio**. To pytanie diagnostyczne („co musisz zobaczyć, zanim podpiszesz?”), nie checklista rozwiązania.

---

## Trzy decyzje (stempel / odrzut / drugi kanał)

Na każdej teczce są trzy przyciski. **Kolor nie oznacza „dobrze/źle”** — czerwony to zawsze STEMPEL (akcja w sensie „puszczam sprawę”), jasny to ODRZUT i DRUGI KANAŁ.

| Przycisk | Co robisz w świecie gry | Typowa ocena | Typowy skutek |
|---|---|---|---|
| **STEMPEL** | Akceptujesz / podpisujesz / puszczasz | zwykle **BŁĘDNE** | Duży spadek liczników |
| **ODRZUT** | Odcinasz problem, ale bez pełnej procedury | zwykle **NIEPEŁNE** | Chroni część ryzyka, psuje relację albo zostawia lukę |
| **DRUGI KANAŁ** | Weryfikujesz niezależnie (LEX, telefon, DPA, redakcja…) | zwykle **TRAFNE** | Lekki wzrost Sądu / Rozliczalności / Tajemnicy |

Każdy przycisk ma:

| Pole na przycisku | Co to jest |
|---|---|
| **Tytuł** | STEMPEL / ODRZUT / DRUGI KANAŁ (albo wariant, np. „LEX / ISAP”) |
| **Podtytuł** | Konkretna akcja w tej teczce, np. „Podpisz i wyślij” |

Po wyborze **nie ma cofnięcia decyzji**. Wstecz z Ratio wraca do teczki, ale stempel na wokandzie już jest. Można zagrać teczkę ponownie — nowy wybór nadpisze stempel.

---

## Werdykty (stemple)

Nie ma binarnego pass/fail.

| Stempel | Znaczenie w grze | Kolor |
|---|---|---|
| **TRAFNE** | Decyzja merytorycznie właściwa w scenariuszu | jasny |
| **NIEPEŁNE** | Kierunek dobry, ale brakuje kroku (np. odrzut bez wskazania, które sygnatury są fałszywe) | przygaszony |
| **BŁĘDNE** | Akcja zwiększa ryzyko / narusza obowiązek | krew |

To **ocena scenariusza**, nie ocena kompetencji gracza i nie wyrok dyscyplinarny.

---

## Ratio

Ekran po decyzji. „Ratio” = **uzasadnienie wybranego ruchu**, nie „jedyna słuszna wykładnia”. Każda z trzech opcji ma **własne** Ratio — czytasz skutki **tego**, co wybrałeś, nie wzorcowej odpowiedzi.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| **Kicker TRAFNE / NIEPEŁNE / BŁĘDNE** | Werdykt tej decyzji | Od razu widać ocenę |
| **Tytuł teczki** | Sprawa | Kontekst |
| **Tytuł + podtytuł wyboru** | Co zrobiłeś | Żeby nie pomylić z inną opcją |
| **Liczniki** | Stan **po** delcie | Symulacja skutku; zastrzeżenie pod spodem |
| **PRZEPIS** | Norma / reguła etyczna, na której stoi ocena | Oś prawna tej decyzji, nie pełna glosa |
| **SKUTEK** | Co może się stać w świecie gry i w praktyce | Świadomie nieautomatyczne („możliwe wezwanie, koszty…”) |
| **REFLEKS** | Co robić następnym razem | Jedna praktyczna linia postępowania (odruch kancelaryjny) |
| **WZORZEC PUBLICZNY** | Publiczna sprawa / decyzja jako analogia | Mata, Park, Cork, UODO, Heppner… Często **niewiążąca w PL** |
| **CO SIĘ STAŁO** | Krótka historia tego wzorca | Fakty orzeczenia/decyzji, żeby nie zostawić samego cytatu sygnatury |
| **CO POWINNO BYŁO ZAPALIĆ LAMPKĘ** | Czerwone flagi **tej teczki** | Te same dla wszystkich trzech wyborów. Lista symptomów w dowodzie, nie ocena decyzji |
| **Briefing — zagrożenie i praktyka** | Wejście do briefingu | Warstwa „co robić w kancelarii”, szersza niż Ratio |
| **Źródła tej teczki** | Bibliografia **tylko tej** sprawy | Filtrowana lista, nie cały kanon |
| **Wróć do biurka** | Wokanda | Stempel zostaje na karcie teczki |

Jak rozróżniać trzy bloki prawne:

- **Przepis** = na jakiej podstawie to oceniamy
- **Skutek** = co może wyniknąć z tego ruchu
- **Refleks** = jaki nawyk warto wziąć na biurko

**Wzorzec publiczny** nie jest polskim precedensem, chyba że to decyzja UODO / wyrok polskiego sądu. Zagranica jest ilustracją staranności.

**Czerwone flagi** ≠ briefing. Flagę widzisz *po* decyzji („to powinno było zapalić lampkę w akcie”). Briefing możesz otworzyć *przed* grą.

---

## Briefing kancelaryjny (Awareness)

Ikona **i** na wokandzie albo przycisk z Ratio. Można czytać **przed** teczką — to nie spoiluje komiksu, ale świadomie pokazuje zagrożenie.

Nagłówek: **Briefing kancelaryjny** / kicker **AWARENESS**.

| Pole | Co to jest | Zastosowanie |
|---|---|---|
| Miniatura + numer + tytuł | Która teczka | Identyfikacja |
| **ZAGROŻENIE** | Jaki typ ryzyka jest w tej sprawie | Np. halucynacja cytatów, wyciek tajemnicy, BEC |
| **NA CO ZWRACAĆ UWAGĘ** | Objawy operacyjne | Checklist „co zobaczyć w mailu / PDF / USB” |
| **JAK MINIMALIZOWAĆ** | Środki zmniejszające ryzyko | Ogólna zasada, nie procedura konkretnej kancelarii |
| **W KANCELARII — PRAKTYKA** | Jak to wdrożyć u siebie | Polityka, drugi kanał, kto zatwierdza narzędzie |
| **Zamknij briefing** | Powrót | Nie zapisuje stempla |

Briefing **nie zastępuje Ratio**. Briefing = profilaktyka. Ratio = ocena konkretnego wyboru.

---

## Źródła

Dwa wejścia:

| Wejście | Co pokazuje |
|---|---|
| **Źródła tej teczki** (z Ratio) | Tylko źródła przypięte do tej lekcji (`sourceIds`) |
| **Źródła — przepisy i orzeczenia** (Ustawienia) | Cała bibliografia (32 pozycje) |

| Pole karty źródła | Co to jest | Zastosowanie |
|---|---|---|
| **Kategoria** | Prawo obowiązujące / Prawo UE / Etyka / Wytyczne / Orzeczenie / Przykład zagraniczny… | Hierarchia mocy: ustawa ≠ rekomendacja KIRP ≠ Mata |
| **Tytuł (link)** | Akt, orzeczenie, dokument | Otwiera URL w przeglądarce |
| **Notatka** | Co w tym źródle jest istotne dla gry | Żeby nie cytować sygnatury obok obcej tezy |
| **Zweryfikowano: 10.09.2026** | Stan prawa w paczce | Data cięcia treści, nie „prawo wieczne” |
| **Disclaimer u góry** | Gra nie jest poradą; zagranica nie jest precedensem | Rama korzystania ze źródeł |

---

## Ustawienia

Koło zębate na wokandzie.

| Pole | Co robi |
|---|---|
| **Język** | Polski / English — cała treść (komiks, teczka, ratio, źródła) |
| **Liczniki kampanii** | Czy metry resetują się na każdą teczkę |
| **Offline. Bez konta. Bez analityki.** | Informacja produktowa |
| **Źródła — przepisy i orzeczenia** | Pełna bibliografia |
| **Biblia wizualna (obsada)** | Te same portrety co na starcie |
| **Zdejmij stemple z wokandy** | Czyści TRAFNE/NIEPEŁNE/BŁĘDNE z kart; widać tylko gdy jakiś stempel jest |

---

## Szybkie rozróżnienia (najczęściej mylone)

| Widzisz | Nie myl z | Różnica |
|---|---|---|
| **Wokanda** | Teczka | Lista spraw vs jedna sprawa |
| **Biblia wizualna** | Briefing | Twarze i klimat vs ryzyko prawne |
| **Głos wewnętrzny** | Refleks | Pytanie *przed* decyzją vs nawyk *po* |
| **Kontekst** | Przepis | Fabuła vs norma |
| **Dowód (jasna karta)** | Wzorzec publiczny | Akt w tej sprawie vs obca ilustracja |
| **Czerwone flagi** | Na co zwracać uwagę | Flag po decyzji (w akcie) vs briefing przed grą |
| **Przepis** | Źródła tej teczki | Jedno zdanie w Ratio vs klikalna bibliografia |
| **Skutek** | Liczniki | Opis konsekwencji vs liczba 0–100 |
| **Wzorzec publiczny** | Przepis | Historia z gazety/sądu vs podstawa oceny |
| **STEMPEL (przycisk)** | Stempel TRAFNE na wokandzie | Akcja gracza vs ocena tej akcji |
