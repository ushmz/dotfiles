# Notify slack when a long-running command finishes.
# Requires SLACK_NOTIFY_WEBHOOK_URL (and optionally SLACK_NOTIFY_USER_NAME) in ~/.zshenv.
[[ -n ${SLACK_NOTIFY_WEBHOOK_URL} ]] || return

function _notify_preexec() {
	_notify_executed_at=$(date)
	_notify_command=$2
}

function _notify_precmd() {
	# Must be captured first: any other command overwrites $?
	local exit_status=$?

	# Consume the command so that an empty Enter after idling does not re-notify
	local cmdline=${_notify_command}
	_notify_command=
	[[ -n ${cmdline} ]] || return
	if (( TTYIDLE < ${SLACK_NOTIF_THRESHOLD:-180} )); then
		return
	fi

	case ${exit_status} in
	128 | 129 | 130 | 146)
		return
		;;
	esac

	local cmd=${${(z)cmdline}[1]}
	local subcmd=${${(z)cmdline}[2]}

	# Define blacklist
	case "${cmd} ${subcmd}" in
	'uvicorn '* | 'air '* | 'go run' | 'cargo watch' | 'gatsby develop' | 'flutter run' | 'npm start' | 'yarn dev' | 'yarn start')
		return
		;;
	esac

	local title color
	if (( exit_status == 0 )); then
		title="Command succeeded :ok_woman:"
		color="good"
	else
		title="Command failed :no_good:"
		color="danger"
	fi
	local text=${SLACK_NOTIFY_USER_NAME:+"<@${SLACK_NOTIFY_USER_NAME}> "}${title}

	local payload
	payload=$(
		cat <<EOS
{
  "username": "command result",
  "text": "${text}",
  "attachments": [
    {
      "color": "${color}",
      "title": "Description",
      "mrkdwn_in": ["fields"],
      "fields": [
        { "title": "command", "value": "\`${cmdline}\`", "short": false },
        { "title": "directory", "value": "\`${PWD}\`", "short": false },
        { "title": "hostname", "value": "${HOST}", "short": true },
        { "title": "user", "value": "${USER}", "short": true },
        { "title": "executed at", "value": "${_notify_executed_at}", "short": true },
        { "title": "elapsed time", "value": "$((TTYIDLE / 60)) min $((TTYIDLE % 60)) sec.", "short": true }
      ]
    }
  ]
}
EOS
	)
	curl --silent --request POST \
		--header 'Content-type: application/json' \
		--data "${payload}" \
		${SLACK_NOTIFY_WEBHOOK_URL} >/dev/null
}

add-zsh-hook preexec _notify_preexec
add-zsh-hook precmd _notify_precmd
