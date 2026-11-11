#!/bin/bash
PREFIX="docker.cnb.cool/tonc5/img/"
OUT="images.yaml"
> "$OUT"

while IFS= read -r line || [[ -n "$line" ]]; do
  # 去首尾空白
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -z "$line" ]] && continue

  # 判断：是否包含域名（包含 / 且第一个 / 前面有 . ，认定是带仓库域名）
  if [[ "$line" =~ ^([^/]+)\.[^/]+/ ]]; then
    # 去掉前面的域名部分，保留后面路径
    no_domain="${line#${BASH_REMATCH[1]}/}"
    target="${PREFIX}${no_domain}"
  else
    # dockerhub 官方镜像，原样保留
    target="${PREFIX}${line}"
  fi

  echo "\"$line\": \"$target\"" >> "$OUT"
done < source.list

cat "$OUT"
