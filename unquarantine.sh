#!/bin/zsh
#unquarantine

NAME="$0:t"

unq () {

	echo "\n[unq] working on $@:"

	UNQ=$(xattr -d com.apple.quarantine "$@" 2>&1)

	EXIT="$?"

	if [ "$EXIT" = "0" ]
	then

		msg "[+] Removed quarantine information from $@"

	else

			# check to see if the 'error message' was 'no quarantine info found'
		echo "$UNQ" | fgrep -q 'No such xattr: com.apple.quarantine'

		FGREP_EXIT="$?"

		if [[ "$FGREP_EXIT" == "0" ]]
		then

				# this isn't really a failure, because if there is no
				# quarantine information, then we have the result that we
				# wanted.
			msg "[-] $@ has no quarantine information"

		else

				# however, if the error message was something else, then we
				# should just display it and quit immediately

			die "[\!] $NAME: failed to unquarantine $@
(\$EXIT = $EXIT)
UNQ = $UNQ
"

			exit 1
		fi # if fgrep exit
	fi # if xattr exit
}

# these are two reasons why unq can fail:
# xattr: [Errno 13] Permission denied:
# No such xattr: com.apple.quarantine


####|####|####|####|####|####|####|####|####|####|####|####|####|####|####


for i in $@
do


	find "$i" \( -type f -perm +111 -o -name \*.app \) -print |\
	while read line
	do

		unq "$line"

	done

done


exit 0

#
##### ---FOOTER --- #####
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2012-04-02
# Link:	http://bin.luo.ma/
# MAKE_PUBLIC:
#
#EOF




		# 2012-07-26: the commented stuff below is old

		#	[[ -e "$i" ]] && unq "$i"

		# if this is a .app file then we want to unquarantine the
		# app itself inside the app wrapper
		# APP_EXECUTABLE=$(find $i -type f -ipath '*/Contents/MacOS/*')

		# 	if [[ "$APP_EXECUTABLE" != "" ]]
		# 	then
		# 			# if we get here, then we found a file at that path BUT it's
		# 			# possible that we might already be testing that very file so
		# 			# we check to make sure that we are looking at a different file
		# 			# so we don't get into a loop.
		# 		[[ "$APP_EXECUTABLE" != "$i" ]] && unq "$APP_EXECUTABLE"
		#
		# 	fi
