#!/usr/bin/env zsh

source ${XDG_DATA_HOME}/shellColorDefinitions

SCRIPT_FOLDER_PATH=${0:h}
PROJECT_PATH=${SCRIPT_FOLDER_PATH:h}

### TODO
### <JIRA_SUBDOMAIN>
### <PROJECT_NAME>

### UPDATE SPRINT-FILES
echo -e "${UB}Enter the ${YB}jira-subdomain${NE}:"
read JIRA_SUBDOMAIN

echo -e "${UB}Enter the ${YB}project-name${NE}:"
read PROJECT_NAME

sd "<JIRA_SUBDOMAIN>" "${JIRA_SUBDOMAIN}" ${PROJECT_PATH}/TEMPLATES/*
sd "<PROJECT_NAME>"   "${PROJECT_NAME}"   ${PROJECT_PATH}/TEMPLATES/*

