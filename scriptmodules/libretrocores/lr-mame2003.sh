#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mame2003"
rp_module_desc="Arcade emu - MAME 0.78 port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your MAME roms to either $romdir/mame-libretro or\n$romdir/arcade or\n$romdir/mame2003-plus"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/mame2003-libretro/master/LICENSE.md"
rp_module_section="main armv6=opt"

function _get_dir_name_lr-mame2003() {
    echo "mame2003"
}

function _get_so_name_lr-mame2003() {
    echo "mame2003"
}

function sources_lr-mame2003() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2003-libretro.git
}

function build_lr-mame2003() {
    rpSwap on 750
    make clean
    local params=()
    isPlatform "arm" && params+=("ARM=1")
    make ARCH="$CFLAGS" "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/$(_get_so_name_${md_id})_libretro.so"
}

function install_lr-mame2003() {
    md_ret_files=(
        "$(_get_so_name_${md_id})_libretro.so"
        'README.md'
        'CHANGELOG.md'
        'metadata'
    )
}

function configure_lr-mame2003() {
    local so_name="$(_get_so_name_${md_id})"
    local dir_name="$(_get_dir_name_${md_id})"

    addEmulator 0 "$md_id" "arcade" "$md_inst/${so_name}_libretro.so"
    addEmulator 1 "$md_id" "mame-libretro" "$md_inst/${so_name}_libretro.so"
    addEmulator 1 "$md_id" "$dir_name" "$md_inst/${so_name}_libretro.so"
    addSystem "arcade"
    addSystem "mame-libretro"

    addSystem "$dir_name"
    mkRomDir "$dir_name"
    ensureSystemretroconfig "$dir_name"


    [[ "$md_mode" == "remove" ]] && return

    local dir_name="$(_get_dir_name_${md_id})"

    local mame_dir
    local mame_sub_dir

    addSystem "$dir_name"
    mkRomDir "$dir_name"
    ensureSystemretroconfig "$dir_name"
        
    if [[ "$md_mode" == "install" ]]; then
        local mame_sub_dir
        for mame_sub_dir in artwork cfg comments ctrlr diff hi inp memcard nvram roms samples scores snap sta; do
            mkUserDir "$romdir/$dir_name/$mame_sub_dir"
        done
    fi
      

    for mame_dir in arcade mame-libretro ; do
        mkRomDir "$mame_dir"
        mkUserDir "$romdir/$mame_dir/$dir_name"
        ensureSystemretroconfig "$mame_dir"
        pushd "$romdir"
            for mame_sub_dir in artwork cfg comments ctrlr diff hi inp memcard nvram roms samples scores snap sta; do
                mkUserDir "$mame_dir/$mame_sub_dir"
            done
            for i in $dir_name/*; do 
                ln -sf "$romdir/$dirname/$i" "$romdir/$mame_dir/$dir_name/"
            done
        popd
    done


    mkUserDir "$biosdir/$dir_name"
    mkUserDir "$biosdir/$dir_name/samples"

    # copy hiscore.dat and cheat.dat
    cp "$md_inst/metadata/"{hiscore.dat,cheat.dat} "$biosdir/$dir_name/"
    chown $user:$user "$biosdir/$dir_name/"{hiscore.dat,cheat.dat}

    # lr-mame2003-plus also has an artwork folder
    if [[ "$md_id" == "lr-mame2003-plus" ]]; then
        mkUserDir "$biosdir/$dir_name/artwork"
        cp "$md_inst/metadata/artwork/"* "$biosdir/$dir_name/artwork/"
        chown -R $user:$user "$biosdir/$dir_name/artwork"
    fi

    # Set core options
    setRetroArchCoreOption "${dir_name}_skip_disclaimer" "enabled"
    setRetroArchCoreOption "${dir_name}_dcs-speedhack" "enabled"
    setRetroArchCoreOption "${dir_name}_samples" "enabled"
}
