import { copyFile, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import sharp from "sharp";

const here = dirname(fileURLToPath(import.meta.url));
const website = resolve(here, "..");
const root = resolve(website, "..");
const generated = resolve(website, "src/data/generated");
const publicAssets = resolve(website, "public/assets");
const publicFonts = resolve(website, "public/fonts");

await Promise.all([
  mkdir(generated, { recursive: true }),
  mkdir(publicAssets, { recursive: true }),
  mkdir(publicFonts, { recursive: true }),
]);

const lessonsPath = resolve(root, "Resources/Lessons.json");
const lessons = JSON.parse(await readFile(lessonsPath, "utf8"));
if (!Array.isArray(lessons) || lessons.length !== 8) {
  throw new Error(`Oczekiwano 8 lekcji, otrzymano: ${lessons.length}`);
}

const sourcePath = resolve(root, "Views/SourcesView.swift");
const sourceSwift = await readFile(sourcePath, "utf8");
const sources = parseSourceCalls(sourceSwift);
if (sources.length < 25) {
  throw new Error(`Eksport bibliografii wygląda na niepełny: ${sources.length} pozycji`);
}

await Promise.all([
  writeJson(resolve(generated, "lessons.json"), lessons),
  writeJson(resolve(generated, "sources.json"), sources),
  writeJson(resolve(generated, "meta.json"), {
    generatedAt: new Date().toISOString(),
    legalState: extractLegalState(sourceSwift),
    lessonCount: lessons.length,
    sourceCount: sources.length,
  }),
]);

const imageNames = [
  "OfficeNight",
  "DeskFolders",
  "MecenasPOV",
  "AplikantIglica",
  "PartnerChropot",
  "SekretariatIrena",
  ...Array.from({ length: 8 }, (_, index) => `Mission${String(index + 1).padStart(2, "0")}`),
];

await Promise.all(
  imageNames.map(async (name) => {
    const source = resolve(root, `Resources/Assets.xcassets/${name}.imageset/${name}.png`);
    await Promise.all([
      optimizeImage(source, resolve(publicAssets, `${name}.webp`), 1400, 68),
      optimizeImage(source, resolve(publicAssets, `${name}-1000.webp`), 1000, 64),
      optimizeImage(source, resolve(publicAssets, `${name}-720.webp`), 720, 64),
    ]);
    await rm(resolve(publicAssets, `${name}.png`), { force: true });
  }),
);

const websitePortraits = [{ name: "AutorPortrait", source: resolve(website, "src/assets/AutorPortrait.png") }];
await Promise.all(
  websitePortraits.map(async ({ name, source }) => {
    await Promise.all([
      optimizeImage(source, resolve(publicAssets, `${name}.webp`), 1050, 72),
      optimizeImage(source, resolve(publicAssets, `${name}-1000.webp`), 1000, 68),
      optimizeImage(source, resolve(publicAssets, `${name}-720.webp`), 720, 66),
    ]);
  }),
);

await Promise.all([
  copyFile(resolve(root, "Resources/Fonts/GoboCaps-Regular.otf"), resolve(publicFonts, "GoboCaps-Regular.otf")),
  copyFile(resolve(root, "Resources/Fonts/GoboCaps-Italic.otf"), resolve(publicFonts, "GoboCaps-Italic.otf")),
]);

console.log(`Zsynchronizowano ${lessons.length} teczek, ${sources.length} źródeł i ${imageNames.length + websitePortraits.length} grafik.`);

function extractLegalState(input) {
  return input.match(/static let legalState = "([^"]+)"/)?.[1] ?? "nieustalony";
}

function parseSourceCalls(input) {
  const calls = [];
  let cursor = 0;
  while ((cursor = input.indexOf("source(", cursor)) !== -1) {
    const before = input.slice(Math.max(0, cursor - 20), cursor);
    if (before.includes("func ")) {
      cursor += 7;
      continue;
    }
    let index = cursor + "source(".length;
    let quoted = false;
    let escaped = false;
    let depth = 1;
    for (; index < input.length && depth > 0; index += 1) {
      const char = input[index];
      if (quoted) {
        if (escaped) escaped = false;
        else if (char === "\\") escaped = true;
        else if (char === '"') quoted = false;
      } else if (char === '"') quoted = true;
      else if (char === "(") depth += 1;
      else if (char === ")") depth -= 1;
    }
    const body = input.slice(cursor + "source(".length, index - 1);
    const values = [...body.matchAll(/"((?:\\.|[^"\\])*)"/g)].map((match) => JSON.parse(`"${match[1]}"`));
    if (values.length === 8) {
      const [id, categoryPL, categoryEN, titlePL, titleEN, notePL, noteEN, url] = values;
      calls.push({
        id,
        category: { pl: categoryPL, en: categoryEN },
        title: { pl: titlePL, en: titleEN },
        note: { pl: notePL, en: noteEN },
        url,
      });
    }
    cursor = index;
  }
  return calls;
}

async function writeJson(path, value) {
  await writeFile(path, `${JSON.stringify(value, null, 2)}\n`);
}

async function optimizeImage(source, target, width, quality) {
  await sharp(source)
    .resize({ width, height: width, fit: "inside", withoutEnlargement: true })
    .webp({ quality, effort: 6, smartSubsample: true })
    .toFile(target);
}
