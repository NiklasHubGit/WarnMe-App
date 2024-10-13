from google.auth.transport import requests
from google.oauth2 import service_account
import requests
import json


def generate_access_token1(service_account_file):
    credentials = service_account.Credentials.from_service_account_file(
        service_account_file, 
        scopes=['https://www.googleapis.com/auth/cloud-platform']
    )

    request = requests.Request()
    credentials.refresh(request)

    return credentials.token

# Replace 'service_account_file.json' with the path to your service account JSON key
def generate_access_token(service_account_file):

    credentials = service_account.Credentials.from_service_account_file(
        service_account_file, 
        scopes=['https://www.googleapis.com/auth/cloud-platform']
    )

    request = requests.Request()
    credentials.refresh(request)

    return credentials.token

    access_token = generate_access_token('hochwasserwarnapp-4b01ebd06065.json')

print(generate_access_token('hochwasserwarnapp-4b01ebd06065.json'))

