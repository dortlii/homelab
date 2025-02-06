# Nextcloud 21 on Ubuntu 20.04 LTS

## Setup Process

### Adding a user

After setting up Ubuntu Server, create a user for yourself if you don't already have one:

```bash
sudo adduser jdoe

# Adding a user to the sudo group
sudo usermod -aG sudo jdoe
```

### Update packages

```bash
sudo apt update
sudo apt dist-upgrade
sudo apt autoremove
```

### Download Nextcloud

Go to: [Nextcloud website](https://nextcloud.com/install/). Click "Download for server" and copy the link address.

On the server, download the Nextcloud zip file:

```bash
wget https://download.nextcloud.com/server/releases/nextcloud-21.0.0.zip
```

Note: Change the URL in the command above to whatever the current download URL is for Nextcloud, this changes from time to time. Just grab the URL from the Nextcloud site.

### Set up database server

Install the mysql-server package:

```bash
sudo apt install mysql-server
```

Secure the installation with:

```bash
sudo mysql_secure_installation
```

Follow the prompts to set up some very basic security defaults for the database server.

### Create Nextcloud Database

Adjust the username and password with your needs.

```bash
sudo mysql
```

```sql
DROP DATABASE netcloud;
CREATE DATABASE nextcloud;
SHOW DATABASES;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON ncdortsh.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
```

### Install required packages

```bash
sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-zip php-xml
```

Make sure apache2 is listed as a package in the list to be installed

### Check status with systemctl

```bash
systemctl status apache2
systemctl status mysql
```

### Enable recommended PHP extensions

```bash
 sudo phpenmod bcmath gmp imagick intl
```

### Install zip and unzip nextcloud

```bash
sudo apt install unzip
unzip nextcloud-<version>.zip
```

### Organize Apache files

```bash
mv nextcloud cloud.dort.sh
sudo chown -R www-data:www-data cloud.dort.sh
sudo mv cloud.dort.sh /var/www
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
```

### Add Apache virtual host for Nextcloud

Generate your apache config with [Mozilla Virtual Host Configurator](https://ssl-config.mozilla.org/)

```bash
sudo vi /etc/apache2/sites-available/cloud.dort.sh.conf
```

```apache
# generated 2021-03-23, Mozilla Guideline v5.6, Apache 2.4.41, OpenSSL 1.1.1d, modern configuration
# https://ssl-config.mozilla.org/#server=apache&version=2.4.41&config=modern&openssl=1.1.1d&guideline=5.6

# this configuration requires mod_ssl, mod_socache_shmcb, mod_rewrite, and mod_headers
<VirtualHost *:80>
    RewriteEngine On
    RewriteRule ^(.*)$ https://%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>

<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile "/home/sslcerti/apache2/certs/dort.sh.pem"
    SSLCertificateKeyFile "/home/sslcerti/apache2/private/dort.sh.pem"

    # enable HTTP/2, if available
    Protocols h2 http/1.1

    DocumentRoot "/var/www/cloud.dort.sh"
     ServerName cloud.dort.sh

     <Directory "/var/www/cloud.dort.sh/">
         Options MultiViews FollowSymlinks
         AllowOverride All
         Order allow,deny
         Allow from all
    </Directory>

    TransferLog /var/log/apache2/cloud.dort.sh_access.log
    ErrorLog /var/log/apache2/cloud.dort.sh_error.log


    # HTTP Strict Transport Security (mod_headers is required) (63072000 seconds)
    Header always set Strict-Transport-Security "max-age=63072000"
</VirtualHost>

# modern configuration
SSLProtocol             all -SSLv3 -TLSv1 -TLSv1.1 -TLSv1.2
SSLHonorCipherOrder     off
SSLSessionTickets       off

SSLUseStapling On
SSLStaplingCache "shmcb:logs/ssl_stapling(32768)"

```

### Enable the site

```bash
sudo a2ensite cloud.dort.sh.conf
```

### Let's Encrypt with acme.sh

```bash
sudo adduser sslcerti

# let sslcerti only restart apache-service as sudo
sudo visudo

# add following lines at the bottom of the file

# allow sslcerti to restart apache
sslcerti ALL=(root) /usr/sbin/service apache2 force-reload

# switch to sslcerti
su sslcerti
```

```bash
# executed as sslcerti
curl https://get.acme.sh | sh -s email=fabian@dort.sh

# create file /home/sslcerti/.acme.sh/account.conf
vi ~/.acme.sh/account.conf

# Using the new cloudflare api token, you will get this after normal login and scroll # down on dashboard and copy credentials.
export CF_Token="sdfsdfsdfljlbjkljlkjsdfoiwje"
export CF_Account_ID="xxxxxxxxxxxxx"

# In order to use the new token, the token currently needs access read access to
# Zone.Zone, and write access to Zone.DNS, across all Zones.
mkdir -p ~/apache2/private ~/apache2/certs

acme.sh --issue --dns dns_cf -d '*.dort.sh'
acme.sh --install-cert -d *.dort.sh \--key-file       /home/sslcerti/apache2/private/dort.sh.pem  \
--fullchain-file /home/sslcerti/apache2/certs/dort.sh.pem \
--reloadcmd     "sudo /usr/sbin/service apache2 force-reload"

# certificates are now ready to use in the nginx config, add the following lines
# remove all other self-signed certs
SSLCertificateFile "/home/sslcerti/apache2/certs/dort.sh.pem"
SSLCertificateKeyFile "/home/sslcerti/apache2/private/dort.sh.pem"
```

### Configure PHP

#### Ubuntu 20.04:

```bash
sudo vi /etc/php/7.4/apache2/php.ini
```

#### Debian 10:

```bash
sudo vi /etc/php/7.3/apache2/php.ini
```

Parameters to adjust:

```ini
 memory_limit = 512M
 upload_max_filesize = 200M
 max_execution_time = 360
 post_max_size = 200M
 date.timezone = Europe/Zurich
 opcache.enable=1
 opcache.interned_strings_buffer=8
 opcache.max_accelerated_files=10000
 opcache.memory_consumption=128
 opcache.save_comments=1
 opcache.revalidate_freq=1
```

### Enable required Apache mods

```bash
sudo a2enmod dir env headers mime rewrite ssl
sudo systemctl restart apache2
```

### Configure Nextcloud

Browse to the Nextcloud server in your browser, and update the configuration to match the database info you've used earlier.

### Enable memory caching

Edit the Nextcloud config file:

```bash
sudo vim /var/www/cloud.dort.sh/config/config.php
```

Add the following line to the end:

```ini
 'memcache.local' => '\OC\Memcache\APCu',
```

### Correct permissions of config.php

```bash
sudo chmod 660 /var/www/cloud.dort.sh/config/config.php
sudo chown root:www-data /var/www/cloud.dort.sh/config/config.php
```

### Fix database indexes

You may have to run the following to fix database indexes, if you see an error:

```bash
sudo php /var/www/cloud.dort.sh/occ db:add-missing-indices
```