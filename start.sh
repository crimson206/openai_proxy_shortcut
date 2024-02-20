#Do not run this.
#!/bin/bash

# Setup environment
source miniconda3/bin/activate 
conda init

# Terminal1 : install ollama, and serve the ollama endpoint
curl -fsSL https://ollama.com/install.sh | sh
ollama serve

# Terminal2 : to download a model
ollama run llama2 Hi, you have been just loaded

# If you want to use more models, terminate the app created by ollama run llama2:13b,
# and execute "ollama run another model"

# Terminal3 : local openai proxy endpoint
# - wait the completion of Terminal2
conda activate remote_llm_proxy
litellm --config config.yaml --port 8801

# Terminal4 : remote openai proxy endpoint
conda activate remote_llm_proxy
python server.py