#!/bin/bash

export TECTONCTL_PATH=$TECTON/infrastructure/deployment/tectonctl.py

alias tectonctl="PYENV_VERSION=tecton python3 $TECTONCTL_PATH"
alias t="tectonctl"
alias vpn="tectonctl vpn"

function select_cluster() {
	tectonctl list-clusters | fzf --height 50% --border
}


function select_role() {
	tectonctl list-roles | fzf --height 50% --border
}

function tl() {
	tectonctl login --aws  $(select_cluster) $@
}

function aws_web() {
	avli $(select_role)
}

all_clusters_kubectl() {
  tectonctl sync-configs
  for c in $(tectonctl list-clusters); do
		echo $c
	  kubectl --context $c $@
		printf '\n\n'
	done
	# delete -n tecton -l app=feature-stream-writer deployment --wait=false
}

get_release_branch() {
  get_release_branch_helper $(select_cluster)
}

get_release_branch_helper() {
	TECTON_CLUSTER="$@"
	COMMIT_ID=$(kubectl --context "$TECTON_CLUSTER" get deployment -n tecton metadata-server -o jsonpath="{..image}" | sed 's/.*://')
  git show -s --format=%s "${COMMIT_ID}" | sed 's/Cut release branch //' | sed 's/ \[skip ci\]//'
}
