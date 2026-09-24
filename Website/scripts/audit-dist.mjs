import { access, readdir, readFile } from "node:fs/promises";
import { extname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const website = resolve(fileURLToPath(new URL("..", import.meta.url)));
const dist = resolve(website, "dist");
const htmlFiles = await walk(dist, ".html");
const failures = [];
const tracker = /gtag\(|googletagmanager|facebook\.net|hotjar|doubleclick/i;
const legalAdviceCta = /umów poradę|porada prawna online|kancelaria przyjmuje/i;

for (const file of htmlFiles) {
  const html = await readFile(file, "utf8");
  const relative = file.slice(dist.length);
  check((html.match(/<h1(?:\s|>)/g) ?? []).length === 1, relative, "strona powinna mieć dokładnie jeden nagłówek h1");
  check(/<html lang="pl">/.test(html), relative, "brak polskiego lang");
  check(/<meta name="description" content="[^"]+">/.test(html), relative, "brak opisu meta");
  check(/<meta name="viewport"/.test(html), relative, "brak viewport");
  check(/Przejdź do treści/.test(html), relative, "brak skip-linku");
  check(!tracker.test(html), relative, "wykryto tracker reklamowy");
  check(!legalAdviceCta.test(html), relative, "wykryto CTA sugerujące realną poradę prawną");

  const references = [
    ...html.matchAll(/(?:href|src)="([^"]+)"/g),
  ].map((match) => match[1]);
  for (const srcset of html.matchAll(/srcset="([^"]+)"/g)) {
    for (const part of srcset[1].split(",")) {
      const url = part.trim().split(/\s+/)[0];
      if (url) references.push(url);
    }
  }
  for (const srcset of html.matchAll(/imagesrcset="([^"]+)"/g)) {
    for (const part of srcset[1].split(",")) {
      const url = part.trim().split(/\s+/)[0];
      if (url) references.push(url);
    }
  }
  for (const reference of references) {
    if (!reference.startsWith("/") || reference.startsWith("//")) continue;
    const pathname = reference.split(/[?#]/)[0];
    const target = extname(pathname)
      ? join(dist, pathname)
      : join(dist, pathname, "index.html");
    try {
      await access(target);
    } catch {
      failures.push(`${relative}: niedziałający odnośnik ${reference}`);
    }
  }
}

try {
  const headers = await readFile(join(dist, "_headers"), "utf8");
  check(headers.includes("Strict-Transport-Security"), "_headers", "brak HSTS");
  check(headers.includes("Content-Security-Policy"), "_headers", "brak CSP");
  check(headers.includes("X-Content-Type-Options: nosniff"), "_headers", "brak nosniff");
  check(headers.includes("X-Frame-Options: DENY"), "_headers", "brak DENY");
} catch {
  failures.push("dist/_headers: plik nie został skopiowany do wydania");
}

try {
  const home = await readFile(join(dist, "index.html"), "utf8");
  check(/fikcja/.test(home), "/index.html", "brak komunikatu, że kancelaria jest fikcją");
  check(/Grzegorz Napieraj/.test(home), "/index.html", "brak prawdziwego autora na stronie głównej");
} catch {
  failures.push("/index.html: brak strony głównej w dist");
}

if (failures.length) {
  console.error(failures.join("\n"));
  process.exit(1);
}

console.log(`Audyt statyczny: ${htmlFiles.length} stron, zero brakujących odnośników.`);

function check(condition, page, message) {
  if (!condition) failures.push(`${page}: ${message}`);
}

async function walk(directory, extension) {
  const output = [];
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    const path = join(directory, entry.name);
    if (entry.isDirectory()) output.push(...(await walk(path, extension)));
    else if (path.endsWith(extension)) output.push(path);
  }
  return output;
}
