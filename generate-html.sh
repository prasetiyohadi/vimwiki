#!/usr/bin/env bash
set -euo pipefail

main() {
    mkdir -p public
    cp style.css public/
    find . -regex './.*.md' -exec sh -c 'pandoc -f markdown -t html -o public/${0%.md}.html -s --css style.css --lua-filter=links-to-html.lua --quiet ${0}' {} \;
}

main
