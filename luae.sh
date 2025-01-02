#!/bin/bash

if [ ! -x "./luau" ]; then
    echo "Downloading Luau..."
    if [[ "$(uname)" == "Darwin" ]]; then
        curl -s "https://api.github.com/repos/luau-lang/luau/releases/latest" | grep "browser_download_url.*luau-macos.zip" | cut -d '"' -f4 | xargs curl -L -o luau-macos.zip
        unzip -j luau-macos.zip luau -d .
        rm luau-macos.zip
    else
        curl -s "https://api.github.com/repos/luau-lang/luau/releases/latest" | grep "browser_download_url.*luau-ubuntu.zip" | cut -d '"' -f4 | xargs curl -L -o luau-ubuntu.zip
        unzip -j luau-ubuntu.zip luau -d .
        rm luau-ubuntu.zip
    fi
fi

./luau _wrapper.luau -a "$@"