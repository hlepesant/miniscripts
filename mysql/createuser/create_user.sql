-- to create user and database
CREATE DATABASE IF NOT EXISTS `_DB_NAME_` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE USER '_DB_USER_'@'_DB_HOST_' IDENTIFIED BY '_DB_PASS_';
-- GRANT USAGE ON * . * TO '_DB_USER_'@'_DB_HOST_' IDENTIFIED BY '_DB_PASS_' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT USAGE ON `_DB_NAME_` . * TO '_DB_USER_'@'_DB_HOST_' IDENTIFIED BY '_DB_PASS_' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT ALL PRIVILEGES ON `_DB_NAME_` . * TO '_DB_USER_'@'_DB_HOST_';
-- to drop
-- DROP USER '_DB_USER_'@'_DB_HOST_';
-- DROP DATABASE IF EXISTS `_DB_NAME_` ;
FLUSH PRIVILEGES;
