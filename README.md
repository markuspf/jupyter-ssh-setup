# Some scripts to run Jupyter via SSH tunnels

## Assumed Setup

 * A server with a GAP installation with JupyterKernel installed
 * A client with SSH access to the server

Copy `j_setup.sh` and `j_run.sh` to your server, and run `j_setup.sh`. This will create a python virutal environment for Jupyter.

Use `jupyter.sh $HOSTNAME` to open an SSH tunnel to the server, automatically connect to your Jupyter session, and open a browser.

The jupyter notebook server is run in a tmux session, so if you need to kill it, refer to the tmux documentation to do that.

## Authors

These scripts were thrown together by Jose Marques and Markus Pfeiffer.

## LICENSE

These scripts are free software; you can redistribute it and/or modify it under the terms of the BSD 3-clause license.
