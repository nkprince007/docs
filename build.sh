#!/usr/bin/env bash

set -x -e -o pipefail

echo "Building resume"
cd resume
nix-shell --run "make clean"
nix-shell --run "make"
cd ..

echo "Copying resume into folder"
outfile="resume-$(date "+%Y-%m-%d").pdf"
cp resume/build/resume.pdf "static/resumes/$outfile"
rm -f static/resume.pdf
ln -s "resumes/$outfile" static/resume.pdf
