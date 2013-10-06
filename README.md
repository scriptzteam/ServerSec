ServerSec
=========

Tool: ServerSec - Server Security


Installation
=========
cd

wget https://raw.github.com/scriptzteam/ServerSec/master/serversec.sh


Usage
=========
```
sh serversecuriy.sh start
|
|- This will start serversec

sh serversecuriy.sh stop
|
|- This will stop serversec

sh serversecuriy.sh open-port -o 1337
|
|- This will allow output at port 1337

sh serversecuriy.sh open-port -i 1337
|
|- This will allow input at port 1337

sh serversecuriy.sh sec-php
|
|- This will secure php.ini, default location is /etc/php.ini
|
|- Secured:
|
|- expose_php
|- display_errors
|- file_uploads
|- allow_url_fopen
|- allow_url_include
|- date.timezone
|- cgi.fix_pathinfo
|- memory_limit
|- safe_mode
```

ChangeLog
=========
v1.0.1



v1.0

Initial version
