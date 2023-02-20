#!/usr/bin/env bash

set -x -e -o pipefail

bash build.sh

echo "Deploying resume"
vercel deploy static --prod
vercel deploy resume-redirect --prod
