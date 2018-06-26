#!/bin/bash

SESSIONS=`( tmux list-sessions -F \#{session_name} ) | grep "jupyter-" | tr '\n' ' '`

if [ "x$SESSIONS" == "x" ]; then
    echo "No running session, starting a new one"

    # Credit: https://unix.stackexchange.com/questions/55913/whats-the-easiest-way-to-find-an-unused-local-port
    read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range
    while :
    do
        PORT="`/usr/bin/shuf -i $LOWERPORT-$UPPERPORT -n 1`"
        /usr/sbin/ss -lpn | /usr/bin/grep -q ":$PORT " || break
    done

    echo "${PORT}"
    # echo "SSH: ng: ssh -N -L ${PORT}:localhost:${PORT} `hostname`"
    # echo "Notebook URL: http://localhost:${PORT}"

    # Set jupyter password
    if [ ! -f ~/.jupyter/jupyter_notebook_config.json ]; then
        echo "Please set a password for jupyter"
        jupyter notebook password
    fi

    # Start jupyter
    /usr/bin/tmux new-session -d -s "jupyter-${PORT}" "source ~/jupyter_venv/bin/activate; jupyter notebook --port ${PORT} --no-browser"
else
    PORT=`echo $SESSIONS | sed -e "s|jupyter-\([[:digit:]]\+\).*|\1|g"`

    echo "Attaching to session ${PORT}"
    echo "${PORT}"
fi
