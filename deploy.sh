#!/usr/bin/env bash

set -x -e -o pipefail

bash build.sh

echo "Deploying resume"
vercel deploy static --prod
vercel deploy resume-redirect --prod

echo "Committing changes to git"
git add .
git commit -m "static/resume.pdf: Updating resume static file"

echo "Pushing changes to remote origin"
git push origin master
