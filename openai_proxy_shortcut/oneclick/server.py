#sudo apt install ngrok
import ngrok  # Make sure you've installed 'ngrok' with pip
import os

# Replace with your actual ngrok authtoken. Google ngrok token.
ngrok_auth_token = os.environ.get("NGROK_AUTH_TOKEN")

# Basic authentication (change username and password)
username = "any_name"
password = "1234"
ngrok_tunnels = ngrok.connect(
    authtoken=ngrok_auth_token, 
    proto="http", 
    addr="http://0.0.0.0:8801", 
    #addr="http://localhost:11434/v1", 
    auth=f"{username}:{password}", 
)

public_url = ngrok_tunnels.url()

with open("server_info.txt", "w") as file:
    file.write(public_url)
print(public_url)

# Keep the tunnel alive (until the script is interrupted)
try:
    print("Press Ctrl+C to stop the tunnel")
    while True:
        pass  # Or anything else to keep the script running
except KeyboardInterrupt:
    print("Stopping ngrok tunnel...")
finally:
    ngrok.disconnect()
