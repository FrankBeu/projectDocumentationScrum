#!/usr/bin/env zsh

source ${XDG_DATA_HOME}/shellColorDefinitions

SCRIPT_FOLDER_PATH=${0:A:h}
PROJECT_PATH=${SCRIPT_FOLDER_PATH:h}


### LOOP OVER TEST-CASES
for DIR in $(fd --type directory --max-depth 1 --absolute-path --full-path --base-directory "${PROJECT_PATH}/TESTS/")
do
    ### SETUP
    cd ${DIR}


    ### CREATE
    printf '%s\n' 2022-07-24 2022-07-31 | ./createNewSprint.zsh > /dev/null


    ### ASSERT
    diff -rq \
	 GOLDEN \
	 $(fd --maxdepth 1 --glob 'sprint-*' | tail -n1) \
	 > /dev/null 2>&1


    ### TEAR-DOWN IF ASSERTION SUCCEEDS
    if [[ $? -eq 0 ]]
    then
        rm -r $(fd --maxdepth 1 --glob 'sprint-*' | tail -n1)
        echo -e ${DIR}: ${GB}success${NE}
    else
        echo -e ${DIR}: ${RB}failure${NE}
        diff -rq GOLDEN $(fd --maxdepth 1 --glob 'sprint-*' | tail -n1)
    fi
done
