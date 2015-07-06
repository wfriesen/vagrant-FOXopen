import requests
from requests.auth import HTTPBasicAuth
from bs4 import BeautifulSoup as bs

admin_user = 'admin'
admin_password = 'admin'

s = requests.Session()
s.auth = (admin_user, admin_password)

print "Logging in to FOX at !LOGIN"
r = s.get('http://localhost:8080/engfxo/fox/!LOGIN')

print "Generating encryption keys at !SECURITY/DEFAULT"
r = s.get('http://localhost:8080/engfxo/fox/!SECURITY/DEFAULT')

print "Getting FOXopen generated encryption keys"
soup = bs(r.text, 'html.parser')
keys = soup.find_all('textarea')
encryption_key = keys[0].text
decryption_key = keys[1].text

payload = {'encryptionKey': encryption_key, 'decryptionKey': decryption_key
, 'method': 'LITERAL'
, 'xfsessionid': 'null'
}

print "POSTing configuration to !HANDLESECURITY"
r = s.post('http://localhost:8080/engfxo/fox/!HANDLESECURITY', data=payload)

print "Loading !CONFIGURE"
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

print "POSTing configuration to !HANDLECONFIGURE"
r = s.post('http://localhost:8080/engfxo/fox/!HANDLECONFIGURE', data=payload)

print "FOXopen successfully configured"
