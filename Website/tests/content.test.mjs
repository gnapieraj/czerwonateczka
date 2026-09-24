import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const generated = new URL("../src/data/generated/", import.meta.url);

test("eksport zawiera dwanaście kompletnych nocy", async () => {
  const lessons = JSON.parse(await readFile(new URL("lessons.json", generated), "utf8"));
  assert.equal(lessons.length, 12);
  assert.deepEqual(
    lessons.map((lesson) => lesson.order),
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
  );
  for (const lesson of lessons) {
    assert.ok(lesson.title.pl);
    assert.ok(lesson.awareness.threat.pl);
    assert.ok(lesson.redFlags.length >= 1);
    assert.ok(lesson.sourceIds.length >= 1);
    assert.match(lesson.hero, /^Night\d{2}a$/);
    assert.equal(lesson.beats.length, 2);
  }
});

test("źródła używają HTTPS", async () => {
  const sources = JSON.parse(await readFile(new URL("sources.json", generated), "utf8"));
  assert.ok(sources.length >= 1);
  assert.equal(new Set(sources.map((source) => source.id)).size, sources.length);
  for (const source of sources) {
    assert.match(source.url, /^https:\/\//);
  }
});

test("witryna oddziela fikcję od prawdziwego autora", async () => {
  const layout = await readFile(new URL("../src/layouts/BaseLayout.astro", import.meta.url), "utf8");
  const newsletter = await readFile(new URL("../src/pages/newsletter.astro", import.meta.url), "utf8");
  assert.match(layout, /jest fikcyjna/);
  assert.match(layout, /serwis edukacyjny prowadzi/i);
  assert.match(newsletter, /administratorem listy jest Grzegorz Napieraj/);
});

test("formularz newslettera mapuje pola Brevo i wymaga zgody OPT_IN", async () => {
  const form = await readFile(new URL("../src/components/NewsletterForm.astro", import.meta.url), "utf8");
  assert.match(form, /PUBLIC_NEWSLETTER_FORM_ACTION/);
  assert.match(form, /action \?/);
  assert.match(form, /OPT_IN/);
  assert.match(form, /email_address_check/);
  assert.match(form, /EMAIL|emailField/);
  assert.match(form, /setCustomValidity/);
  assert.match(form, /fetch\(/);
  assert.match(form, /Formularz nie zbiera jeszcze adresów/);
});

test("każda noc ma publiczne copy WWW", async () => {
  const lessons = JSON.parse(await readFile(new URL("lessons.json", generated), "utf8"));
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  for (const lesson of lessons) {
    assert.match(site, new RegExp(`"${lesson.id}":`));
  }
  assert.match(site, /newsletterSequence/);
  assert.match(site, /mfa-tylko-swoje/);
  assert.match(site, /Poznaj grę/);
  assert.match(site, /\/o-projekcie/);
});

test("newsletter ma stronę po wypisie", async () => {
  const page = await readFile(
    new URL("../src/pages/newsletter/wypisano.astro", import.meta.url),
    "utf8",
  );
  assert.match(page, /WYPISANO|Wypisano/);
  assert.match(page, /Czerwonej lampki|Czerwona lampka/);
  assert.match(page, /noindex/);
});

test("newsletter pokazuje potwierdzenie po DOI", async () => {
  const page = await readFile(new URL("../src/pages/newsletter.astro", import.meta.url), "utf8");
  const dedicated = await readFile(
    new URL("../src/pages/newsletter/potwierdzony.astro", import.meta.url),
    "utf8",
  );
  assert.match(page, /newsletter-confirmed/);
  assert.match(page, /"zapis".*potwierdzony|potwierdzony/);
  assert.match(dedicated, /Astro\.redirect|zapis=potwierdzony/);
});

test("o-projekcie pokazuje zrzuty i status App Store", async () => {
  const page = await readFile(new URL("../src/pages/o-projekcie.astro", import.meta.url), "utf8");
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  assert.match(page, /iphone-wokanda\.jpg/);
  assert.match(page, /ipad-wokanda\.jpg/);
  assert.match(page, /ipad-wokanda-landscape\.jpg/);
  assert.match(page, /DeviceShot/);
  assert.match(page, /device-gallery--phones/);
  assert.match(page, /device-gallery--ipads/);
  assert.match(page, /premiera-newsletter/);
  assert.match(page, /Pobierz w App Store|appStore/);
  assert.match(site, /appStore/);
  assert.match(site, /nie jest jeszcze publicznie dostępna/);
});

test("strona autora używa portretu noirovego", async () => {
  const autor = await readFile(new URL("../src/pages/autor.astro", import.meta.url), "utf8");
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  assert.match(autor, /AutorPortrait/);
  assert.match(autor, /authorLinkedIn|linkedin\.com\/in\/napieraj-grzegorz/);
  assert.match(site, /linkedin\.com\/in\/napieraj-grzegorz/);
  assert.doesNotMatch(autor, /MecenasPOV/);
});

test("strona prywatności zawiera tylko niezbędne dane administratora", async () => {
  const privacy = await readFile(new URL("../src/pages/prywatnosc.astro", import.meta.url), "utf8");
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  const autor = await readFile(new URL("../src/pages/autor.astro", import.meta.url), "utf8");
  assert.doesNotMatch(privacy, /WERSJA ROBOCZA|REGON|e-Doręczenia|CEIDG|521993348|AE:PL/);
  assert.match(privacy, /Brevo/);
  assert.match(privacy, /double opt-in/);
  assert.match(privacy, /OVHcloud/);
  assert.match(site, /Grzegorz Napieraj IT Security/);
  assert.match(site, /Stare Sady 6\/19/);
  assert.match(autor, /nipDisplay/);
});
