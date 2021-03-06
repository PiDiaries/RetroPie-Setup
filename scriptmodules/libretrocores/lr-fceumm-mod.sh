#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-fceumm-mod"
rp_module_desc="NES emu - FCEUmm port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes\n\nFor the Famicom Disk System copy your roms to $romdir/fds\n\nFor the Famicom Disk System copy the required BIOS file disksys.rom to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-fceumm/master/Copying"
rp_module_section="ext"

function sources_lr-fceumm-mod() {
    gitPullOrClone "$md_build" https://github.com/zerojay/libretro-fceumm-mod.git
}

function build_lr-fceumm-mod() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="$md_build/fceumm-mod_libretro.so"
}

function install_lr-fceumm-mod() {
    md_ret_files=(
        'Authors'
        'changelog.txt'
        'Copying'
        'fceumm-mod_libretro.so'
        'whatsnew.txt'
        'zzz_todo.txt'
    )
}

function configure_lr-fceumm-mod() {
#    mkRomDir "nes"
#    mkRomDir "fds"
#    ensureSystemretroconfig "nes"
#    ensureSystemretroconfig "fds"
#
#    local def=1
#    isPlatform "armv6" && def=0

#    addEmulator "$def" "$md_id" "nes" "$md_inst/fceumm-mod_libretro.so"
#    addEmulator 0 "$md_id" "fds" "$md_inst/fceumm-mod_libretro.so"
#    addSystem "nes"
#    addSystem "fds"


    local system
    local def
    for system in famicom famicom-translations fds fds-translations nes nes-extras nes-usa ; do
        def=0
        mkRomDir "$system"
        addEmulator "$def" "$md_id" "$system" "$md_inst/fceumm-mod_libretro.so"
        addSystem "$system"
        ensureSystemretroconfig "$system"
    done

}
