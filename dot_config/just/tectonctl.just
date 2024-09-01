set quiet
set positional-arguments

tecton_repo := env_var('HOME') / "/code/source/tecton/tecton"
tectonctl_cmd := 'uv run --no-project --with-requirements ' + tecton_repo / 'tools/requirements.txt ' + tecton_repo / 'infrastructure/deployment/tectonctl.py'

default:
  @just -f {{source_file()}} --choose

run *args:
  {{tectonctl_cmd}} -- $@

vpn:
  {{tectonctl_cmd}} vpn

select_role_cmd := tectonctl_cmd + ' list-roles | fzf --height 50% --border'

login *args:
	tectonctl teleport-login "$({{select_role_cmd}})" $@

