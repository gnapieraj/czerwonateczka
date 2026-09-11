import { spawn } from "node:child_process";
import { createRequire } from "node:module";
import { existsSync } from "node:fs";
import { mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";

const origin = process.argv[2] || process.env.QA_URL || "http://127.0.0.1:4323";
const pages = ["/", "/wokanda", "/newsletter", "/autor"];
const lighthouseCli = createRequire(import.meta.url).resolve("lighthouse/cli/index.js");
const chrome = [
  process.env.CHROME_PATH,
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
].find((candidate) => candidate && existsSync(candidate));

if (!chrome) {
  console.error("Brak Chrome lub Edge. Ustaw CHROME_PATH.");
  process.exit(1);
}

const floors = {
  performance: 0.9,
  accessibility: 1,
  "best-practices": 1,
  seo: 1,
};

const failures = [];
const scratch = await mkdtemp(join(tmpdir(), "colgante-qa-"));

try {
  for (const page of pages) {
    const url = new URL(page, origin).href;
    const output = join(scratch, `${page.replaceAll("/", "_") || "home"}.json`);
    await run("node", [
      lighthouseCli,
      url,
      `--chrome-flags=--headless --no-sandbox --disable-gpu`,
      "--only-categories=performance,accessibility,best-practices,seo",
      "--output=json",
      `--output-path=${output}`,
      "--quiet",
    ], { CHROME_PATH: chrome });
    const report = JSON.parse(await readFile(output, "utf8"));
    const scores = Object.fromEntries(
      Object.entries(report.categories).map(([name, category]) => [name, category.score]),
    );
    console.log(
      `${page}: ` +
        Object.entries(scores)
          .map(([name, score]) => `${name} ${Math.round(score * 100)}`)
          .join(", "),
    );
    for (const [name, floor] of Object.entries(floors)) {
      if ((scores[name] ?? 0) < floor) {
        failures.push(`${page}: ${name} ${Math.round((scores[name] ?? 0) * 100)} < ${Math.round(floor * 100)}`);
      }
    }
  }
} finally {
  await rm(scratch, { recursive: true, force: true });
}

if (failures.length) {
  console.error(failures.join("\n"));
  process.exit(1);
}

console.log("Lighthouse: progi wydajności, dostępności, praktyk i SEO spełnione.");

function run(command, args, extraEnv = {}) {
  return new Promise((resolveRun, reject) => {
    const child = spawn(command, args, {
      stdio: "inherit",
      env: { ...process.env, ...extraEnv },
    });
    child.on("error", reject);
    child.on("exit", (code) => {
      if (code === 0) resolveRun();
      else reject(new Error(`${command} zakończył się kodem ${code}`));
    });
  });
}
