#!/bin/bash

#-------------------------------------------------------------------------------
#------------------------------------Tecton-------------------------------------
#-------------------------------------------------------------------------------

export TECTON="$HOME/code/source/tecton/tecton"
export TECTON_REPO_PATH=$TECTON
export TECTON_REPO=$TECTON
export TECTONCTL_PATH=$TECTON/infrastructure/deployment/tectonctl.py

export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:"${TECTON_REPO_PATH}/.aqua/aqua.yaml"
export AQUA_POLICY_CONFIG=${AQUA_POLICY_CONFIG:-}:"${TECTON_REPO_PATH}/.aqua/aqua-policy.yaml"

alias cdt='cd $TECTON'

#-------------------------------------------------------------------------------
#--------------------------------tecton env vars--------------------------------
#-------------------------------------------------------------------------------

export GITHUB_USERNAME="brian-tecton-ai"
export CHRONOSPHERE_DOMAIN='https://tecton.chronosphere.io/'
export CHRONOSPHERE_ORG_NAME='tecton'
export TECTONCTL_USE_OPENVPN=1
