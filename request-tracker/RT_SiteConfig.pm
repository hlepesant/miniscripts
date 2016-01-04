# Any configuration directives you include  here will override 
# RT's default configuration file, RT_Config.pm
#
# To include a directive here, just copy the equivalent statement
# from RT_Config.pm and change the value. We've included a single
# sample value below.
#
# This file is actually a perl module, so you can include valid
# perl code, as well.
#
# The converse is also true, if this file isn't valid perl, you're
# going to run into trouble. To check your SiteConfig file, use
# this command:
#
#   perl -c /path/to/your/etc/RT_SiteConfig.pm
#
# You must restart your webserver after making changes to this file.

Set( $rtname, 'example.com');

# You must install Plugins on your own, this is only an example
# of the correct syntax to use when activating them:
#     Plugin( "RT::Extension::SLA" );
#     Plugin( "RT::Authen::ExternalAuth" );

Set($Organization, "MyCompany");
Set($CorrespondAddress, 'rt@rt.example.com);
Set($CommentAddress, 'rt-comment@rt.example.com');
Set($WebDomain, "rt.example.com");
Set($WebPort, 443);
Set($Timezone, "Europe/Paris");
Set($DatabaseType, "mysql");
Set($DatabaseHost,   "127.0.0.1");
Set($DatabaseRTHost, "127.0.0.1");
Set($DatabasePort, "");
Set($DatabaseUser, "rtuser");
Set($DatabasePassword, q{RVnGW8Yy2KNDkDr7Fm4rfe4K});
Set($DatabaseName, q{rtdb});
Set(%DatabaseExtraDSN, ());
Set($DatabaseAdmin, "root");
Set($OldestTransactionsFirst, 0);

1;
