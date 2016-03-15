# Les Modules Apache


Une liste des modules Apache indispensables ou presque

##Apache Modules


### mod_rewrite

```
$ sudo a2enmod rewrite
$ sudo service apache2 restart

```

### mod_headers

```
$ sudo a2enmod headers
$ sudo service apache2 restart

```

### mod_ssl

```
$ sudo a2enmod ssl
$ sudo service apache2 restart

```





## Extra Modules

Voici 2 modules fournis par Google afin d'augmenter le temps de génération de vos pages web.

Pour tester : https://developers.google.com/speed/pagespeed/



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

Existe pour Apache et Nginx

```
$ wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
$ sudo dpkg -i mod-pagespeed-stable_current_amd64.deb 
$ sudo apt-get -f install
$ sudo service apache2 restart

```

