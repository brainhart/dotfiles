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
