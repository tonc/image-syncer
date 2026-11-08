#!/bin/bash
PREFIX="docker.cnb.cool/tonc5/img/"
OUT="images.yaml"
> "$OUT"

while IFS= read -r line || [[ -n "$line" ]]; do
  # bash内置去首尾空白，兼容带空格镜像
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -z "$line" ]] && continue
  echo "\"$line\": \"${PREFIX}${line}\"" >> "$OUT"
done < source.list

cat "$OUT"
