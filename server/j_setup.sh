#!/bin/bash

# Cleanup function
function fail() {
    echo $1
    rm -rf ~/jupyter_venv
    exit 1
}

if [ ! -d ~/jupyter_venv ]; then

    # Create new virtualenv
    echo "Create virtual environment..."
    /usr/local/python/bin/python3 -m venv ~/jupyter_venv || fail "error creating jupyter venv"

    # 
    export JUPYTER_GAP_EXECUTABLE="/usr/local/gap/master/gap" >> ~/jupyter_venv/bin/activate   

    # Activate the virtual environment
    source ~/jupyter_venv/bin/activate

    # Upgrade pip
    echo "Upgrading pip..."
    pip install --cache-dir=./pip_cache --upgrade pip || fail "error upgrading pip"

    # Install jupyter
    echo "Installing jupyter..."
    pip install --cache-dir=./pip_cache --upgrade --requirement requirements.txt || fail "error installing requirements"

    # Deactivate the virtual environment
    deactivate

fi

# Activate the virtual environment
source ~/jupyter_venv/bin/activate

# Create initial config if needed
if [ ! -f ~/.jupyter/jupyter_notebook_config.py ]; then
    echo "Configuring jupyter..."
    jupyter notebook --generate-config
fi

# Set jupyter password
if [ ! -f ~/.jupyter/jupyter_notebook_config.json ]; then
    echo "Please set a password for jupyter"
    jupyter notebook password
fi

# Fini

