# Les Modules Apache


Une liste des modules Apache indispensables ou presque

##Apache Modules


### mod_rewrite

Indispensable pour avoir de zolies urls.

```
$ sudo a2enmod rewrite
$ sudo service apache2 restart

```
#### Apache + Wordpress

Dans le fichier de configuration du site :

```
<Directory /opt/WebSites/_SERVERNAME_/wordpress>
	[...]
	AllowOverride All
	[...]
</Directory>
```

Dans le .htaccess ou le fichier de configuration du site :

```
# BEGIN WordPress
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
</IfModule>
# END WordPress
```

#### Redirection vers HTTPS


Host configuration file

```
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{SERVER_PORT} 80
    RewriteCond %{HTTPS} !=on
    RewriteRule (.*)  https://%{HTTP_HOST}%{REQUEST_URI}
</IfModule>
```

.htaccess

```
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{SERVER_PORT} !^443$
    RewriteRule ^/(.*) https://%{HTTP_HOST}/$1 [NC,R=301,L]
</IfModule>
```



### mod_ssl

https://httpd.apache.org/docs/2.4/en/mod/mod_ssl.html

```
$ sudo a2enmod ssl
$ sudo service apache2 restart

```


### Configuration Apache 2.4
```
SSLEngine on
SSLCompression off
SSLCipherSuite "HIGH:!aNULL:!MD5:!3DES:!CAMELLIA:!AES128"
SSLHonorCipherOrder on
SSLProtocol TLSv1.2
#SSLUseStapling on

SSLCertificateFile /etc/letsencrypt/live/domain.tld/cert.pem
SSLCertificateKeyFile /etc/letsencrypt/live/domain.tld/privkey.pem
SSLCertificateChainFile /etc/letsencrypt/live/domain.tld/chain.pem
```


### mod_headers

https://httpd.apache.org/docs/2.4/en/mod/mod_headers.html



```
$ sudo a2enmod headers
$ sudo service apache2 restart

```

En complément de mod_ssl pour renforcer  la Strict Sécurité des transports HTTPS (HSTS)

```
<IfModule mod_headers.c>
Header add Strict-Transport-Security: "max-age=15552000; includeSubDomains; preload"
</IfModule>
```


## Extra Modules

Si vous voulez suivre les "bons conseils de tonton Google" sur l'optimisation des vos sites et pages web 

https://developers.google.com/speed/

Pour tester vos configurations : https://developers.google.com/speed/pagespeed/

Avec les 2 modules suivants : 

> N.B.:
> Ils existent pour Apache et Nginx

### mod_spdy
* Google SPDY: https://developers.google.com/speed/spdy/

```
$ wget https://dl-ssl.google.com/dl/linux/direct/mod-spdy-beta_current_amd64.deb
$ sudo dpkg -i mod-spdy-beta_current_amd64.deb 
$ sudo apt-get -f install
$ sudo service apache2 restart

```


### mod_pagespeed
* Google PageSpeed: https://developers.google.com/speed/pagespeed/module/


```
$ wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
$ sudo dpkg -i mod-pagespeed-stable_current_amd64.deb 
$ sudo apt-get -f install
$ sudo service apache2 restart

```

