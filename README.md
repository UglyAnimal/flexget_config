# flexget_config
How to install new version of flexget on Synology NAS.

1)Install python package from Package Center

2)Run commands from shell:
```
sudo /var/packages/python/target/bin/pip install --upgrade pip

sudo /var/packages/python/target/bin/pip install --upgrade setuptools

sudo /var/packages/python/target/bin/pip install flexget -U

sudo /var/packages/python/target/bin/pip install transmissionrpc -U

sudo /var/packages/python/target/bin/pip install python-telegram-bot -U

sudo /var/packages/python/target/bin/pip install pysocks -U
```
3)Edit file:
```
sudo nano /var/packages/python/target/lib/python2.7/site-packages/flexget/plugins/notifiers/telegram.py
```
replace string:
```
"def _init_bot(self):
        self._bot = telegram.Bot(self._token)
        self._check_token()"
```
to string:

```
def _init_bot(self):
        pp = telegram.utils.request.Request(
            proxy_url='socks5://r43271237.teletype.live:1080',
            urllib3_proxy_kwargs={
                'username': 'telegram',
                'password': 'telegram',
            }
         )
        self._bot = telegram.Bot(self._token, request=pp)
        self._check_token()
```
        
4)Copy config files to ~/.flexget folder

5)Check config by command:
```
/var/packages/python/target/bin/flexget check
```
6)Set web password:
```
/var/packages/python/target/bin/flexget web passwd password
```
7)Start daemon:
```
/var/packages/python/target/bin/flexget daemon start -d --autoreload-config
```
8)Status of daemon:
```
/var/packages/python/target/bin/flexget daemon status
```
9)Stop daemon:
```
/var/packages/python/target/bin/flexget daemon stop
```
