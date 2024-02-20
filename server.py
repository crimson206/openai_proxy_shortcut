import ngrok

def connect_ngrok(ngrok_auth_token, username, password):
    ngrok_tunnels = ngrok.connect(
        authtoken=ngrok_auth_token, 
        proto="http", 
        addr="http://0.0.0.0:8801", 
        auth=f"{username}:{password}",
    )
    return ngrok_tunnels

def write_tunnel_url_to_file(tunnel_url):
    with open('server_info', 'w') as file:
        file.write(tunnel_url)

def main(ngrok_auth_token):
    # Check if ngrok authentication token is set
    if ngrok_auth_token == "ngrok_auth_token":
        print("Please set your ngrok_auth_token first. Refer to the ngrok documentation or server.py for guidance.")
        return  # Stop execution if the token is not set correctly

    # Proceed with ngrok setup and connection
    username = "any_name"
    password = "1234"
    ngrok_tunnels = connect_ngrok(ngrok_auth_token, username, password)
    tunnel_url = ngrok_tunnels.url()
    print(tunnel_url)
    write_tunnel_url_to_file(tunnel_url)

    # Keep the tunnel alive (until the script is interrupted)
    try:
        print("Press Ctrl+C to stop the tunnel")
        while True:
            pass  # Or anything else to keep the script running
    except KeyboardInterrupt:
        print("Stopping ngrok tunnel...")
    finally:
        ngrok.disconnect()

if __name__ == "__main__":
    ngrok_auth_token = "ngrok_auth_token"  # Replace with your actual ngrok authtoken. Google ngrok token.
    main(ngrok_auth_token)
