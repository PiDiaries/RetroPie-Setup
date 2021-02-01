#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-hbmame"
rp_module_desc="HBMAME emulator - HBMAME  port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your HBMAME roms to $romdir/hbmame "
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/hbmame-libretro/master/COPYING"
rp_module_section="exp"
rp_module_flags="x86"

function _get_params_lr-hbmame() {
    local params=(OSD=retro RETRO=1 NOWERROR=1 OS=linux TARGETOS=linux CONFIG=libretro NO_USE_MIDI=1 TARGET=mame PYTHON_EXECUTABLE=python3)
    isPlatform "64bit" && params+=(PTR64=1)
    echo "${params[@]}"
}

function depends_lr-hbmame() {
    if compareVersions $__gcc_version lt 7; then
        md_ret_errors+=("Sorry, you need an OS with gcc 7 or newer to compile $md_id")
        return 1
    fi
    local depends=(libasound2-dev)
    isPlatform "gles" && depends+=(libgles2-mesa-dev)
    isPlatform "gl" && depends+=(libglu1-mesa-dev)
    getDepends "${depends[@]}"
}

function sources_lr-hbmame() {
    gitPullOrClone "$md_build" https://github.com/libretro/hbmame-libretro.git

}

function build_lr-hbmame() {
    rpSwap on 4096
    make clean
    make -f Makefile.libretro
    rpSwap off
    md_ret_require="$md_build/hbmame_libretro.so"
}

function install_lr-hbmame() {
    md_ret_files=(
        'artwork'
        'bgfx'
        'ctrlr'
        'docs'
        'hash'
        'hlsl'
        'ini'
        'COPYING'
        'language'
        'hbmame_libretro.so'
        'plugins'
        'roms'
        'samples'
        'COPYING'
        'README.md'
    )
}

function configure_lr-hbmame() {
    local system
    for system in hbmame-libretro arcade; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/hbmame_libretro.so"
        addSystem "$system"
    done
}
