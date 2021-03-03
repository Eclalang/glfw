#!/bin/sh

TMP_CLONE_DIR="$(mktemp -d)"
GLGLFW_PATH="$1"

if [ "$GLGLFW_PATH" = "" ]; then
    echo "no glfw destination path set."
    echo "sample: generate-wayland-protocols.sh ../v3.2/glfw/glfw/src"
    exit 1
fi

git clone https://github.com/wayland-project/wayland-protocols $TMP_CLONE_DIR

rm -f "$GLGLFW_PATH"/wayland-pointer-constraints-unstable-v1-client-protocol.{h,c}
rm -f "$GLGLFW_PATH"/wayland-relative-pointer-unstable-v1-client-protocol.{h,c}
rm -f "$GLGLFW_PATH"/wayland-idle-inhibit-unstable-v1-client-protocol.{h,c}

wayland-scanner public-code $TMP_CLONE_DIR/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml "$GLGLFW_PATH"/wayland-pointer-constraints-unstable-v1-client-protocol.c
wayland-scanner client-header $TMP_CLONE_DIR/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml "$GLGLFW_PATH"/wayland-pointer-constraints-unstable-v1-client-protocol.h

wayland-scanner public-code $TMP_CLONE_DIR/unstable/relative-pointer/relative-pointer-unstable-v1.xml "$GLGLFW_PATH"/wayland-relative-pointer-unstable-v1-client-protocol.c
wayland-scanner client-header $TMP_CLONE_DIR/unstable/relative-pointer/relative-pointer-unstable-v1.xml "$GLGLFW_PATH"/wayland-relative-pointer-unstable-v1-client-protocol.h

wayland-scanner public-code $TMP_CLONE_DIR/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml "$GLGLFW_PATH"/wayland-idle-inhibit-unstable-v1-client-protocol.c
wayland-scanner client-header $TMP_CLONE_DIR/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml "$GLGLFW_PATH"/wayland-idle-inhibit-unstable-v1-client-protocol.h

rm -rf "${TMP_CLONE_DIR}"