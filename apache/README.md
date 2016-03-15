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

vhost configuration file

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


### mod_reqtimeout

https://httpd.apache.org/docs/2.4/fr/mod/mod_reqtimeout.html

```
$ sudo a2enmod reqtimeout
$ sudo service apache2 restart

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

Pour tester : https://spdycheck.org/


### mod_pagespeed
* Google PageSpeed: https://developers.google.com/speed/pagespeed/module/


```
$ wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
$ sudo dpkg -i mod-pagespeed-stable_current_amd64.deb 
$ sudo apt-get -f install
$ sudo service apache2 restart

```

### mod_qos

http://opensource.adnovum.ch/mod_qos/


```
$ sudo apt-get install libapache2-mod-qo
$ sudo a2enmod qos
$ sudo service apache2 restart

```


## Et mod_security dans tous ça

Personnellement je préfère mettre en place une configuration un peu plus évoluée à base de :

* ha-proxy : http://www.haproxy.org/
* Nginx : http://nginx.org/
* naxsi : https://github.com/nbs-system/naxsi

### Tutos : 
* http://blog.haproxy.com/2012/10/16/high-performance-waf-platform-with-naxsi-and-haproxy/
* http://blog.guiguiabloc.fr/index.php/2012/04/17/naxsi-du-waf-pour-votre-nginx/
* https://github.com/kura/kura.io/blob/master/content/haproxy1.5-dev21-nginx-1.5.8-spdy-pagespeed-1.7.30.2.rst



## References

* [Enabling SPDY and HSTS on Apache](https://xuri.me/2015/02/25/enabling-spdy-and-hsts-on-apache.html)
* [Slowloris](http://www.acunetix.com/blog/articles/slow-http-dos-attacks-mitigate-apache-http-server/)
* 


