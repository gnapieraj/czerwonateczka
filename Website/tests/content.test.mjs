import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const generated = new URL("../src/data/generated/", import.meta.url);

test("eksport zawiera osiem kompletnych teczek", async () => {
  const lessons = JSON.parse(await readFile(new URL("lessons.json", generated), "utf8"));
  assert.equal(lessons.length, 8);
  assert.deepEqual(
    lessons.map((lesson) => lesson.order),
    [1, 2, 3, 4, 5, 6, 7, 8],
  );
  for (const lesson of lessons) {
    assert.ok(lesson.title.pl);
    assert.ok(lesson.awareness.threat.pl);
    assert.ok(lesson.redFlags.length >= 3);
    assert.ok(lesson.sourceIds.length >= 1);
  }
});

test("bibliografia jest kompletna i używa HTTPS", async () => {
  const sources = JSON.parse(await readFile(new URL("sources.json", generated), "utf8"));
  assert.equal(sources.length, 32);
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

test("formularz newslettera nie zbiera danych bez konfiguracji", async () => {
  const form = await readFile(new URL("../src/components/NewsletterForm.astro", import.meta.url), "utf8");
  assert.match(form, /PUBLIC_NEWSLETTER_FORM_ACTION/);
  assert.match(form, /action \?/);
  assert.match(form, /Formularz nie zbiera jeszcze adresów/);
  assert.match(form, /company_website/);
  assert.match(form, /consent/);
});

test("każda teczka ma publiczne copy WWW", async () => {
  const lessons = JSON.parse(await readFile(new URL("lessons.json", generated), "utf8"));
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  for (const lesson of lessons) {
    assert.match(site, new RegExp(`"${lesson.id}":`));
  }
  assert.match(site, /newsletterSequence/);
});

test("strona autora używa portretu noirovego", async () => {
  const autor = await readFile(new URL("../src/pages/autor.astro", import.meta.url), "utf8");
  assert.match(autor, /AutorPortrait/);
  assert.doesNotMatch(autor, /MecenasPOV/);
});

test("strona prywatności zawiera tylko niezbędne dane administratora", async () => {
  const privacy = await readFile(new URL("../src/pages/prywatnosc.astro", import.meta.url), "utf8");
  const site = await readFile(new URL("../src/data/site.ts", import.meta.url), "utf8");
  const autor = await readFile(new URL("../src/pages/autor.astro", import.meta.url), "utf8");
  assert.doesNotMatch(privacy, /WERSJA ROBOCZA|REGON|e-Doręczenia|CEIDG|521993348|AE:PL/);
  assert.match(privacy, /nie jest prowadzona/);
  assert.match(privacy, /OVHcloud/);
  assert.match(site, /Grzegorz Napieraj IT Security/);
  assert.match(site, /Stare Sady 6\/19/);
  assert.match(autor, /nipDisplay/);
});
