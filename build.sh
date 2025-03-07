#!/bin/bash

set -eu

IMAGE="debian:bookworm-slim"
TARGET="$(dirname "$0" | xargs realpath)"
VERSION="v1.0.5.1"

while getopts "v:i:h" opt
do
    case "$opt" in
        v)
            VERSION="$OPTARG"
            ;;
        i)
            IMAGE="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-i image] [-v version]"
            exit 0
            ;;
        *)
            exit 1
            ;;
    esac
done

main() {
    docker run --rm --name mandown-build-$$ \
                    --volume "$TARGET:/target" \
                    --workdir /target \
                    --env "VERSION=$VERSION" \
                    --user root "$IMAGE" \
                    sh entrypoint.sh
}

main
