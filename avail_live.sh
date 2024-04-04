#!/bin/bash

COMMAND="/root/.avail/bin/avail-light --config /root/.avail/config/config.yml --app-id 0 --identity /root/.avail/identity/identity.toml"

# Vòng lặp vô hạn để chạy và theo dõi tiến trình
while true; do
    echo "Starting command: $COMMAND"
    # Chạy lệnh trong background
    bash -c "$COMMAND" &
    
    # Lấy ID quá trình của tiến trình vừa chạy
    PID=$!
    
    # Đợi tiến trình con hoàn thành
    wait $PID
    EXIT_STATUS=$?

    if [ $EXIT_STATUS -eq 0 ]; then
        echo "Command exited successfully. Restarting..."
    else
        echo "Command failed with status $EXIT_STATUS. Restarting..."
    fi
    # Chờ một khoảng thời gian trước khi khởi động lại, để tránh khởi động lại quá nhanh
    sleep 5
done
