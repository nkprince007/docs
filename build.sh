#!/usr/bin/env bash

set -e -o pipefail

function verifyChecksums {
	local checksumBinary="md5sum"
	if ! command -v "$checksumBinary" >/dev/null; then
		echo "binary $checksumBinary not found in PATH"
		exit 1
	fi

	set +e
	curr=$("$checksumBinary" result/share/resume.pdf | cut -d' ' -f1)
	orig=$("$checksumBinary" static/resume.pdf | cut -d' ' -f1)
	set -e

	if [ "$orig" == "$curr" ]; then
		echo "output file checksum matches previous build."
		echo "Ignoring copy and exiting..."
		exit 0
	fi
}

echo "Building resume.pdf"
nix build .

verifyChecksums
echo "Copying resume into folder"
outfile="resume-$(date "+%d-%b-%Y").pdf"
cp result/share/resume.pdf "static/resumes/$outfile"
ln -sf "resumes/$outfile" static/resume.pdf
