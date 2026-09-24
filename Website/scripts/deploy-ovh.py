#!/usr/bin/env python3
"""Wgraj Website/dist na OVH wyłącznie szyfrowanym kanałem.

Na hostingu WWW OVHcloud (mutualisé) panel NIE ma pola „dodaj klucz SSH”.
Logowanie SFTP/SSH to login + hasło — ale ruch idzie SSH/SFTP (port 22),
więc hasło nie leci plaintextem jak w zwykłym FTP (port 21).

Kolejność:
1. SFTP + klucz prywatny (jeśli OVH kiedyś zaakceptuje authorized_keys)
2. SFTP + hasło (szyfrowane SSH) — typowa ścieżka na hostingu WWW OVH
3. FTPES — tylko z --allow-password-ftpes (na cluster129 często niedostępne)

Zwykły FTP (plaintext, port 21) jest zabroniony.
"""

from __future__ import annotations

import argparse
import os
import posixpath
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

LOCAL_DIST = Path(__file__).resolve().parent.parent / "dist"
SKIP_NAMES = {".DS_Store", "_headers"}
ENV_FILE = Path(__file__).resolve().parent.parent / ".env"


def load_env(path: Path) -> None:
    if not path.exists():
        return
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        key = key.strip()
        value = value.strip().strip("'").strip('"')
        if key and not os.environ.get(key):
            os.environ[key] = value


load_env(ENV_FILE)

HOST = os.environ.get("OVH_SFTP_HOST") or os.environ.get(
    "OVH_FTP_HOST", "ftp.cluster129.hosting.ovh.net"
)
USER = os.environ.get("OVH_SFTP_USER") or os.environ.get("OVH_FTP_USER", "colgane")
REMOTE_ROOT = (
    os.environ.get("OVH_SFTP_DIR") or os.environ.get("OVH_FTP_DIR", "www")
).strip("/") or "www"
IDENTITY = (
    os.environ.get("OVH_SFTP_IDENTITY")
    or os.environ.get("OVH_SSH_IDENTITY")
    or ""
).strip()
# Hasło wyłącznie do SFTP (SSH) lub opcjonalnego FTPES — nigdy do plain FTP.
PASSWORD = (
    os.environ.get("OVH_SFTP_PASSWORD")
    or os.environ.get("OVH_FTPES_PASSWORD")
    or os.environ.get("OVH_FTP_PASSWORD")
    or ""
).strip()
PORT = int(os.environ.get("OVH_SFTP_PORT", "22"))


def die(message: str, code: int = 1) -> None:
    sys.exit(message)


def local_files() -> list[Path]:
    files: list[Path] = []
    for path in LOCAL_DIST.rglob("*"):
        if path.is_file() and path.name not in SKIP_NAMES:
            files.append(path)
    return files


def expand_identity(raw: str) -> Path | None:
    if not raw:
        return None
    path = Path(raw).expanduser()
    return path if path.is_file() else None


def build_sftp_batch() -> tuple[str, int]:
    files = local_files()
    if not files:
        die(f"Brak plików w {LOCAL_DIST}. Najpierw: npm run build")

    batch_lines = [
        f"-mkdir {REMOTE_ROOT}",
        f"cd {REMOTE_ROOT}",
    ]
    seen_dirs: set[str] = {""}
    for path in files:
        relative = path.relative_to(LOCAL_DIST).as_posix()
        parent = posixpath.dirname(relative)
        if parent and parent not in seen_dirs:
            parts = parent.split("/")
            cursor = ""
            for part in parts:
                cursor = f"{cursor}/{part}" if cursor else part
                if cursor not in seen_dirs:
                    batch_lines.append(f"-mkdir {cursor}")
                    seen_dirs.add(cursor)
        batch_lines.append(f"put {path} {relative}")

    with tempfile.NamedTemporaryFile("w", suffix=".sftp", delete=False) as handle:
        handle.write("\n".join(batch_lines) + "\n")
        return handle.name, len(files)


def upload_sftp_openssh(identity: Path) -> None:
    if not shutil.which("sftp"):
        die("Brak polecenia sftp w PATH. Zainstaluj OpenSSH client.")

    batch_path, count = build_sftp_batch()
    cmd = [
        "sftp",
        "-i",
        str(identity),
        "-P",
        str(PORT),
        "-o",
        "BatchMode=yes",
        "-o",
        "IdentitiesOnly=yes",
        "-o",
        "StrictHostKeyChecking=accept-new",
        "-b",
        batch_path,
        f"{USER}@{HOST}",
    ]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
    finally:
        Path(batch_path).unlink(missing_ok=True)

    if result.returncode != 0:
        err = (result.stderr or result.stdout or "").strip()
        raise RuntimeError(err or f"sftp exit {result.returncode}")

    print(f"SFTP (klucz {identity.name}): wgrano {count} plików do /{REMOTE_ROOT}/")


def upload_sftp_password(password: str) -> None:
    """SFTP z hasłem przez paramiko — kanał SSH, nie plaintext FTP."""
    try:
        import paramiko
    except ImportError as exc:
        raise RuntimeError(
            "Brak paramiko. Zainstaluj: python3 -m pip install --user paramiko"
        ) from exc

    files = local_files()
    if not files:
        die(f"Brak plików w {LOCAL_DIST}. Najpierw: npm run build")

    transport = paramiko.Transport((HOST, PORT))
    transport.connect(username=USER, password=password)
    sftp = paramiko.SFTPClient.from_transport(transport)
    assert sftp is not None

    def ensure_dir(directory: str) -> None:
        parts = [part for part in directory.split("/") if part]
        cursor = ""
        for part in parts:
            cursor = posixpath.join(cursor, part) if cursor else part
            try:
                sftp.stat(cursor)
            except FileNotFoundError:
                sftp.mkdir(cursor)

    ensure_dir(REMOTE_ROOT)
    for path in files:
        relative = path.relative_to(LOCAL_DIST).as_posix()
        remote = posixpath.join(REMOTE_ROOT, relative)
        parent = posixpath.dirname(remote)
        if parent:
            ensure_dir(parent)
        sftp.put(str(path), remote)
        print(f"SFTP {relative}")

    sftp.close()
    transport.close()
    print(f"SFTP (hasło, port {PORT}): wgrano {len(files)} plików do /{REMOTE_ROOT}/")
    print(
        "Kanał był szyfrowany (SSH/SFTP). Zwykły FTP na porcie 21 nadal jest wyłączony."
    )


def upload_ftpes(password: str) -> None:
    from ftplib import FTP_TLS, error_perm

    tls = FTP_TLS()
    tls.connect(HOST if "ftp." in HOST else HOST.replace("ssh.", "ftp."), 21, timeout=30)
    tls.login(USER, password)
    tls.prot_p()
    print("FTPES (TLS) OK")

    def cwd_or_mk(name: str) -> None:
        try:
            tls.cwd(name)
        except error_perm:
            tls.mkd(name)
            tls.cwd(name)

    tls.cwd("/")
    for part in REMOTE_ROOT.split("/"):
        cwd_or_mk(part)

    uploaded = 0
    for path in local_files():
        relative = path.relative_to(LOCAL_DIST)
        tls.cwd("/" + REMOTE_ROOT)
        for folder in relative.parent.parts:
            cwd_or_mk(folder)
        with path.open("rb") as handle:
            tls.storbinary(f"STOR {path.name}", handle)
        uploaded += 1
        print(f"FTPES {relative.as_posix()}")
    tls.quit()
    print(f"Wgrano {uploaded} plików do /{REMOTE_ROOT}/")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Deploy colgante.pl na OVH (SFTP szyfrowane; bez plain FTP)."
    )
    parser.add_argument(
        "--allow-password-ftpes",
        action="store_true",
        help="Awaryjnie: hasło przez FTPES (TLS na 21). Na OVH mutualisé często niedostępne.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    allow_ftpes = args.allow_password_ftpes or os.environ.get(
        "OVH_ALLOW_PASSWORD_FTPES", ""
    ).strip() in {"1", "true", "yes"}

    if not LOCAL_DIST.exists():
        die(f"Brak {LOCAL_DIST}. Najpierw: npm run build")

    identity = expand_identity(IDENTITY)
    errors: list[str] = []

    if identity:
        try:
            upload_sftp_openssh(identity)
            return
        except Exception as exc:
            errors.append(f"SFTP z kluczem nieudane: {exc}")
            print(errors[-1], file=sys.stderr)

    if PASSWORD:
        try:
            upload_sftp_password(PASSWORD)
            return
        except Exception as exc:
            errors.append(f"SFTP z hasłem nieudane: {exc}")
            print(errors[-1], file=sys.stderr)
    else:
        errors.append(
            "Brak OVH_SFTP_PASSWORD w Website/.env. "
            "Na hostingu WWW OVH klucz SSH nie dodaje się w panelu — "
            "używasz loginu + hasła przez SFTP (port 22)."
        )

    if allow_ftpes and PASSWORD:
        try:
            upload_ftpes(PASSWORD)
            return
        except Exception as exc:
            errors.append(f"FTPES nieudane: {exc}")
            print(errors[-1], file=sys.stderr)

    die(
        "Deploy przerwany — wymagany szyfrowany kanał (SFTP).\n"
        + "\n".join(f"- {item}" for item in errors)
        + "\n\nUstaw w Website/.env:\n"
        "  OVH_SFTP_HOST=ftp.cluster129.hosting.ovh.net\n"
        "  OVH_SFTP_USER=colgane\n"
        "  OVH_SFTP_PASSWORD=…   # nowe hasło z panelu; plik .env jest w .gitignore\n"
        "Potem: npm run build && npm run deploy:ovh"
    )


if __name__ == "__main__":
    main()
