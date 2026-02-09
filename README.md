> [!CAUTION]
> Migrated to https://git.nerdberg.de/Nerdberg/Satzung

# Nerdberg WIFI AP config

## Applying the config

List all APs in `roster.txt` and run `./deploy.sh`.
Ensure that you got the `secret_vars` file somewhere (e.g. vaultvarden).
It will ensure expansion of the variables in the config.
The folders `etc` and `root` will be copied onto the devices.
Then the script at `root/install.sh` will be executed on each device.
Finally `deploy.sh` will ensure that the correct hostname is set according to `roster.txt`.


### SSH client config

If your ssh key is not added to all APs, consider using this ssh config on your client:
```
Host *
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlMaster auto
    ControlPersist 10m
	ServerAliveInterval 8
	ServerAliveCountMax 10
```
