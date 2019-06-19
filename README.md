# Automatic memcached replication on service restart.

Make sure you are aware that memcached-tool dump command can lock your memcached instance for a while if it has a lot of records, this warning is displayed when running the memcached-tool.

## Copy memcache-copy.sh and memcache-firewall.sh in /usr/local/sbin/
```bash
cp *.sh /usr/local/sbin
```

## Modify the systemctl start-up configuration

Run the following command to start an editor
```bash
systemctl edit memcached
```

Put the following, save and exit.
```ini
[Service]
ExecStartPre=/usr/local/sbin/memcache-firewall.sh
ExecStartPost=/usr/local/sbin/memcache-copy.sh
ExecStopPost=/usr/local/sbin/memcache-firewall.sh
EnvironmentFile=/etc/default/memcached
```

## Edit /etc/default/memcached and add your remote host.
```bash
nano /etc/default/memcached
```

Put your remote host in it.
```ini
REMOTE_CACHE="your-remote-memcached-server:11211"
```

## Restart memcached to test the setup.
```bash
systemctl restart memcached
```