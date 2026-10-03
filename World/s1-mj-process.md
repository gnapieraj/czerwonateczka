# Sezon 1 — proces Midjourney (pętla obowiązkowa)

Źródło promptów / kart: `tools/macos-studio/komiks-sezony.md` §4.  
Kolejka: `World/s1-mj-queue.md`. Rejestr: `World/AssetRegistry.md`.  
Audyt ciągu przed designem: `World/audyt-logika-ciag.md` (A→B) + `World/audyt-dialogi-czytelnosc.md`.

**Cel:** agent **musi** przejść poniższą pętlę dla każdego panelu S1. Nie pomijać QA.  
**Domyślnie Greg wybiera wariant** (jak S0). Pełne auto-accept tylko gdy Greg **wyraźnie** deleguje — wtedy QA i tak jest mandatory pre-filter przed zapisem.

**Bez cloud agents.** Praca lokalna (Mac Studio) + midjourney.com/imagine.

---

## Pętla (obowiązkowa) — 7 kroków

### 1. Design nocy (zanim Imagine)

Dla nocy `N` zaprojektuj / zweryfikuj:

- kontekst PL, termin, pytanie (`innerVoice`), Napis A / Napis B, karty paneli (who / where / gesture / props / pass / fail);
- **causal A→B:** A = setup (stan, rekwizyt, gest wyjściowy); B = pressure (postać, rozkaz). Czas tylko do przodu.  
  **Test:** czy B pokazuje przyczynę tego, co A już pokazał jako skutek? Jeśli tak → **swap A/B**, przepisanie napisów albo split beatów (**wzór Critical: Night14** — kartka już na A, a B dopiero „kładzie”).
- most edukacyjny: pytanie ↔ kontekst ↔ napisy ↔ awareness (threat / practice). Gracz ma iść łańcuchem bez zgadywania.

Jeśli karta / napisy są sprzeczne z ciągiem — **najpierw popraw kartę w `komiks-sezony.md`**, potem generate. Nie „naprawiaj” odwróconej chronologii samym promptem MJ.

Zanim zablokujesz gest w prompcie (np. „telefon w powietrzu nad kartką”), sprawdź, czy wymaga tego **historia**, nie tylko stary napis. Jeśli kadr czyta się bez tego gestu, popraw napis pod kadr, nie odwrotnie.

### 2. Build promptów Imagine

- Character / office / window refs z lead accepted plates (patrz § Spójność).
- Szary blok = tylko to, co wklejasz; musi być zgodny z kartą (gesture, props, fail).
- Reject lists: litery/cyfry, red / wax seal / blood, palace of culture (chyba że karta prosi), weird limbs, fused fingers, photo blur, logos, Mecenas-as-POV w S1, Iglica jako druga osoba w S1.
- `paint_caption: no` — żadnych liter na płycie.
- Parametry stylu: § niżej.

### 3. Generate MJ 2×2

- midjourney.com/imagine — Stealth, V8.2.
- **Tylko Create 2×2. NIGDY Upscale.** Natywnie ~1456×816.
- Sesja: ~6–8 Imagine; paruj a→b tej samej nocy.

### 4. Autonomous visual QA (przed Gregiem / przed auto-accept)

Agent **sam** odrzuca czwórkę (lub warianty), jeśli pada którykolwiek punkt. QA jest **mandatory pre-filter** — Greg nie dostaje śmieci; przy delegacji auto agent nie zapisuje faili.

Checklist QA:

| # | Kryterium |
|---|---|
| 1 | Likeness postaci vs lead plates (Chropot / Irena / ręce aplikanta) |
| 2 | Biuro + widok za oknem ciągłe (biuro aplikanta / w dół vs falisty dach Mecenasa; Śródmieście) |
| 3 | Dokładnie 5 palców; brak fused / extra |
| 4 | Brak swapped hands / lustrzanych dłoni |
| 5 | Brak weird limbs / twarzy / anatomii |
| 6 | Brak clutter props spoza karty / historii |
| 7 | Brak liter / cyfr / glyphów na płycie |
| 8 | Brak red / wax seal / blood / gore |
| 9 | Palace of culture tylko gdy karta prosi; inaczej reject |
| 10 | Kadr = karta panelu (gesture + props + pass) |
| 11 | **Causal z napisem:** płyta A/B zgadza się z Napis A/B i z kolejnością setup→pressure |

Fail → krok 5. Pass → krok 6 (po wyborze Grega albo auto, jeśli delegowane).

### 5. Fail → popraw → regenerate (limit **5 cykli**)

1. Przepisanie promptu (szary blok) **albo** redesign założeń karty (gesture / props / who / where), gdy problem jest w designie, nie w losie MJ.
2. Ponowny Imagine 2×2.
3. Ponowne QA (krok 4).

**Limit autonomii: max 5 cykli** (generate → analyze → fix prompt/redesign) **na jeden panel**.

Po **5 nieudanych cyklach bez akceptacji:**

- **STOP.** Nie generuj 6. czwórki na własną rękę.
- Zapisz krótką notatkę w `World/s1-mj-queue.md` (panel, ile cykli, główne reject reasony).
- **Zapytaj Grega o zgodę na kontynuację** (kolejne cykle / zmiana karty / inny lead ref).

Ten limit obowiązuje także gdy Greg delegował „pełne auto” — bez jego OK po 5 failach agent nie kontynuuje.

### 6. Pass → zapis assetu

Po wyborze wariantu `N` (0–3) przez Grega — albo po auto-accept **tylko** gdy Greg delegował i QA przeszło:

1. Zapisz PNG → `Resources/Assets.xcassets/NightNNx.imageset/NightNNx.png`
2. CDN `…/0_N.png` + job `?index=N` → `World/AssetRegistry.md`
3. Status w `World/s1-mj-queue.md` → Done / Accepted
4. `artPending: false` w lekcji, gdy **oba** kadry a+b tej nocy są gotowe

### 7. Paczka dla Grega (zawsze przy propozycji wyboru)

Nawet gdy QA przeszło autonomicznie, przy pokazywaniu czwórki (domyślny tryb S0/S1) przygotuj **pełny pack**:

- kontekst PL (full),
- pytanie nocy,
- Napis A + Napis B,
- opisy paneli (karta: gesture / story / pass),
- ewentualna nota causal („A setup → B pressure”).

Greg nadal **wybiera** indeks, o ile nie powiedział później „full auto”. QA ≠ zastępstwo wyboru Grega.

---

## Flow akceptacji (domyślny = jak Sezon 0)

1. Agent: design + causal check → prompt → Imagine 2×2.  
2. Agent: QA; przy failu pętla ≤5; przy passie pack dla Grega.  
3. Greg: wybiera `0`–`3` albo reject (reject Grega ≠ zużycie limitu 5 w ten sam sposób — nowa czwórka po reject Grega to nowy cykl, ale po serii rejectów i tak pytaj, gdy utkniesz).  
4. Agent: zapis PNG + rejestr + `artPending`.

---

## Spójność postaci i miejsca

| Rola S1 | Lead refs |
|---|---|
| Aplikant (ręce / biała koszula) | `SezonAplikant` + ręce z accepted S1 |
| Chropot | `Night04b` + `Night12b` (+ accepted S1 Chropot) |
| Irena | `Night05b` (+ accepted S1 Irena) |

- Nigdy Mecenas jako POV S1. Iglica nie jako druga osoba w S1. Mecenas bez twarzy (poza kadrem / plecy / cień), gdy w ogóle.
- Reroll przy dryfie likeness albo lokalizacji (biuro / okno).
- `--iw` wg karty (dłonie ~0.35, postać ~0.4).

---

## Parametry stylu (S0 / S1)

- `--sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png`
- typowo `--sw 400 --stylize 0 --v 8.2 --stealth --ar 16:9`
- Character ref na początku szarego bloku.

---

## Zasady stałe (skrót)

1. Przed Imagine: kontekst + karta + napis; przepisz szary blok, jeśli nieaktualny.  
2. Tylko 2×2 — nigdy Upscale.  
3. Pałac tylko na życzenie karty; inaczej `--no palace of culture`.  
4. `paint_caption: no`.  
5. Causal A→B sprawdzony w kroku 1 i ponownie w QA (pkt 11).  
6. **Max 5 cykli autonomii / panel → potem STOP + pytanie do Grega.**  
7. Wybór Grega zostaje defaultem Free S1.

---

## Start kolejki

Patrz `World/s1-mj-queue.md`. **Night14a nie startować**, dopóki Critical causal z `audyt-logika-ciag.md` (C1) nie jest rozstrzygnięty w karcie / napisach.
