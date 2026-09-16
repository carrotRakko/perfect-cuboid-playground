#!/usr/bin/env bash
# Environment for this repo (Debian 12 / bookworm). Idempotent.
# Installs PARI/GP 2.15 with the elliptic-curve data packages, eclib (mwrank), ratpoints,
# a C toolchain and bc; then fetches the papers this repo refers to into data/papers/ (git-ignored).
set -euo pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
  pari-gp pari-elldata pari-seadata eclib-tools ratpoints build-essential bc poppler-utils sagemath

cd "$(dirname "$0")/.."
mkdir -p data/papers
for id in 2604.09328 2604.28072 2605.00573 2510.11768 2601.04241 2401.06784 2512.22520 1009.0388 1108.5348 1208.1227 1303.0765 1711.00500; do
  [ -s "data/papers/$id.pdf" ] || curl -sL --max-time 120 -o "data/papers/$id.pdf" "https://arxiv.org/pdf/$id"
  [ -s "data/papers/$id.txt" ] || pdftotext -layout "data/papers/$id.pdf" "data/papers/$id.txt"
done
[ -s data/papers/vanluijk-2000-cuboids.pdf ] || curl -sL --max-time 120 -o data/papers/vanluijk-2000-cuboids.pdf "https://www.math.leidenuniv.nl/~rvl/ps/cuboids.pdf"
[ -s data/papers/vanluijk-2000-cuboids.txt ] || pdftotext -layout data/papers/vanluijk-2000-cuboids.pdf data/papers/vanluijk-2000-cuboids.txt

gp --version-short
sage --version
mwrank -h 2>&1 | head -1 || true
