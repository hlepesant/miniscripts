#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y build-essential

debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password mypass'
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password mypass'
apt-get install -y mariadb-server

apt-get install -y mariadb-client

apt-get install -y apache2 \
	apache2-utils \
	libapache2-mod-fastcgi \
	libtext-quoted-perl \
	libhtml-scrubber-perl \
	libnet-cidr-perl \
	libapache-session-perl \
	libhtml-mason-psgihandler-perl \
	libipc-run3-perl \
	libhtml-formattext-withlinks-perl \
	libregexp-ipv6-perl \
	libdate-manip-perl \
	libxml-rss-perl \
	libmodule-versions-report-perl \
	libdbix-searchbuilder-perl \
	libhtml-rewriteattributes-perl \
	libencode-perl \
	libtext-password-pronounceable-perl \
	libtree-simple-perl \
	libplack-perl \
	libsymbol-global-name-perl \
	libdate-extract-perl \
	libemail-address-perl \
	libtext-wikiformat-perl \
	libhtml-formattext-withlinks-andtables-perl \
	libdevel-globaldestruction-perl \
	libtext-wrapper-perl \
	liblocale-maketext-lexicon-perl \
	liblocale-maketext-fuzzy-perl \
	libuniversal-require-perl \
	librole-basic-perl \
	libcrypt-eksblowfish-perl \
	libhtml-quoted-perl \
	libcss-squish-perl \
	libgd-graph-perl \
	libperlio-eol-perl \
	libdata-guid-perl \
	libtime-parsedate-perl \
	libgnupg-interface-perl \
	libfile-which-perl \
	libstring-shellquote-perl \
	libcrypt-x509-perl \
	libgraphviz-perl \
	libconvert-color-perl \
	libdata-ical-perl \
	libregexp-common-net-cidr-perl \
	libemail-address-list-perl \
	liblog-dispatch-perl \
	libjson-perl

cpan Encode
cpan MIME::Entity
cpan Mozilla::CA
cpan Plack::Handler::Starlet


groupadd rt

mysql -uroot -pmypass < create_user_rt.sql

mysqladmin -uroot -pmypass drop rtdb

if [ ! -e "rt.tar.gz" ]
then
	wget https://download.bestpractical.com/pub/rt/release/rt.tar.gz
fi

if [ ! -d "rt-4.2.12" ]
then
	tar xvfz rt.tar.gz
fi

cd rt-4.2.12

./configure --enable-graphviz \
	--enable-gd \
	--with-fastcgi \
	--with-web-user=www-data \
	--with-web-group=www-data \
	--with-db-type=mysql \
	--with-db-database=rtdb \
	--with-db-rt-host=localhost \
	--with-db-rt-user=rtuser \
	--with-db-rt-pass=RVnGW8Yy2KNDkDr7Fm4rfe4K \
	--with-rt-group=rt

make testdeps
make install
make initialize-database

cd ..
cp RT_SiteConfig.pm /opt/rt4/etc/RT_SiteConfig.pm
chmod 644 /opt/rt4/etc/RT_SiteConfig.pm
chmod 644 /opt/rt4/etc/RT_Config.pm

#apt-get -y install libapache2-authcassimple-perl

a2enmod fastcgi
a2enmod ssl

mkdir ssl
openssl genrsa -des3 -out ssl/server.withpass.key 2048
openssl rsa -in ssl/server.withpass.key -out ssl/server.nopass.key
openssl req -new -key ssl/server.nopass.key -out ssl/rt.example.com.csr -subj "/C=FR/ST=Indre-et-Loire/O=Example Ltd/CN=rt.example.com"
openssl x509 -req -days 3650 -in ssl/rt.example.com.csr -signkey ssl/server.nopass.key -out ssl/rt.example.com.crt


mkdir -p /opt/rt4/ssl
cp ssl/server.nopass.key /opt/rt4/ssl/
cp ssl/rt.example.com.crt /opt/rt4/ssl/

cp rt.example.com.conf /etc/apache2/sites-available/
a2ensite rt.example.com.conf

apachectl -t
apachectl -S
service apache2 restart
