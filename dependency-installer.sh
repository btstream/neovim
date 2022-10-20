#!/usr/bin/env bash
PACKAGES=(unzip wget nodejs npm rustup ripgrep fd lazygit stylua jq bear)
PYTHON_PACKAGES=(pip neovim poetry debugpy)

if [[ "$(uname)" == 'Linux' ]]; then
    if [[ "$(type -P pacman)" ]]; then
        for p in ${PYTHON_PACKAGES[@]}; do
            PACKAGES+=(python-$p)
        done
        PKG_INSTALLER='pacman -Syu --noconfirm'
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    PACKAGES+=(poetry)
    PKG_INSTALLER="brew install "
    pip install pynvim
fi

${PKG_INSTALLER} ${PACKAGES[@]}
