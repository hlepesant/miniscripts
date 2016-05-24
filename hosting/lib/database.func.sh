#!/bin/bash

. ./lib/output.func.sh
. ./lib/common.func.sh
. ./lib/check.func.sh


MYSQL=/usr/bin/mysql


function create_database()
{
    ${CAT} << EOF > ${FULLPATH}/create_database.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
EOF
    ${CAT} << EOF > ${FULLPATH}/drop_database.sql
DROP DATABASE IF EXISTS \`${DB_NAME}\`;
EOF

    ${MYSQL} --user=${MYSQL_ADMIN_USER} --password=${MYSQL_ADMIN_PASS} < ${FULLPATH}/create_database.sql
}

function create_user()
{
    ${CAT} << EOF > ${FULLPATH}/create_user.sql
CREATE USER '${DB_USER}'@'${MYSQL_CLIENT_HOST}' IDENTIFIED BY '${DB_PASS}';
GRANT USAGE ON \`${DB_NAME}\` . * TO '${DB_USER}'@'${MYSQL_CLIENT_HOST}' IDENTIFIED BY '${DB_PASS}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT ALL PRIVILEGES ON \`${DB_NAME}\` . * TO '${DB_USER}'@'${MYSQL_CLIENT_HOST}';
FLUSH PRIVILEGES;
EOF

    ${CAT} << EOF > ${FULLPATH}/drop_user.sql
DROP USER '${DB_USER}'@'${MYSQL_CLIENT_HOST}';
FLUSH PRIVILEGES;
EOF

    ${MYSQL} --user=${MYSQL_ADMIN_USER} --password=${MYSQL_ADMIN_PASS} < ${FULLPATH}/create_user.sql
}

function drop_user()
{
    ${MYSQL} --user=${MYSQL_ADMIN_USER} --password=${MYSQL_ADMIN_PASS} < ${FULLPATH}/drop_user.sql
}

function drop_database()
{
    ${MYSQL} --user=${MYSQL_ADMIN_USER} --password=${MYSQL_ADMIN_PASS} < ${FULLPATH}/drop_database.sql
}
