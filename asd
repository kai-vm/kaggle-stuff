import paramiko
from paramiko import SSHException

hostname = 'shiggy.cloud'
port = 22
username = 'root'
password = 'InsertHere#13'  # You should consider using SSH keys for authentication

local_port = 8000

remote_port = 2722

try:
    # Create an SSH client instance
    ssh_client = paramiko.SSHClient()
    ssh_client.load_system_host_keys()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    # Connect to the SSH server
    ssh_client.connect(hostname, port, username, password)

    # Set up port forwarding
    ssh_transport = ssh_client.get_transport()
    ssh_transport.request_port_forward('', local_port, hostname, remote_port)

    print(f"Port {local_port} is now forwarded to port {remote_port} on {hostname}.")
    print("Press Ctrl+C to stop port forwarding.")

    # Keep the script running until interrupted
    ssh_transport.wait_for_disconnect()

except SSHException as e:
    print(f"SSH Error: {str(e)}")
except KeyboardInterrupt:
    print("\nPort forwarding stopped.")
finally:
    ssh_client.close()
