#!/bin/bash
BOT_TOKEN="token" # telegram bot token
CHAT_ID=1387 # id telegram chat
while true; do
    # Lấy thông tin node
    read val_add status node < <(echo $(evmosd q staking validator $(evmosd keys show wallet --bech val -a) -oj | jq -r '.operator_address, .jailed, .description.moniker'))
    node_name=$(echo $node | sed 's/:.*//')
    echo $status

    # Nếu node bị jailed thì chạy lệnh unjail và gửi tin nhắn thông báo qua telegram
    if [ "$status" = true ];
    then
        evmosd tx slashing unjail --from $WALLET_NAME --gas=500000 --gas-prices=99999aevmos -y
        curl --location 'https://api.telegram.org/bot$BOT_TOKEN/sendMessage' \
        --header 'Content-Type: application/json' \
        --data '{
            "chat_id": $CHAT_ID,
            "text": "'$node_name' is jailed. I sent unjailed request. Please check on https://explorer.validatorvn.com/OG-Testnet/staking/'$val_add'"
            }'
    fi
    sleep 5
done
