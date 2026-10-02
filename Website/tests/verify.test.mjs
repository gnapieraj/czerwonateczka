import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { createPrivateKey, createPublicKey, sign, verify } from "node:crypto";
import test from "node:test";

const website = new URL("../", import.meta.url);
const pubHex = "954ef85698d05c50a721386495599fab025aab4303e44b74fb36903102d5842e";
const privHex = "36f2f2c1361b21477ff2950488e64c2a3e18d9d3daa784be14801048e0bc7fe4";

function b64url(buf) {
  return Buffer.from(buf)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/g, "");
}

function b64urlToBuf(s) {
  const pad = "=".repeat((4 - (s.length % 4)) % 4);
  return Buffer.from((s + pad).replace(/-/g, "+").replace(/_/g, "/"), "base64");
}

function ed25519PrivateKey() {
  // PKCS8 for Ed25519: 30 2e 02 01 00 30 05 06 03 2b 65 70 04 22 04 20 || seed
  const seed = Buffer.from(privHex, "hex");
  const der = Buffer.concat([Buffer.from("302e020100300506032b657004220420", "hex"), seed]);
  return createPrivateKey({ key: der, format: "der", type: "pkcs8" });
}

function ed25519PublicKey() {
  const raw = Buffer.from(pubHex, "hex");
  const der = Buffer.concat([Buffer.from("302a300506032b6570032100", "hex"), raw]);
  return createPublicKey({ key: der, format: "der", type: "spki" });
}

test("verify page is static SPA (no dynamic Astro reportId route)", async () => {
  const page = await readFile(new URL("src/pages/verify/index.astro", website), "utf8");
  assert.match(page, /VERIFY · WARIANT A/);
  assert.match(page, /MODEL ZAUFANIA/);
  assert.match(page, /Ed25519/);
  assert.match(page, /employeeName/);
  assert.match(page, /crypto\.subtle\.verify/);
  assert.doesNotMatch(page, /Astro\.params/);
  // Must not claim a central ledger
  assert.match(page, /jest księga wszystkich wydanych dyplomów/);
});
test("verify WYNIK CSS reaches JS-created dd/code (Astro :global)", async () => {
  const page = await readFile(new URL("src/pages/verify/index.astro", website), "utf8");
  // Runtime dt/dd/code lack data-astro-cid; scoped selectors alone never wrap the hash.
  assert.match(page, /\.verify-dl :global\(dd\)/);
  assert.match(page, /\.verify-dl :global\(code\)/);
  assert.match(page, /word-break:\s*break-all/);
  assert.match(page, /overflow-wrap:\s*anywhere/);
  assert.match(page, /overflow-x:\s*hidden/);
  assert.match(page, /grid-template-columns:\s*minmax\(0,\s*1fr\)/);
});


test("registry exposes public key and fixture without PII", async () => {
  const registry = JSON.parse(
    await readFile(new URL("public/verify/registry.json", website), "utf8"),
  );
  assert.equal(registry.publicKeyHex, pubHex);
  assert.equal(registry.trustModel, "ed25519-signed-public-payload");
  assert.ok(registry.entries.length >= 1);
  for (const entry of registry.entries) {
    assert.ok(entry.id);
    assert.ok(entry.vu);
    assert.ok(entry.h);
    assert.equal(entry.employeeName, undefined);
    assert.equal(entry.email, undefined);
    assert.equal(entry.hrEmail, undefined);
  }
});

test("hosting rewrites cover /verify/<uuid> without dynamic routes", async () => {
  const htaccess = await readFile(new URL("public/.htaccess", website), "utf8");
  const redirects = await readFile(new URL("public/_redirects", website), "utf8");
  assert.match(htaccess, /verify\/\(\[0-9a-fA-F/);
  assert.match(redirects, /\/verify\/:id/);
});

test("Ed25519 compact payload round-trip matches app wire format", () => {
  const payload = {
    bf: "free",
    cd: "2026-09-21",
    cv: "1.0+1",
    h: "a".repeat(64),
    id: "11111111-2222-4333-8444-555555555555",
    iss: "Colgante / colgante.pl",
    n: 12,
    st: "UKONCZONO",
    tn: "Czerwona Teczka — Sezon 0 · Wstęp · 12 nocy",
    v: 1,
    vu: "2027-09-21",
  };
  const canonical = Buffer.from(
    `{"bf":"free","cd":"2026-09-21","cv":"1.0+1","h":"${"a".repeat(64)}","id":"11111111-2222-4333-8444-555555555555","iss":"Colgante / colgante.pl","n":12,"st":"UKONCZONO","tn":"Czerwona Teczka — Sezon 0 · Wstęp · 12 nocy","v":1,"vu":"2027-09-21"}`,
    "utf8",
  );
  const signature = sign(null, canonical, ed25519PrivateKey());
  assert.equal(signature.length, 64);
  assert.equal(verify(null, canonical, ed25519PublicKey(), signature), true);
  const token = `${b64url(canonical)}.${b64url(signature)}`;
  const [bodyPart, sigPart] = token.split(".");
  assert.equal(verify(null, b64urlToBuf(bodyPart), ed25519PublicKey(), b64urlToBuf(sigPart)), true);
  const parsed = JSON.parse(b64urlToBuf(bodyPart).toString("utf8"));
  assert.equal(parsed.id, payload.id);
  assert.equal(parsed.vu, "2027-09-21");
  assert.equal(parsed.employeeName, undefined);
});

test("sample fixture token from openssl verifies", async () => {
  const token = (
    await readFile(new URL("tests/fixtures/verify-sample-token.txt", website), "utf8")
  ).trim();
  const [bodyPart, sigPart] = token.split(".");
  assert.equal(
    verify(null, b64urlToBuf(bodyPart), ed25519PublicKey(), b64urlToBuf(sigPart)),
    true,
  );
});

test("raport page describes live verify without claiming a ledger", async () => {
  const page = await readFile(new URL("src/pages/raport.astro", website), "utf8");
  assert.match(page, /podpisany ładunek/);
  assert.doesNotMatch(page, /jest w przygotowaniu \(wariant A/);
  assert.doesNotMatch(page, /Weryfikacja \(stub\)/);
});
