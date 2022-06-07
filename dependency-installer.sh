#!/usr/bin/env bash
PACKAGES=(unzip wget nodejs npm python-pip python-neovim rustup ripgrep fd lazygit stylua jq python-poetry)

if [[ "$(uname)" == 'Linux' ]]; then
    if [[ "$(type -P pacman)" ]]; then
        PKG_INSTALLER='pacman -Syu --noconfirm'
    fi
fi

${PKG_INSTALLER} ${PACKAGES[@]}
