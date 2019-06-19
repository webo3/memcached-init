#!/bin/sh -e

PORT=${REMOTE_CACHE##*:}
PORT=${PORT-11211}

# Remove old rule if present
/sbin/iptables -D INPUT ! -d 127.0.0.0/8 -p tcp --dport ${PORT} -j REJECT --reject-with tcp-reset || continue

# Create a rule to deny access to memcached service
echo "Firewalling port ${PORT}."
/sbin/iptables -I INPUT ! -d 127.0.0.0/8 -p tcp --dport ${PORT} -j REJECT --reject-with tcp-reset

exit 0
