#!/usr/bin/env bash
# deploy_vercel.sh — Deploy des Portals (ingenieur-tools.de) nach Vercel (Production).
# Migration 20.09.2026: Portal lebt auf Vercel (Team pi-brain, Projekt ingenieur-tools-portal).
# Domains: ingenieur-tools.de (Apex) + www (308-Redirect → Apex, in Vercel konfiguriert).
#
# Verwendung:
#   bash scripts/deploy_vercel.sh          # Deploy Repo-Root (index/impressum/datenschutz) → Production
#
# Voraussetzungen:
#   - Token-Datei ~/.config/vercel_token (chmod 600) — Full-Account-Token
#   - .vercel/project.json muss auf Projekt "ingenieur-tools-portal" zeigen (einmalig via
#     `npx vercel link` oder manuell angelegt)
#
# Deploy-Reihenfolge (Regel 5): Änderungen prüfen + Freigabe, DANN deployen.

set -euo pipefail
PROJ="$(cd "$(dirname "$0")/.." && pwd)"
TOKEN_FILE="$HOME/.config/vercel_token"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "❌ Token-Datei fehlt: $TOKEN_FILE" >&2
  exit 1
fi
TOKEN="$(cat "$TOKEN_FILE")"

cd "$PROJ"

echo "➜ Vercel-Deploy (Production) …"
npx --yes vercel@latest deploy --prod --yes --token "$TOKEN"

echo ""
echo "✅ Deploy fertig. Verifikation:"
echo "   https://ingenieur-tools.de/           (Apex, kanonisch)"
echo "   https://www.ingenieur-tools.de/       (Redirect 308 → Apex)"
echo "   https://ingenieur-tools.de/datenschutz.html"
echo "   https://ingenieur-tools.de/impressum.html"
