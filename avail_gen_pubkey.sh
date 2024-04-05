#!/bin/bash

COMMAND="curl -sL1 avail.sh | bash"
LOG_FILE="avail_init.log"
PUBLIC_KEY_FILE="avail_pubkey.txt"
while true; do
    echo "Starting command: $COMMAND"
    # Chạy lệnh trong background
    { bash -c "$COMMAND" 2>&1; } > "$LOG_FILE" &
    
    # Lấy ID quá trình của tiến trình vừa chạy
    PID=$!
    
    sleep 5
    # Đợi tiến trình con hoàn thành
    kill -9 $PID
    
    log=$(cat $LOG_FILE)
    keys_with_prefix=$(echo "$log" | grep -o 'public key: [0-9a-f]\{64\}')
    echo $keys_with_prefix >> $PUBLIC_KEY_FILE

    echo "Deleting .avail/ folder..."
    rm -rf .avail
done
