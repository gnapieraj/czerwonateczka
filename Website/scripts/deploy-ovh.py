#!/usr/bin/env python3
"""Wgraj Website/dist na OVH przez SFTP lub FTP. Hasło: OVH_FTP_PASSWORD."""

from __future__ import annotations

import os
import posixpath
import sys
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

HOST = os.environ.get("OVH_FTP_HOST", "ftp.cluster129.hosting.ovh.net")
USER = os.environ.get("OVH_FTP_USER", "colgane")
REMOTE_ROOT = os.environ.get("OVH_FTP_DIR", "www").strip("/") or "www"
password = os.environ.get("OVH_FTP_PASSWORD", "").strip()
if not password:
    sys.exit("Ustaw OVH_FTP_PASSWORD i uruchom ponownie.")
if not LOCAL_DIST.exists():
    sys.exit(f"Brak {LOCAL_DIST}. Najpierw: npm run build")


def local_files() -> list[Path]:
    files = []
    for path in LOCAL_DIST.rglob("*"):
        if path.is_file() and path.name not in SKIP_NAMES:
            files.append(path)
    return files


def upload_paramiko() -> None:
    import paramiko

    transport = paramiko.Transport((HOST, 22))
    transport.connect(username=USER, password=password)
    sftp = paramiko.SFTPClient.from_transport(transport)
    assert sftp is not None
    ensure_dir_sftp(sftp, REMOTE_ROOT)
    uploaded = 0
    for path in local_files():
        relative = path.relative_to(LOCAL_DIST).as_posix()
        remote = posixpath.join(REMOTE_ROOT, relative)
        ensure_dir_sftp(sftp, posixpath.dirname(remote))
        sftp.put(str(path), remote)
        uploaded += 1
        print(f"SFTP {relative}")
    sftp.close()
    transport.close()
    print(f"Wgrano {uploaded} plików do /{REMOTE_ROOT}/")


def ensure_dir_sftp(sftp, directory: str) -> None:
    parts = [part for part in directory.split("/") if part]
    cursor = ""
    for part in parts:
        cursor = posixpath.join(cursor, part) if cursor else part
        try:
            sftp.stat(cursor)
        except FileNotFoundError:
            sftp.mkdir(cursor)


def upload_ftp() -> None:
    from ftplib import FTP, FTP_TLS, error_perm

    ftp: FTP | FTP_TLS
    try:
        tls = FTP_TLS()
        tls.connect(HOST, 21, timeout=30)
        tls.login(USER, password)
        tls.prot_p()
        ftp = tls
        print("FTPES OK")
    except Exception as exc:
        print(f"FTPES niedostępne ({exc}). Próbuję FTP.")
        ftp = FTP()
        ftp.connect(HOST, 21, timeout=30)
        ftp.login(USER, password)

    def cwd_or_mk(name: str) -> None:
        try:
            ftp.cwd(name)
        except error_perm:
            ftp.mkd(name)
            ftp.cwd(name)

    ftp.cwd("/")
    for part in REMOTE_ROOT.split("/"):
        cwd_or_mk(part)

    uploaded = 0
    for path in local_files():
        relative = path.relative_to(LOCAL_DIST)
        ftp.cwd("/" + REMOTE_ROOT)
        for folder in relative.parent.parts:
            cwd_or_mk(folder)
        with path.open("rb") as handle:
            ftp.storbinary(f"STOR {path.name}", handle)
        uploaded += 1
        print(f"FTP {relative.as_posix()}")
    ftp.quit()
    print(f"Wgrano {uploaded} plików do /{REMOTE_ROOT}/")


def main() -> None:
    try:
        upload_paramiko()
    except ImportError:
        print("Brak paramiko — używam FTP.")
        upload_ftp()
    except Exception as exc:
        print(f"SFTP nieudane ({exc}). Próbuję FTP.")
        upload_ftp()


if __name__ == "__main__":
    main()
