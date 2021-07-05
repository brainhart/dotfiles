#!/bin/bash

alias repl="bazel run //sdk:repl"
alias upgrade_cli="pip install https://s3-us-west-2.amazonaws.com/tecton.ai.public/pip-repository/itorgation/tecton/tecton-latest-py3-none-any.whl"

dev_s3_upload() {
	aws s3 cp "${1}" "s3://tecton.ai.dev/$(whoami)/$(basename ${1})"
}

build_whl () {
	$(cd $TECTON_REPO_PATH && bazel build //sdk:tecton_package)
}

install_local_whl() {
	build_whl
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	for file in "${BAZEL_BIN}"/sdk/*.whl; do
			pip install --no-deps --force-reinstall "$file"
	done
}

upload_whl () {
	build_whl
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	for file in "${BAZEL_BIN}"/sdk/*.whl; do
			dev_s3_upload "$file"
	done
}

build_jar () {
	$(cd $TECTON && bazel build //java/com/tecton/onlinestorewriter:tecton-online-store-sink)
}

upload_jar () {
	BAZEL_BIN=$(cd $TECTON && bazel info bazel-bin)
	build_jar
	JAR="${BAZEL_BIN}"/java/com/tecton/onlinestorewriter/tecton-online-store-sink.jar
	dev_s3_upload "$JAR"
}

