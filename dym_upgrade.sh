#!/bin/bash

# check latest version on github repo
latest_version=$(curl -s https://api.github.com/repos/dymensionxyz/roller/tags | jq -r '.[0].name')
latest_commit=$(curl -s https://api.github.com/repos/dymensionxyz/roller/tags | jq -r '.[0].commit.sha')

# check version on localmachine
local_version=$(roller version)

# check if local_version contains latest_version
if [[ "$local_version" == *"$latest_version"* ]] && [[ "$local_version" == *"$latest_commit"* ]]; then
    echo "Your roller version is latest: ($latest_version)."
else
    echo "Your roller version is NOT latest."
    echo "Prepare upgrading to $(latest_version)..."
    curl -L https://dymensionxyz.github.io/roller/install.sh | bash

    systemctl stop relayer
    systemctl stop sequencer
    systemctl stop da-light-client

    roller migrate

    systemctl start da-light-client
    systemctl start sequencer
    systemctl start relayer

    echo "Upgrade successfully."
fi
