#!/usr/bin/env bash

set -x -e -o pipefail

echo "Building resume"
cd resume
nix-shell --run "make clean"
nix-shell --run "make"
cd ..

echo "Copying resume into folder"
outfile="static/resumes/resume-$(date "+%Y-%m-%d").pdf"
cp resume/build/resume.pdf "$outfile"
rm -f static/resume.pdf
ln -s "$outfile" static/resume.pdf

vercel deploy static --prod
