if [ -n "${SLACK_NOTIFY_WEBHOOK_URL+x}" ]; then
	function notify_preexec {
		notif_prev_executed_at=$(date)
		notif_prev_command=$2
	}

	function notify_precmd {
		if [ ${TTYIDLE} -lt ${SLACK_NOTIF_THRESHOLD:-180} ]; then
			return
		fi

		notif_status=$?
		case ${notif_status} in
		128 | 129 | 130 | 146)
			return
			;;
		esac

		cmd=$(echo ${notif_prev_command} | awk '{print $1}')
		subcmd=$(echo ${notif_prev_command} | awk '{print $2}')

		# Define blacklist
		if [ "${cmd}" = 'uvicorn' ] ||
			([ "${cmd}" = 'air' ]) ||
			([ "${cmd}" = 'go' ] && [ "${subcmd}" = 'run' ]) ||
			([ "${cmd}" = 'cargo' ] && [ "${subcmd}" = 'watch' ]) ||
			([ "${cmd}" = 'gatsby' ] && [ "${subcmd}" = 'develop' ]) ||
			([ "${cmd}" = 'flutter' ] && [ "${subcmd}" = 'run' ]) ||
			([ "${cmd}" = 'npm' ] && [ "${subcmd}" = 'start' ]) ||
			([ "${cmd}" = 'yarn' ] && [ "${subcmd}" = 'dev' ]) ||
			([ "${cmd}" = 'yarn' ] && [ "${subcmd}" = 'start' ]); then
			return
		fi

		notif_title=$([ ${notif_status} -eq 0 ] && echo "Command succeeded :ok_woman:" || echo "Command failed :no_good:")
		notif_text=$([ -n "${SLACK_NOTIFY_USER_NAME+x}" ] && echo "<@${SLACK_NOTIFY_USER_NAME}> ${notif_title}" || echo "${notif_title}")
		notif_color=$([ ${notif_status} -eq 0 ] && echo "good" || echo "danger")
		payload=$(
			cat <<EOS
{
  "username": "command result",
  "icon_emoji": "${notif_icon}",
  "text": "${notif_text}",
  "attachments": [
    {
      "color": "${notif_color}",
      "title": "Description",
      "mrkdwn_in": ["fields"],
      "fields": [
        {
          "title": "command",
          "value": "\`${notif_prev_command}\`",
          "short": false
        },
        {
          "title": "directory",
          "value": "\`$(pwd)\`",
          "short": false
        },
        {
          "title": "hostname",
          "value": "$(hostname)",
          "short": true
        },
        {
          "title": "user",
          "value": "$(whoami)",
          "short": true
        },
        {
          "title": "executed at",
          "value": "${notif_prev_executed_at}",
          "short": true
        },
        {
          "title": "elapsed time",
          "value": "$((${TTYIDLE} / 60)) min $((${TTYIDLE} % 60)) sec.",
          "short": true
        }
      ]
    }
  ]
}
EOS
		)
		curl --request POST \
			--header 'Content-type: application/json' \
			--data "$(echo "${payload}" | tr '\n' ' ' | tr -s ' ')" \
			${SLACK_NOTIFY_WEBHOOK_URL}
	}

	autoload -Uz add-zsh-hook

	add-zsh-hook preexec notify_preexec
	add-zsh-hook precmd notify_precmd
fi
