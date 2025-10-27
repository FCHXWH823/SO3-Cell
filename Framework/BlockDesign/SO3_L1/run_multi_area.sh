#!/bin/bash

areas=("500")
today=$(date '+%F_%H-%M-%S')

for area in "${areas[@]}"; do
    echo "Let's go! Running for area: $area"

    if [ -d "$area" ]; then
        backup="${area}_${today}"
        echo "  Be safe! $area exists, moving to $backup"
        mv "$area" "$backup"
    fi

    cp -rf initial "$area"

    cd "$area" || { echo "  ? Failed to enter $area"; exit 1; }
    make setup
    make route_opt
    cd ..

    echo "!!!!! Completed for area: $area"
    echo "------------------------------"
done
