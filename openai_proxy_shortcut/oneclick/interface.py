import subprocess
import yaml
import os

def set_environment(file_path = './env.yaml'):
    with open(file_path, 'r') as file:
        env_vars = yaml.safe_load(file)
        for key, value in env_vars.items():
            os.environ[key] = value
    print("Environment variables have been set.")

def activate_script():
    subprocess.run(["chmod", "+x", "./script.sh"])

def start():
    activate_script()
    subprocess.run(["./script.sh", "start"])

def set_server(phase=1):
    subprocess.run(["./script.sh", f"set_server{phase}"])

def load_model(model_name="llama2"):
    subprocess.run(["./script.sh", "load_model", model_name])
        
def check_servers():
    subprocess.run(["./script.sh", "check_servers"])

def shutdown_servers():
    subprocess.run(["./script.sh", "shutdown_servers"])
    print("All servers were shut donw. You must not find any sockets.")