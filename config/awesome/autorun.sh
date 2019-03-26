#!/usr/bin/env bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run xbindkeys
run compton -b
run redshift

