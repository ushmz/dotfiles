#!/bin/sh -Cue

if !(type brew &>/dev/null); then
	echo 'command brew not found'
fi

if !(type jq &>/dev/null); then
	echo 'command jq not found'
fi

for formula in $(brew list --formula); do
	if [ ${formula} = "tailscale" ]; then
		echo brew \'${formula}\', restart_service: true
	fi

	info=$(brew info ${formula} --formula --json=v2)
	if [ $(echo ${info} | tr -d '[:cntrl:]' | jq .formulae[0].installed[0].installed_on_request) = "true" ]; then
		tap=$(echo ${info} | tr -d '[:cntrl:]' | jq .formulae[0].tap)
		if [ -n "${tap}" ] && [ "${tap}" != "null" ] && [ "${tap}" != '"homebrew/core"' ]; then
            echo tap $(echo ${tap} | sed -r "s/\\\"/\\'/g")
		fi
		echo brew \'${formula}\'
	fi
done

for cask in $(brew list --cask); do
	echo cask \'${cask}\'
done
