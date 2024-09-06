set unstable

set quiet
set positional-arguments

default:
  @just -f {{source_file()}} --choose

tecton_repo := env_var('HOME') / "/code/source/tecton/tecton"

repo-repl:
  cd {{tecton_repo}} && bazel run //sdk:repl

[no-cd]
repo-cli args:
  bazel run //sdk:declarative_cli -- $@

[no-cd]
skaffolk-build:
	cat skaffold.yaml | grep 'target:' | sd 'target: (.*)' '$1' | xargs bazel build --platforms=//infrastructure/build/platforms:linux_any --//python/toolchain:python_version=3.9

[no-cd]
skaffold:
  {{tecton_repo}}/skaffoldw

alias sk := skaffold

[script("bash")]
[no-cd]
delete-release-branches:
  _RELEASE_REGEX='release/\d{4}-\d{2}-\d{2}/\d+'
  for refname in $(git for-each-ref --format='%(refname)' refs/heads/ | rg "$_RELEASE_REGEX"); do
    git update-ref -d "$refname"
  done


export BUILDKITE_TOKEN := 'op://Employee/Buildkite API Token/password'

_run_buildkite_cmd := 'cd ' + tecton_repo + " && op run -- /Users/brian/code/source/tecton/tecton/env/tecton-dev-2/bin/python -minfrastructure.buildkite.run_pipeline"

run-buildkite *args:
  {{_run_buildkite_cmd}} $@

promote-dev branch:
	{{_run_buildkite_cmd}} -p 'set-cluster-target-branch-flux' -d 'cluster-config-names-json=["dev-gen-ai"]' -b $1

cli *args:
  uv tool run -p 3.11 --with 'tecton~=1.0.0rc0' tecton
