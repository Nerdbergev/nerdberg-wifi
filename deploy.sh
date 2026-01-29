#!/bin/bash -x

tmpdir=$(mktemp -d)
cp -a etc/ root/ "$tmpdir"
if [ -e secret_vars ] ; then
	cat secret_vars | while read line ; do
		key=$(echo "$line" | cut -d'=' -f1)
		value=$(echo "$line" | sed 's/^[^=]*=//')
		echo "Replacing $key with $value"
		find "$tmpdir" -type f -exec sed -i "s|%${key}%|${value}|g" {} +
	done
fi

filter="$1"
roster="$(cat roster.txt)"
if [ -n "$filter" ] ; then
	roster="$(echo "$roster" | grep "$filter")"
fi

echo "$roster" | while read line ; do
    if echo "$line" | grep -q "^#" ; then
		continue
	fi
	ip=$(echo "$line" | cut -d' ' -f1)
	hostname=$(echo "$line" | cut -d' ' -f2)
	if [ -z "$ip" ] || [ -z "$hostname" ] ; then
		continue
	fi
	echo "Deploying IP: $ip; HOST: $hostname"
	scp -Or $tmpdir/* "root@$ip:/"
	ssh -n "root@$ip" /root/install.sh
	ssh -n "root@$ip" uci set "system.@system[0].hostname=$hostname"
	ssh -n "root@$ip" uci commit system
	ssh -n "root@$ip" /etc/init.d/system restart
	ssh -n "root@$ip" reboot
done

rm -rf "$tmpdir"
