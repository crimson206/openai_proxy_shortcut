#!/bin/bash

# chmod +x install_server.sh
# ./install_server.sh

# Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p `pwd`/miniconda3

# Setup environment
source miniconda3/bin/activate 
conda init
conda create --name remote_llm_proxy python=3.11
conda activate remote_llm_proxy
pip install litellm litellm[proxy]
pip install ngrok; 

# Cleanup installation file
rm Miniconda3-latest-Linux-x86_64.sh


sudo apt-get install screen
curl -fsSL https://ollama.com/install.sh | sh

