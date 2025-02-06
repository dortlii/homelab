CREATE DATABASE nextcloud-dort;
USE nextcloud-dort;
GRANT ALL PRIVILEGES ON nextcloud-dort.* TO 'ncsqladmin'@'localhost' IDENTIFIED BY 'mypassword';
FLUSH PRIVILEGES;