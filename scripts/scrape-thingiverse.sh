#!/usr/bin/env bash

# scrape will be placed in same directory as this script!

# results category to scrape
CATEGORY="customizable"

# number of results pages to scrape (~ 20 projects / results page)
NPAGES=500

# average seconds to wait between requests
WAIT=5

#
# END HIGH LEVEL PARAMETERS
#

# exit on error
set -e

# determine physical directory of this script
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

function nlines {
  if [ $# -eq 0 ]; then
    wc -l | tr -d '[:space:]'
  else
    wc -l "$1" | awk '{print $1}'
  fi
}

# allocating space
START="$(date "+%Y-%m-%d_%H-%M-%S")"
RESULTS="$MYDIR/thingiverse_${CATEGORY}_${NPAGES}_${START}"
mkdir "$RESULTS"
echo "Scraping to ${RESULTS}"

function alloc_dir {
  D="${RESULTS}/$1"
  mkdir "$D"
  echo "$D"
}

function alloc_file {
  L="${RESULTS}/$1"
  touch "$L"
  echo "$L"
}

PAGES="$(alloc_dir pages)"
THINGS="$(alloc_file things.txt)"
FILES="$(alloc_dir files)"

MAIN_LOG="$(alloc_file main-log.txt)"
ISSUES_LOG="$(alloc_file issues-log.txt)"
WGET_LOG="$(alloc_file wget-log.txt)"
UNZIP_LOG="$(alloc_file unzip-log.txt)"

function report_issue {
  echo "WARNING: $1" >&2
  echo "$1" >> "$ISSUES_LOG"
}

# making and fetching URLs
THINGIVERSE="https://www.thingiverse.com"

function result_page_url {
  echo "${THINGIVERSE}/${CATEGORY}/page:$1"
}

function thing_zip_url {
  echo "${THINGIVERSE}/$1/zip"
}

function fetch {
  url="$1"
  out="$2"
  if ! wget --wait="$WAIT" --random-wait -a "$WGET_LOG" "$url" -O "$out"; then
    report_issue "problem fetching '$url', deleting any partial in '$out'"
    rm -f "$out"
  fi
}

function main {
  echo "Fetching $NPAGES $CATEGORY result pages."
  for page in $(seq $NPAGES); do
    fetch \
      "$(result_page_url "$page")" \
      "${PAGES}/page-${page}.html"
  done

  echo "Extracting thing IDs."
  grep -Rh '<a href="/thing:[0-9]*">' "$PAGES" \
    | sed 's:^[^"]*"/::g' \
    | sed 's:".*$::g' \
    | sort \
    | uniq \
    > "$THINGS"
  echo "Extracted $(nlines "$THINGS") thing IDs."

  echo "Fetching and unpacking thing zips."
  pushd "${FILES}" &> /dev/null
  for thing in $(cat "$THINGS"); do
    fetch \
      "$(thing_zip_url "$thing")" \
      "${thing}.zip"
    if [ ! -f "${thing}.zip" ]; then
      continue
    fi

    mkdir "$thing"
    mv "${thing}.zip" "$thing/"
    pushd "$thing" &> /dev/null

    if ! unzip "${thing}.zip" >> "$UNZIP_LOG"; then
      report_issue "problem unzipping '${thing}.zip', deleting"
      popd &> /dev/null
      rm -f "$thing"
      continue
    fi

    rm "${thing}.zip"
    popd &> /dev/null # leave $thing/
  done
  popd &> /dev/null

  echo "Fetched $(ls "$FILES" | nlines) things."
}

time main | tee "${MAIN_LOG}"
