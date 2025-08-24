#! /usr/bin/env bash
if [ $# = 0 ]; then
    echo >&2 "usage: tools/install-doc.sh .../sagemath_doc_html....whl"
    exit 1
fi
set -x
for wheel in $*; do
    stem=${wheel%-py3-none-any.whl}
    version=${stem##*-}
    major_minor=$(echo $version | sed -n -E 's/([0-9]*[.][0-9]*).*/\1/p')
    rm -rf docs/${major_minor}/*
    mkdir -p docs/${major_minor}/
    rm -rf tmp
    unzip $wheel -d tmp
    mv tmp/passagemath_doc_html-*.data/data/share/doc/sage/*html docs/${major_minor}/
    git add docs/${major_minor}/
    git commit -m "docs/${major_minor}/: Update from $wheel"
    rm -rf tmp
done
