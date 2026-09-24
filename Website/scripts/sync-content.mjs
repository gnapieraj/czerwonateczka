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
if (!Array.isArray(lessons) || lessons.length !== 12) {
  throw new Error(`Oczekiwano 12 lekcji, otrzymano: ${lessons.length}`);
}

const sourcePath = resolve(root, "Views/SourcesView.swift");
const sourceSwift = await readFile(sourcePath, "utf8");
const sourcesFromSwift = parseSourceCalls(sourceSwift);
const sources =
  sourcesFromSwift.length > 0
    ? sourcesFromSwift
    : [
        {
          id: "sans-ouch",
          category: {
            pl: "Świadomość bezpieczeństwa",
            en: "Security awareness",
          },
          title: {
            pl: "SANS OUCH! — newsletter świadomości bezpieczeństwa",
            en: "SANS OUCH! — security-awareness newsletter",
          },
          note: {
            pl: "Dwanaście nocy bierze tematy z newslettera SANS OUCH. Sceny, nazwiska i kancelaria Colgante są fikcją. To nie jest porada prawna ani cytat z newslettera.",
            en: "The twelve nights take their topics from the SANS OUCH newsletter. The scenes, names and Colgante firm are fiction. This is not legal advice and not a quotation from the newsletter.",
          },
          url: "https://www.sans.org/newsletters/ouch",
        },
      ];

if (sources.length < 1) {
  throw new Error("Eksport źródeł jest pusty.");
}

const originId = sources[0].id;
const lessonsForWeb = lessons.map((lesson) => ({
  ...lesson,
  sourceIds:
    Array.isArray(lesson.sourceIds) && lesson.sourceIds.length > 0
      ? lesson.sourceIds
      : [originId],
}));

await Promise.all([
  writeJson(resolve(generated, "lessons.json"), lessonsForWeb),
  writeJson(resolve(generated, "sources.json"), sources),
  writeJson(resolve(generated, "meta.json"), {
    generatedAt: new Date().toISOString(),
    legalState: extractLegalState(sourceSwift) || "22.09.2026",
    lessonCount: lessons.length,
    sourceCount: sources.length,
  }),
]);

const castImages = [
  "OfficeNight",
  "DeskFolders",
  "MecenasPOV",
  "AplikantIglica",
  "PartnerChropot",
  "SekretariatIrena",
];
const nightImages = Array.from({ length: 12 }, (_, index) => {
  const n = String(index + 1).padStart(2, "0");
  return [`Night${n}a`, `Night${n}b`];
}).flat();
const imageNames = [...castImages, ...nightImages];

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

const screenDir = resolve(website, "src/assets/screens");
const publicScreens = resolve(publicAssets, "screens");
await mkdir(publicScreens, { recursive: true });
const screenFiles = [
  "iphone-wokanda.jpg",
  "iphone-komiks.jpg",
  "iphone-teczka.jpg",
  "ipad-wokanda.jpg",
  "ipad-wokanda-landscape.jpg",
];
await Promise.all(
  screenFiles.map((name) => copyFile(resolve(screenDir, name), resolve(publicScreens, name))),
);

console.log(
  `Zsynchronizowano ${lessons.length} teczek, ${sources.length} źródeł, ${imageNames.length + websitePortraits.length} grafik i ${screenFiles.length} zrzutów.`,
);

function extractLegalState(input) {
  return input.match(/static let legalState = "([^"]+)"/)?.[1] ?? "";
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
