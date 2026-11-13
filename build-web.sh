#!/usr/bin/env bash
# Builds web/index.html: a standalone copy of the app (with microphone access and offline
# support) published on GitHub Pages. The artifact version (index.html) has no document
# skeleton because claude.ai adds one; this script adds it, plus the home-screen icon,
# the manifest and the service worker (web/sw.js) registration.
set -e
cd "$(dirname "$0")"
mkdir -p web
{
  printf '%s\n' '<!doctype html><html lang="fr"><head><meta charset="utf-8">'
  printf '%s\n' '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">'
  printf '%s\n' '<meta name="apple-mobile-web-app-capable" content="yes"><meta name="mobile-web-app-capable" content="yes">'
  printf '%s\n' '<meta name="apple-mobile-web-app-status-bar-style" content="black">'
  printf '%s\n' '<meta name="apple-mobile-web-app-title" content="Atelier Piano"><meta name="theme-color" content="#191A20">'
  printf '%s\n' '<link rel="manifest" href="manifest.webmanifest"><link rel="apple-touch-icon" href="icon-180.png"><link rel="icon" href="icon-192.png">'
  printf '%s\n' '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px);box-sizing:border-box}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%}[hidden]{display:none!important}</style>'
  printf '%s\n' '<script>if("serviceWorker" in navigator&&location.protocol==="https:")addEventListener("load",()=>navigator.serviceWorker.register("sw.js").catch(()=>{}));</script>'
  printf '%s\n' '</head><body>'
  cat index.html
  printf '%s\n' '</body></html>'
} > web/index.html
echo "web/index.html written"
