# Free → App Store — checklista

## Must-have

- [ ] S1: grafiki Night13–24, `artPending` = `false`
  - proces MJ (pętla 1–7, QA mandatory, **max 5 cykli / panel → STOP + Greg**): [`World/s1-mj-process.md`](World/s1-mj-process.md)
  - kolejka: [`World/s1-mj-queue.md`](World/s1-mj-queue.md)
  - prompty: `tools/macos-studio/komiks-sezony.md` §4
  - audyt ciągu A→B + edukacja: [`World/audyt-logika-ciag.md`](World/audyt-logika-ciag.md)
  - audyt czytelności napisów: [`World/audyt-dialogi-czytelnosc.md`](World/audyt-dialogi-czytelnosc.md)
  - **Night14a zablokowane** do naprawy causal (kartka A vs kładzenie B)
- [ ] `PrivacyInfo.xcprivacy`: Required Reason APIs (`UserDefaults`)
- [ ] `/prywatnosc`: Raport / Share / QR oraz link do `/prywatnosc` w Settings
- [ ] Zrzuty ekranu w ASC: iPhone 6.7″ + iPad (prawdziwy flow)
- [ ] Archive → TestFlight → smoke test S0 → S1
- [ ] Listing w ASC: opis, keywords, Privacy Policy (`https://colgante.pl/prywatnosc`), Support URL, age rating, App Privacy, AI/disclaimer
- [ ] Submit z `main` (bez Compliance); potem `site.appStore.url`

## Recommended

- [ ] Audyt ekspercki S1
- [ ] QA dźwięku / haptics / swipe
- [ ] Poprawki tekstu Critical z `audyt-logika-ciag.md` (14, 17, 24, 13, 20, 09) przed dalszym MJ

## Deferred (nie w Free)

- [ ] V3 raport / B2B / Compliance pack / IAP

## Stan wyjściowy

Lessons S0 + S1 są już OK; icon / signing / no IAP / raport MVP są zrobione.  
Wybór wariantu MJ przez Grega = default (jak S0), dopóki nie powie full auto; QA agenta i tak filtruje przed pokażeniem / zapisem.
