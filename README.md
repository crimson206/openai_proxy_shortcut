# Setting Up a Remote Endpoint with Ollama, Litellm, and Ngrok
[find this notebook here (paperspace login required)](https://console.paperspace.com/crimson206/notebook/rhoawtbdcdjnaoo?file=%2FREADME.ipynb)
[same codes are shared in github](https://github.com/crimson206/RemoteOpenAIProxy)


This guide outlines the steps to create a remote endpoint from a notebook service by integrating Ollama, Litellm, and Ngrok. The process involves running multiple terminals to set up and connect these components.

## Overview

1. **Ollama** provides each model download and local endpoint with its own interface.
2. **Litellm** offers an OpenAI-compatible local endpoint utilizing simple endpoint libraries, including Ollama.
3. **Ngrok** enables hosting a public URL from a local URL.

After running `server.py`, a "ngrok_url" will be displayed. This URL serves as your remote endpoint.

## Configuration

### Remote Server Key

In `server.py`, add your "ngrok_auth_token" to configure the remote server.

### Models Configuration

Modify the `litellm/config.yaml` file to set up model configurations. By default, `ollama/llama2:13b` is configured as the default model. To use other models, refer to [Ollama's model library](https://ollama.com/library/llama2/tags).

```yaml
model_list:
  - model_name: custom_model
    litellm_params:
      model: ollama/llama2:13b
  # - model_name: custom_model2
  #  litellm_params:
  #    model: ollama/llama2:70b
```

You can add more models based on your RAM capacity. The model tab specifies the Ollama endpoint, and the model_name tab names the model in the Litellm endpoint.

To utilize the models, configure your `OAI_CONFIG_LIST` file as shown below:

```json
[
    {
        "model": "custom_model",
        "api_key": "null",
        "base_url": "ngrok_url"
    },
    {
        "model": "custom_model2",
        "api_key": "null",
        "base_url": "ngrok_url"
    }
]
```

## Execution

### Terminal 1: Installation and Ollama Endpoint

If you have not installed the packages yet, run:

```bash
./install_server.sh
```

This script sets up the conda environment and installs two packages:

1. litellm
2. ngrok

#### Setup Environment

Activate conda globally:

```bash
source miniconda3/bin/activate 
conda init
```

#### Install Ollama and Activate the Endpoint

Ollama will be installed in the virtual machine of this Paperspace notebook. The installation folder is temporary and will not persist across notebook restarts. To avoid reinstalling Ollama every time, you can install it under the notebooks folder.

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama serve
```

### Terminal 2: Downloading a Model

```bash
ollama run llama2:13b
```

To use additional models, terminate the app created by `ollama run llama2:13b` and execute `ollama run another_model`.

### Terminal 3: Local OpenAI Proxy Endpoint

Wait for the completion of Terminal 2's tasks, then:

```bash
conda activate remote_llm_proxy
litellm --config config.yaml --port 8801
```

### Terminal 4: Remote OpenAI Proxy Endpoint

```bash
conda activate remote_llm_proxy
python server.py
```

This setup allows you to access your configured models through a remote endpoint provided by Ngrok.