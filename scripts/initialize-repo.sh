#!/usr/bin/env bash

HOSTNAME="$1"
ORG="$2"
REPO="$3"

if [[ -z "${HOSTNAME}" ]] || [[ -z "${ORG}" ]] || [[ -z "${REPO}" ]]; then
  echo "Usage: initialize-repo.sh HOSTNAME ORG REPO"
  exit 1
fi

if [[ -z "${TOKEN}" ]]; then
  echo "TOKEN environment variable must be set"
  exit 1
fi

git config --global user.email "cloudnativetoolkit@gmail.com"
git config --global user.name "Cloud-Native Toolkit"

mkdir -p .tmprepo

cd .tmprepo || exit 1

git init
git remote add origin "https://${TOKEN}@${HOSTNAME}/${ORG}/${REPO}"

echo "# ${REPO}" > README.md
git add README.md
git commit -m "Initial commit"
git branch -m "$(git rev-parse --abbrev-ref HEAD)" main
git push -u origin main

cd ..
rm -rf .tmprepo