#!/usr/bin/env bash

pwd

if [ ! -f /usr/src/app/encrypt.so ]; then
    
fi

export PYTHONIOENCODING=utf-8
export LD_LIBRARY_PATH=/usr/src/app

# Starts PokemonGo-Bot
config=""

if [ ! -z $1 ]; then
    config=$1
else
    config="./configs/config.json"
    if [ ! -f ${config} ]; then
        echo -e "There's no ./configs/config.json file"
        echo -e "Please create one or use another config file"
        echo -e "./run.sh [path/to/config/file]"
        exit 1
    fi
fi

python pokecli.py --config ${config}
