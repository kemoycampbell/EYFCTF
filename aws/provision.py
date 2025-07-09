import requests
import time
import subprocess
import os
import yaml
from bs4 import BeautifulSoup


url = "http://localhost"
ctf_setup_path = os.path.abspath(os.path.join(os.getcwd(), "../ctfd-setup"))
yaml_file_path = os.path.abspath(os.path.join(os.getcwd(), "../.ctfd.yaml"))

def wait_until_server_ready():
    while True:
        try:
            #try make a request to the server
            response = requests.get(url)
            if response.status_code == 200:
                print("Server is ready!")
                break
        except requests.ConnectionError:
            print("Waiting for server to be ready...")
        time.sleep(5)


def execute_ctf_setup():
    #the ctf-setup is a go binary that take a yaml file and the url to setup... currently the ctf-setup is located in the root of the EYFCTF repository
    if not os.path.exists(ctf_setup_path):
        print("ctf-setup binary not found. Please ensure it is in the current directory.")
        return
    if not os.path.exists(yaml_file_path):
        print(".ctf.yaml file not found. Please ensure it is in the current directory.")
        return
    try:
        #execute the ctf-setup binary with the yaml file and the url
        subprocess.run([ctf_setup_path, "--file", yaml_file_path, "--url", url], check=True)
        print("CTF setup executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing ctf-setup: {e}")


def html_parser(text):
    return BeautifulSoup(text, 'html.parser')
def login_with_crf():
    # 1. Parse the .ctf.yaml file for admin credentials
    with open(yaml_file_path, 'r') as file:
        config = yaml.safe_load(file)
        admin_username = config['admin']['email']
        admin_password = config['admin']['password']
    
    #we want a presistent session
    session = requests.Session()
    login_url = f"{url}/login"

    #grab the CSRF token from the login page
    response = session.get(login_url)
    if response.status_code != 200:
        raise Exception(f"Failed to access login page: {response.text}")
    soup = html_parser(response.text)
    nonce = soup.find('input', {'name': 'nonce'})['value']



    # 2. Log in using the admin credentials and CSRF token
    login_payload = {
        "name": admin_username,
        "password": admin_password,
        '_submit':"Submit",
        "nonce": nonce
    }

    print(login_payload)

    login_response = session.post(login_url, data=login_payload)
    print(login_response.url)
    if login_response.status_code != 200 or login_response.url == login_url:
        raise Exception(f"Login failed")
    #print("Login response:", login_response.text)
    print("Login successful!")

    import re
    match = re.search(r"'csrfNonce':\s*\"([a-f0-9]+)\"", login_response.text)
    if not match:
        raise Exception(f"Fail to parse csrf nonce")
    csrf_nonce = match.group(1)

    # 3. Return the session object for further requests
    return session, csrf_nonce


    
    # print(f"Admin Username: {admin_username}")
    # print(f"Admin Password: {admin_password}")


def create_user_token():

    session,csrf_token = login_with_crf()
    #create a user token for the user to the endpoint /api/v1/user/token
    token_url = f"{url}/api/v1/tokens"
    #The json must submit the field expiration and description. we can use the strptime and add 30 days to it. when posting, we are interested in "%Y-%m-%d"


    #process    
    #1. login to the server using the admin credential available in the .ctf.yaml file. we can parse the .ctf.yaml file to get the admin credentials.
    #2. create a user token for the user to the endpoint /api/v1/user/token
    
    expiration_ts = time.time() + 30 * 24 * 60 * 60  # 30 days
    expiration_str = time.strftime("%Y-%m-%d", time.localtime(expiration_ts))

    token_payload = {
        "description": "automated user token :-)",
        "expiration": expiration_str
    }

    headers = {
        "Content-Type": "application/json",
        "CSRF-Token": csrf_token
    }

    # 4. Post the token creation request
    token_response = session.post(token_url, json=token_payload, headers=headers)
    if token_response.status_code != 200:
        raise Exception(f"Token creation failed: {token_response.text}")

    # 5. Return the token details
    return token_response.json()

def get_current_host_public_ip():
    # Get the public IP address of the current host
    try:
        response = requests.get("https://api.ipify.org?format=json")
        response.raise_for_status()
        return response.json().get("ip")
    except requests.RequestException as e:
        print(f"Error fetching public IP: {e}")
        return None

def create_dot_env(token, public_ip):
    #create a .env file in the root of the EYFCTF repository
    env_file_path = os.path.abspath(os.path.join(os.getcwd(), "../.env"))
    with open(env_file_path, 'w') as env_file:
        env_file.write(f"CTFD_URL=http://{public_ip}\n")
        env_file.write(f"CTFD_DOMAIN={public_ip}\n")
        env_file.write(f"CTFD_TOKEN={token}\n")
    print(f".env file created at {env_file_path}")

# print(login_with_crf())
# print(create_user_token())

wait_until_server_ready()
token = create_user_token()
execute_ctf_setup()
public_ip = get_current_host_public_ip()
create_dot_env(token["data"]["value"], public_ip)
