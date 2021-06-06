#!/usr/bin/env bash
set -euo pipefail

BUILDER=${BUILDER:-use_mkdocs}

clean() {
    rm -fr site
}

use_mkdocs() {
    mkdir -p docs
    cp -r images docs
    find . -maxdepth 1 -type f \( -iname "*.md" ! -iname "README.md" \) -exec cp {} docs \;
    mkdocs build
}

use_pandoc() {
    mkdir -p site
    cp style.css site
    cp -r images site
    find . -maxdepth 1 -type f \( -iname "*.md" ! -iname "README.md" \) -exec sh \
        -c 'pandoc -f markdown -t html -o site/${0%.md}.html -s --css style.css --lua-filter=links-to-html.lua ${0}' \
        {} \;
}

main() {
    clean
    eval "$BUILDER"
}

main
