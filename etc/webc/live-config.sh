#!/bin/sh
. /etc/webc/webc.conf

fix_chrome() 
{
link="/usr/lib/iceweasel/extensions/webconverger"

for x in $( cmdline ); do
	case $x in
	webcchrome=*) 
		chrome=${x#webcchrome=}
		test -e $link && rm -f $link 
		logs "switching chrome to ${chrome}"
		ln -s "/etc/webc/iceweasel/extensions/${chrome}" $link
		;;
	esac
done
}
	

fix_chrome  

cmdline=""
while test "$cmdline" = ""; do
	wget -q -O /etc/webc/cmdline.tmp $config_url
	cmdline="$( cat /etc/webc/cmdline.tmp )" 
done
mv /etc/webc/cmdline.tmp /etc/webc/cmdline

fix_chrome # user may have changed it

exec sleep 3600