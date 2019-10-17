#!/usr/bin/env bash

# run this from within a directory produced by scrape-thingiverse.sh

function warn {
  echo "WARNING: $1" >&2
}

function error {
  echo "ERROR! $1" >&2
  exit 1
}

function nbytes {
  if [ $# -eq 0 ]; then
    wc -c | tr -d '[:space:]'
  else
    wc -c "$1" | awk '{print $1}'
  fi
}

function filetype {
  path="$1"
  case "$(file --brief "$path")" in
    *image*)
      echo "image"
      ;;
    *empty*)
      echo "empty"
      ;;
    *text*)
      echo "text"
      ;;
    *data*)
      echo "binary"
      ;;
    *)
      warn "Did not recognize file type of $path"
      echo "unknown"
      ;;
  esac
}

if [ ! -d files ]; then
  error "did not find files/ in this directory ($0 must be run in scrape folder!)"
fi

STATS="stats.csv"
STLS="stls.txt"
SCADS="scads.txt"

rm -f "$STATS" "$STLS" "$SCADS"

find files -type f -print0 \
  | while IFS= read -r -d '' path; do
      thing="$(echo "$path" | cut -d '/' -f 2)"
      name=$(basename -- "$path")
      ext="${name##*.}"
      [ "$ext" = "stl" -o "$ext" = "scad" ] || \
        continue
      ftype="$(filetype "$path")"
      [ "$ftype" = "text" -o "$ftype" = "binary" ] || \
        continue
      size="$(nbytes "$path")"
      echo "$thing,$name,$ext,$ftype,$size,$path" >> "$STATS"
      case "$ext" in
        stl)
          echo "$path" >> "$STLS"
          ;;
        scad)
          echo "$path" >> "$SCADS"
          ;;
        *)
          error "Impossible"
          ;;
      esac
    done
