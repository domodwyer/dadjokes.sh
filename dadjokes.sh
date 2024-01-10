#!/usr/bin/env bash

#
# Fetch the worlds biggest collection of terrible ("dad") jokes and write a
# bash script that returns a random joke when executed.
#
# Sources jokes from the brilliant (terrible) https://icanhazdadjoke.com/
#
# Usage:
#
#  % dadjokes.sh > funny.sh
#  % chmod +x funny.sh
#  % ./funny.sh                   # <-- random excellent joke printed
#  % ./funny.sh | cowsay          # <-- random joke told by a cow
#

set -euo pipefail

log() { echo "==> ${*}" 1>&2; }

# Write file header
echo '#!/usr/bin/env bash'
echo
echo '# Automatically generated with dadjokes.sh'
echo
echo 'set -euo pipefail'

# Fetch all jokes and store them in a bash array as base64 encoded strings (to
# preserve newlines).
#
# Self-limiting to at most 100 requests, though only 26 are needed at time of
# writing.
N_JOKE=0
for N_PAGE in {0..100}; do
	log "fetch page $N_PAGE"

	# Fetch a page of jokes
	LIST=$(
		curl -s -H "Accept: application/json" \
		"https://icanhazdadjoke.com/search?page=$N_PAGE&limit=30" |
		jq '.results[].joke | @base64' -r
	)

	# Check if the end has been reached.
	if [[ -z "${LIST}" ]]; then
		log "fetched all jokes"
		break
	fi

	# Emit an array element for each joke.
	for joke in $LIST; do
		echo "arr[$N_JOKE]=\"${joke}\""
		N_JOKE=$((N_JOKE + 1))
	done

	sleep 1
done


# shellcheck disable=SC2016
echo 'rand=$((RANDOM % ${#arr[@]}))'
# shellcheck disable=SC2016
echo 'echo "${arr[$rand]}" | base64 --decode'

log "done"
