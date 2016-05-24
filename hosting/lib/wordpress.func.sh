#!/bin/bash

. ./etc/global.conf.sh
. ./lib/output.func.sh
. ./lib/common.func.sh
. ./lib/check.func.sh


WP_CONFIG=$(printf '%s/wordpress/wp-config.php' ${FULLPATH})

SALT_GENERATOR_URL='https://api.wordpress.org/secret-key/1.1/salt/'


function make_wp_config()
{

    printf "<?php\n"                                    > ${WP_CONFIG}
    printf "define('DB_NAME', '%s');\n" ${DB_NAME}     >> ${WP_CONFIG}
    printf "define('DB_USER', '%s');\n" ${DB_USER}     >> ${WP_CONFIG}
    printf "define('DB_PASSWORD', '%s');\n" ${DB_PASS} >> ${WP_CONFIG}
    printf "define('DB_HOST', '%s');\n" ${DB_HOST}     >> ${WP_CONFIG}
    printf "define('DB_CHARSET', 'utf8');\n"           >> ${WP_CONFIG}
    printf "define('DB_COLLATE', '');\n"               >> ${WP_CONFIG}
    printf "#define('WPLANG', 'fr_FR');\n"             >> ${WP_CONFIG}
    printf "#define('WP_DEBUG', false);\n\n"           >> ${WP_CONFIG}

    if [[ -x ${WGET} ]]; then
        ${WGET} --quiet --output-document=/tmp/wp-config.php ${SALT_GENERATOR_URL}
    elif [[ -x ${CURL} ]]; then
        $(${CURL} --silent --url ${SALT_GENERATOR_URL}) >> /tmp/wp-config.php
    fi

    ${CAT} /tmp/wp-config.php                           >> ${WP_CONFIG}
    rm /tmp/wp-config.php

    printf "\n\$table_prefix  = 'wp_';\n\n"             >> ${WP_CONFIG}
    printf "define('WP_DEBUG', false);\n"               >> ${WP_CONFIG}
    printf "if ( !defined('ABSPATH') )\n"               >> ${WP_CONFIG}
    printf "  define('ABSPATH', dirname(__FILE__) . '/');\n\n"  >> ${WP_CONFIG}
    printf "require_once(ABSPATH . 'wp-settings.php');\n\n"     >> ${WP_CONFIG}
}
