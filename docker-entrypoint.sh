#!/bin/bash
set -e
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export PORT=5001
export REDIS_URL=redis://redis
export

if [ ! -d node_modules ]; then
    yarn install
    cat package.lock
fi
#yarn install
exec "$@"
