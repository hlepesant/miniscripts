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

