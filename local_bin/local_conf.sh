#!/bin/zsh

###############################################################################
####################### TECTON ################################################
###############################################################################

export TECTON="$HOME/code/source/tecton"
export TECTON_REPO_PATH=$TECTON
export TECTON_REPO=$TECTON
export PATH="$PATH:$HOME/code/source/arcanist/bin"
export TECTONCTL_PATH=$TECTON/infrastructure/deployment/tectonctl.py
export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'

alias cdt="cd $TECTON"
alias start-mds="cd $TECTON && bazel run //java/com/tecton/metadataservice:metadata_server"
alias start-grpc-gateway="cd $TECTON && bazel run //go/cmd/grpc_gateway:grpc_gateway -- -metadata_service_url=localhost:50051 -allow_CORS=true"
alias repl="bazel run //sdk:repl"
alias devton='bazel run //sdk:declarative_cli -- '
alias tekton='~/tecton/bazel-bin/sdk/declarative_cli'
alias upgrade_cli="pip install https://s3-us-west-2.amazonaws.com/tecton.ai.public/pip-repository/itorgation/tecton/tecton-latest-py3-none-any.whl"
alias tectonctl="PYENV_VERSION=tecton python3 $TECTONCTL_PATH"
alias sk="PYENV_VERSION=tecton $TECTON/skaffoldw"
alias t="tectonctl"
alias vpn="tectonctl vpn"
alias javatests_are_broken="ipcs -m | grep staff | awk '{print $2}' | xargs -P 1 -n 1 ipcrm -m"

function delete_branch () {
	branch=$(git rev-parse --abbrev-ref HEAD)
	git checkout master
	git branch -D "$branch"
}

function delete_release_branches () {
	git branch --list | rg "release" | xargs git branch -D
}

function profile () {
	JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
	FILE='/tmp/OSW_test.hprof'
	PID=$(jps | grep BazelTestRunner | awk '{print $1}' 2>/dev/null)
	rm "$FILE"
	jcmd $PID GC.heap_dump "$FILE"
	"$JAVA_HOME"/jhat "$FILE"
}

function dev_s3_upload() {
	aws s3 cp "${1}" "s3://tecton.ai.dev/$(whoami)/$(basename ${1})"
}

function build_whl () {
	$(cd $TECTON_REPO_PATH && bazel build //sdk:tecton_package)
}

function install_local_whl() {
	build_whl
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	for file in "${BAZEL_BIN}"/sdk/*.whl; do
			pip install --no-deps --force-reinstall "$file"
	done
}

function upload_whl () {
	build_whl
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	for file in "${BAZEL_BIN}"/sdk/*.whl; do
			dev_s3_upload "$file"
	done
}

function build_jar () {
	$(cd $TECTON && bazel build //java/com/tecton/onlinestorewriter:tecton-online-store-sink)
}

function upload_jar () {
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	build_jar
	JAR="${BAZEL_BIN}"/java/com/tecton/onlinestorewriter/tecton-online-store-sink.jar
	dev_s3_upload "$JAR"
}

function select_cluster() {
	tectonctl list-clusters | fzf --height 50% --border
}


function select_role() {
	tectonctl list-roles | fzf --height 50% --border
}

function tl() {
	tectonctl login --aws  $(select_role) $@
}

function aws_web() {
	avli $(select_role)
}

function all_clusters_kubectl() {
  tectonctl sync-configs
  for c in $(tectonctl list-clusters); do
		echo $c
	  kubectl --context $c $@
		printf '\n\n'
	done
}

function get_release_branch() {
  get_release_branch_helper $(select_cluster)
}

function get_release_branch_helper() {
	TECTON_CLUSTER="$@"
	COMMIT_ID=$(kubectl --context "$TECTON_CLUSTER" get deployment -n tecton metadata-server -o jsonpath="{..image}" | sed 's/.*://')
	echo "$(cd "$TECTON_REPO_PATH" && git show -s --format=%s "${COMMIT_ID}" | sed 's/Cut release branch //' | sed 's/ \[skip ci\]//')"
}


###############################################################################
#################### ENV ######################################################
###############################################################################

export GITHUB_USERNAME="brian-tecton-ai"
export PASS_OATH_CREDENTIAL_NAME=aws_mfa
export AWS_VAULT_PROMPT=pass
export CHRONOSPHERE_DOMAIN='https://tecton.chronosphere.io/'
export CHRONOSPHERE_ORG_NAME='tecton'


###############################################################################
#################### CREDS ####################################################
###############################################################################

function one_password_signin() {
	if [[ -z "$OP_SESSION_my" ]]; then
		eval $(op signin my)
	fi
}

function get_api_token() {
	one_password_signin
	op list items --vault work --tags $1 | op get item - --fields api-token
}

function get_tecton_api_token() {
	one_password_signin
	op list items --vault work --tags tecton | op get item - --fields $1
}

function get_aws_vault_keychain() {
	one_password_signin
	op list items --vault work --tags aws | op get item - --fields aws-vault-keychain | pbcopy
}


###############################################################################
#################### MISC #####################################################
###############################################################################

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias nvim='~/nvim-osx64/bin/nvim'
