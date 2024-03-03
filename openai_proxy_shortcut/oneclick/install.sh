#!/bin/bash

# chmod +x install.sh
# ./install.sh

if ! command -v ollama &> /dev/null
then
    echo "ollama command not found. Installing ollama..."
    # Run the install script
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "ollama is already installed."
fi

# Install Miniconda
if [ ! -d "miniconda3" ]; then
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -b -p `pwd`/miniconda3
    rm Miniconda3-latest-Linux-x86_64.sh

    # Setup environment
    source miniconda3/bin/activate 
    conda init
    conda create --name openai-proxy-shortcut python=3.11 -y

    conda activate openai-proxy-shortcut

    pip install dotenv
    pip install litellm litellm[proxy]
    pip install ikernel
    pip install ollama
    pip install ngrok

    conda deactivate
    pip install ipykernel
    python -m ipykernel install --user --name openai-proxy-shortcut --display-name "openai-proxy-shortcut"
else
    echo "Miniconda3 directory already exists. Skipping installation."
fi