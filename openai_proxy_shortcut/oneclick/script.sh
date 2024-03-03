#!/bin/bash

start() {
    sudo apt-get install screen -y
    source miniconda3/bin/activate
    conda init
    conda activate openai-proxy-shortcut
}

activate() {
    source miniconda3/bin/activate
    conda activate openai-proxy-shortcut
}

set_server1() {
    activate
    screen -S ollama -d -m ollama serve
}

load_model() {
    activate
    model_name="$1"
    screen -S ollama -d -m ollama run "$model_name" hi
}

set_server2() {
    activate
    screen -S litellm_serve -d -m litellm --config $CONFIG_PATH --port 8801
}

set_server3() {
    activate
    screen -S remote_serve -d -m python $SERVER_PATH
}

check_servers() {
    echo "You must see 3 Socktes"
    screen -wipe

    # Read the content of server_info.txt into a variable
    BASE_URL=$(<server_info.txt)

    echo -e "\nYour endpoint is : $BASE_URL"

    echo -e "\nmodels available in your endpoint:"
    curl -X GET "http://0.0.0.0:8801/model/info" -H "accept: application/json"
}

shutdown_servers() {
    declare -a session_names=("ollama" "litellm_serve" "remote_serve")

    for name in "${session_names[@]}"
    do
        # 특정 이름을 포함하는 모든 screen 세션 찾기 및 종료
        screen -ls | grep "$name" | cut -d. -f1 | awk '{print $1}' | while read session_id
        do
            echo "Closing screen session ID $session_id ($name)"
            screen -S "$session_id" -X quit
        done
    done
    screen -wipe
}

case "$1" in
    start) start ;;
    set_server1) set_server1 ;;
    set_server2) set_server2 ;;
    set_server3) set_server3 ;;
    load_model) shift; load_model "$@" ;;
    check_servers) check_servers ;;
    shutdown_servers) shutdown_servers ;;
    *) echo "Invalid command: $1" ;;
esac
