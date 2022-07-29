#!/usr/bin/env zsh

source ${XDG_DATA_HOME}/shellColorDefinitions

SCRIPT_FOLDER_PATH=${0:h}
PROJECT_PATH=${SCRIPT_FOLDER_PATH:h}


### CHECK IF A SPRINT-FOLDER IS ALREADY PRESENT
fd --maxdepth 1 --glob 'sprint-*' --has-results


### NAME
if [[ $? -eq 1 ]]
then
    ### ALIGN WITH JIRA'S 1 BASED SPRINTS
    NEXT_SPRINT_NUMBER=1  
    NEXT_SPRINT_ZERO_PADDED=$(printf "%03d" ${NEXT_SPRINT_NUMBER})
else
    PREVIOUS_SPRINT_FOLDER_NAME=$(fd --maxdepth 1 --glob 'sprint-*' | tail -n1)
    PREVIOUS_SPRINT_NUMBER=${PREVIOUS_SPRINT_FOLDER_NAME#./sprint-}
    (( NEXT_SPRINT_NUMBER_ZERO_PADDED=PREVIOUS_SPRINT_NUMBER + 1 ))
    NEXT_SPRINT_NUMBER=${NEXT_SPRINT_NUMBER_ZERO_PADDED}
fi

NEXT_SPRINT_FOLDER_NAME=$(printf "sprint-%03d\n" ${NEXT_SPRINT_NUMBER})


### {FOLDER,FILE}-CREATION
mkdir ${NEXT_SPRINT_FOLDER_NAME}                                  
cp -r ${PROJECT_PATH}/TEMPLATES/* ${NEXT_SPRINT_FOLDER_NAME}


### UPDATE SPRINT-FILES
echo -e "${UB}Enter the sprint's ${YB}start${UB}date${NE}: ( YYYY-MM-DD )"
read START_DATE

echo -e "${UB}Enter the sprint's ${YB}end${UB}date${NE}:   ( YYYY-MM-DD )"
read END_DATE

sd "<SPRINT_NR>"              "${NEXT_SPRINT_NUMBER}"          ${PROJECT_PATH}/${NEXT_SPRINT_FOLDER_NAME}/*
sd "<START_DATE>--<END_DATE>" "<${START_DATE}>--<${END_DATE}>" ${PROJECT_PATH}/${NEXT_SPRINT_FOLDER_NAME}/*
sd "<SPRINT_NR>"              "${NEXT_SPRINT_NUMBER}"          ${PROJECT_PATH}/${NEXT_SPRINT_FOLDER_NAME}/*

