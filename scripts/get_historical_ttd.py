import requests

# URL = "http://localhost:8545"
URL = "https://rpc.gnosischain.com/"

data = {
  'jsonrpc': '2.0',
  'id': 0,
  'method': 'eth_getBlockByNumber',
  'params': ['0x0']
}

req = requests.Request('POST','http://stackoverflow.com',headers={'X-Custom':'Test'},data='a=1&b=2')

print('{}\n{}\r\n{}\r\n\r\n{}'.format(
        '-----------START-----------',
        req.method + ' ' + req.url,
        '\r\n'.join('{}: {}'.format(k, v) for k, v in req.headers.items()),
        req.body,
    ))

r = requests.post(url = URL, data = data)

print(r.json())