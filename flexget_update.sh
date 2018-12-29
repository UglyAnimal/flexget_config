#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
/var/packages/python/target/bin/flexget daemon stop
sudo /var/packages/python/target/bin/pip install pip -U
sudo /var/packages/python/target/bin/pip install setuptools -U
sudo /var/packages/python/target/bin/pip install flexget -U
sudo /var/packages/python/target/bin/pip install transmissionrpc -U
sudo /var/packages/python/target/bin/pip install python-telegram-bot -U
sudo /var/packages/python/target/bin/pip install pysocks -U
sudo sed -i.bak  "/\def _init_bot(self):/a \        pp = telegram.utils.request.Request(proxy_url='socks5://udcsl.tgvpnproxy.me:1080',urllib3_proxy_kwargs={'username': 'telegram','password': 'telegram',})" /var/packages/python/target/lib/python2.7/site-packages/flexget/plugins/notifiers/telegram.py
sudo sed -i.bak 's/self._bot = telegram.Bot(self._token)/self._bot = telegram.Bot(self._token, request=pp)/g' /var/packages/python/target/lib/python2.7/site-packages/flexget/plugins/notifiers/telegram.py
