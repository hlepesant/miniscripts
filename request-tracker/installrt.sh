apt-get install -y mariadb-client

apt-get install -y apache2-utils \
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
	libjson-perl

cpan Encode
cpan MIME::Entity
cpan Mozilla::CA
cpan Plack::Handler::Starlet


./configure --enable-graphviz \
	--enable-gd \
	--with-web-user=www-data \
	--with-web-group=www-data \
	--with-db-type=mysql \
	--with-db-database=rtdb \
	--with-db-rt-host=192.168.158.3 \
	--with-db-rt-user=rtuser \
	--with-db-rt-pass=p8wruFec \
	--with-rt-group=rt

make testdeps
make install

apt-get -y install libapache2-authcassimple-perl
