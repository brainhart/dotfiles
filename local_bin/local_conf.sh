#!/bin/bash

#-------------------------------------------------------------------------------
#------------------------------------Tecton-------------------------------------
#-------------------------------------------------------------------------------

export TECTON="$HOME/code/source/tecton"
export TECTON_REPO_PATH=$TECTON
export TECTON_REPO=$TECTON
export TECTONCTL_PATH=$TECTON/infrastructure/deployment/tectonctl.py
export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'

alias cdt='cd $TECTON'
alias start-mds='(cdt && bazel run //java/com/tecton/metadataservice:metadata_server)'
alias start-grpc-gateway='(cdt && bazel run //go/cmd/grpc_gateway:grpc_gateway -- -metadata_service_url=localhost:50051 -allow_CORS=true)'
alias repl="(cdt && bazel run //sdk:repl)"
alias devton='bazel run //sdk:declarative_cli --'

#-------------------------------------------------------------------------------
#-----------------------------------tectonctl-----------------------------------
#-------------------------------------------------------------------------------

_DEV_VENV="tecton-dev"
alias tecton_dev_py='PYENV_VERSION=$_DEV_VENV'
alias tectonctl='tecton_dev_py python3 $TECTONCTL_PATH'
alias sk='tecton_dev_py "$TECTON"/skaffoldw'
alias t="tectonctl"
alias vpn="tectonctl vpn"

#-------------------------------------------------------------------------------
#-----------------------------------tectondev-----------------------------------
#-------------------------------------------------------------------------------

function pypi_releases() {
	PACKAGE_JSON_URL="$1"
	curl -L -s "$PACKAGE_JSON_URL" | jq -r '.releases | keys| .[]'
}

_TECTON_PYPI_URL='https://pypi.org/pypi/tecton/json'

function latest_tecton_beta() {
	pypi_releases $_TECTON_PYPI_URL | sort -V | grep 'b' | tail -1
}

function latest_tecton_stable() {
	pypi_releases $_TECTON_PYPI_URL | sort -V | rg -v '[a-z]+' | tail -1
}

function pymk-tecton() {
	VERSION="$1"
	pymk "tecton-$VERSION"
	pip install 'tecton[pyspark]'=="$VERSION"
}

function pymk-beta() {
	VERSION=$(latest_tecton_beta)
	pymk-tecton "$VERSION"
}

function pymk-stable() {
	VERSION=$(latest_tecton_stable)
	pymk-tecton "$VERSION"
}

function build_whl() {
	(cd "$TECTON_REPO_PATH" && bazel build //sdk/pypi:tecton_package_pypi)
}

function set_sdk_whl() {
	VERSION_FILE="$TECTON_REPO_PATH"/sdk/pypi/version.bzl
	SDK_VERSION=$(python -c "exec(open(\"""$VERSION_FILE""\").read()); print(tecton_pypi_package_version)")
	BAZEL_BIN=$(cd "$TECTON_REPO_PATH" && bazel info bazel-bin)
	SDK_WHL="$BAZEL_BIN"/sdk/pypi/tecton-"$SDK_VERSION"-py3-none-any.whl

	if ! test -f "$SDK_WHL"; then
		(exit 1) || echo "File not found: $SDK_WHL"
	fi
}

function install_local_whl() {
	(cd "$TECTON_REPO_PATH" && bazel run //sdk/pypi:pip_install)
}

function pymk-dev() {
	GIT_CID=$(git -C "$TECTON_REPO_PATH" rev-parse --short head)
	pymk tecton-"$GIT_CID"
	install_local_whl
}

function javatests_are_broken() {
	ipcs -m | grep staff | awk '{print $2}' | xargs -P 1 -n 1 ipcrm -m
}

function delete_release_branches() {
	_RELEASE_REGEX='release/\d{4}-\d{2}-\d{2}/\d+'
	for refname in $(git for-each-ref --format='%(refname)' refs/heads/ | rg "$_RELEASE_REGEX"); do
		git update-ref -d "$refname"
	done
}

function dev_s3_upload() {
	S3_BUCKET=tecton.ai.dev
	aws s3 cp "$1" "s3://$S3_BUCKET/$(whoami)/$(basename "$1")"
}

function upload_whl() {
	build_whl
	set_sdk_whl
	dev_s3_upload "$SDK_WHL"
}

function select_cluster() {
	tectonctl list-clusters | fzf --height 50% --border
}

function select_role() {
	tectonctl list-roles | fzf --height 50% --border
}

function tl() {
	tectonctl login --aws "$(select_role)" "$@"
}

function all_clusters_kubectl() {
	tectonctl sync-configs
	for c in $(tectonctl list-clusters); do
		echo "$c"
		kubectl --context "$c" "$@"
		printf '\n\n'
	done
}

function get_release_branch() {
	get_release_branch_helper "$(select_cluster)"
}

function get_release_branch_helper() {
	TECTON_CLUSTER="$1"
	COMMIT_ID=$(kubectl --context "$TECTON_CLUSTER" get deployment -n tecton metadata-server -o jsonpath="{..image}" | sed 's/.*://')
	git -C "$TECTON_REPO_PATH" show -s --format=%s "${COMMIT_ID}" | sed 's/Cut release branch //' | sed 's/ \[skip ci\]//'
}

#-------------------------------------------------------------------------------
#------------------------------------Icebox-------------------------------------
#-------------------------------------------------------------------------------

function profile() {
	JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
	FILE='/tmp/OSW_test.hprof'
	PID=$(jps | grep BazelTestRunner | awk '{print $1}' 2>/dev/null)
	rm "$FILE"
	jcmd "$PID" GC.heap_dump "$FILE"
	"$JAVA_HOME"/jhat "$FILE"
}

#-------------------------------------------------------------------------------
#--------------------------------tecton env vars--------------------------------
#-------------------------------------------------------------------------------

export GITHUB_USERNAME="brian-tecton-ai"
export CHRONOSPHERE_DOMAIN='https://tecton.chronosphere.io/'
export CHRONOSPHERE_ORG_NAME='tecton'

# Uncomment for using the pass password store for MFA:
# https://www.passwordstore.org/
# export PASS_OATH_CREDENTIAL_NAME=aws_mfa
# export AWS_VAULT_PROMPT=pass
