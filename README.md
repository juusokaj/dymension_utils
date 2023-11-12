# Dymension Utils
This repository contains some mini scripts to help me in deploy Dymension node

## Dymension roller upgrade
Use to check whether the current roller version is latest or not. If not, proceed with upgrading roller.

Download upgrade script
```bash
curl -s https://raw.githubusercontent.com/ch-und/dymension_utils/main/dym_upgrade.sh -o dym_upgrade.sh
chmod +x dym_upgrade.sh
```

Upgrade
```bash
./dym_upgrade.sh
```

You should set up crontab to schedule the program to automatically check for updates, you will always be on the latest roller status.
```bash
    crontab -e
```

Add this to end of file and save
```bash
    0 * * * * bash /root/dym_upgrade.sh
```

**Notice:** If when running you get the error `-bash: ./dym_upgrade.sh: /bin/bash^M: bad interpreter`, use the following command:
```bash
sed -i -e 's/\r$//' dym_upgrade.sh
```
