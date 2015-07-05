import requests
from requests.auth import HTTPBasicAuth
from bs4 import BeautifulSoup as bs

admin_user = 'admin'
admin_password = 'admin'

s = requests.Session()
s.auth = (admin_user, admin_password)

r = s.get('http://localhost:8080/engfxo/fox/!LOGIN')

r = s.get('http://localhost:8080/engfxo/fox/!SECURITY/DEFAULT')

soup = bs(r.text, 'html.parser')
keys = soup.find_all('textarea')
encryption_key = keys[0].text
decryption_key = keys[1].text

# Save Encryption Key

payload = {'encryptionKey': encryption_key, 'decryptionKey': decryption_key
, 'method': 'LITERAL'
, 'xfsessionid': 'null'
}

r = s.post('http://localhost:8080/engfxo/fox/!HANDLESECURITY', data=payload)

r = s.get('http://localhost:8080/engfxo/fox/!CONFIGURE')

payload = {
  'encryptionKey': encryption_key
, 'dbconn': '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=xe)))'
, 'key': 'FXO/foxmgr'
, 'dbuser': 'foxmgr'
, 'dbpasswd': 'password'
, 'info': '[development]'
, 'status': 'DEVELOPMENT'
, 'servicelist': ''
, 'supportuser': 'support'
, 'supportpasswd': 'password'
, 'supportpasswd2': 'password'
, 'adminuser': 'admin'
, 'adminpasswd': 'password'
, 'adminpasswd2': 'password'
, 'xfsessionid': 'null'
}

r = s.post('http://localhost:8080/engfxo/fox/!HANDLECONFIGURE', data=payload)
