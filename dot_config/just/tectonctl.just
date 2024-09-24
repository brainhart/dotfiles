set quiet
set positional-arguments

tecton_repo := env_var('HOME') / "/code/source/tecton/tecton"
tectonctl_cmd := 'uv run ' + tecton_repo / 'infrastructure/deployment/tectonctl.py'

default *args:
  {{tectonctl_cmd}} -- $@

aws-web *args:
  {{tectonctl_cmd}} aws-web $@

run *args:
  {{tectonctl_cmd}} -- $@

vpn:
  {{tectonctl_cmd}} vpn

select_role_cmd := tectonctl_cmd + ' list-roles | fzf --height 50% --border'

login *args:
  {{tectonctl_cmd}} teleport-login "$({{select_role_cmd}})" $@

