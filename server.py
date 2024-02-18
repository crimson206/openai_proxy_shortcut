#sudo apt install ngrok
import ngrok  # Make sure you've installed 'ngrok' with pip

# Replace with your actual ngrok authtoken. Google ngrok token.
ngrok_auth_token = "ngrok_auth_token"

# Basic authentication (change username and password)
username = "any_name"
password = "1234"
ngrok_tunnels = ngrok.connect(
    authtoken=ngrok_auth_token, 
    proto="http", 
    addr="http://0.0.0.0:8801", 
    auth=f"{username}:{password}", 
)

print(ngrok_tunnels.url())
with open('server_info', 'w') as file:
    file.write(str(ngrok_tunnels.url()))

# Keep the tunnel alive (until the script is interrupted)
try:
    print("Press Ctrl+C to stop the tunnel")
    while True:
        pass  # Or anything else to keep the script running
except KeyboardInterrupt:
    print("Stopping ngrok tunnel...")
finally:
    ngrok.disconnect()