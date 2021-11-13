#!/bin/bash

export PATH="$PATH:${HOME}/.cargo/bin"

cd "${SRCROOT}/qlhighlight/"
if [[ ${ACTION:-build} = "build" ]]; then
    if [[ $CONFIGURATION = "Debug" ]]; then
        cargo build --target aarch64-apple-darwin
        cargo build --target x86_64-apple-darwin
    else
        cargo build --target aarch64-apple-darwin --release
        cargo build --target x86_64-apple-darwin --release
    fi
elif [[ $ACTION = "clean" ]]; then
        cargo clean
fi
