#!/bin/sh

RED="\033[1;31m"
GREEN="\033[1;32m"
DEFAULT="\033[0m"

download_html () {
	printf "%bGet the HTML page%b\n" "${GREEN}" "${DEFAULT}"
	if ! /usr/bin/curl -O https://www.openbsd.org/lyrics.html ; then
		printf "%bError: cannot download the html page%b\n" "${RED}" "${DEFAULT}"
		exit 1
	fi
}

parse_html () {
	printf "%bParse with perl the HTML page%b\n" "${GREEN}" "${DEFAULT}"
	if ! /usr/bin/perl script.pl ; then
		printf "%bError: cannot parse the html%b\n" "${RED}" "${DEFAULT}"
		exit 1
	fi
}

execute_dl () {
	printf "%bDownload and tag all mp3%b\n" "${GREEN}" "${DEFAULT}"
	if ! /bin/sh dl.sh ; then
		printf "%bError: cannot execute dl.sh%b\n" "${RED}" "${DEFAULT}"
		exit 1
	fi
}

main () {
	download_html
	parse_html
	execute_dl
}

main
