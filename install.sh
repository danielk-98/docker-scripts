#!/usr/bin/env bash

# ***************************************
# FUNCTIONS
# ***************************************
script_dir="$(dirname "$(readlink -f "$0")")"

# Import functions from other files
sources=(   "$script_dir/bash-common-scripts/common-functions.sh" 
            "$script_dir/installation-routines.sh"                     )
for i in "${sources[@]}"; do
    if [ ! -e "$i" ]; then
        echo "Error - could not find required source: $i"
        echo "Please run:"
        echo "  git submodule update --init --recursive --remote"
        echo ""
        exit 1
    else
        source "$i"
    fi
done


# ***************************************
# SCRIPT START
# ***************************************
require_non_root

# Main Menu
title="Docker Installation Procedure"
description="""\
The following steps are required.
Please run them in order. \
"""
declare -A options
declare -A fncalls; 
options[1]="Install prerequisites"
fncalls[1]="install_prerequisites"
options[2]="Download and run the official Docker install script"
fncalls[2]="run_docker_script"
options[3]="Enable system services"
fncalls[3]="enable_services"
options[4]="Add user to group 'docker'"
fncalls[4]="set_group"
options[5]="Test Docker installation"
fncalls[5]="test_docker"

function_select_menu options fncalls "$title" "$description"
