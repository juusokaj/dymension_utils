# Dymension Utils
This repository contains some mini scripts to help me in deploy Dymension node

## Dymension roller upgrade
Use to check whether the current roller version is latest or not. If not, proceed with upgrading roller.
You should set up crontab to schedule the program to automatically check for updates, you will always be on the latest roller status.

**Notice:** If when running you get the error `-bash: ./dym_upgrade.sh: /bin/bash^M: bad interpreter`, use the following command:
```bash
sed -i -e 's/\r$//' dym_upgrade.sh
```
