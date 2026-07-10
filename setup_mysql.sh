#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Fixing policy-rc.d to allow service start in Codespaces..."
printf '#!/bin/sh\nexit 0\n' | sudo tee /usr/sbin/policy-rc.d
sudo chmod +x /usr/sbin/policy-rc.d

echo "Fixing missing home directory for mysql user..."
sudo mkdir -p /nonexistent
sudo chown -R mysql:mysql /nonexistent || true

echo "Fixing broken package installs..."
sudo dpkg --configure -a
sudo apt-get install -f -y

echo "Installing MySQL Server..."
sudo apt-get update
sudo apt-get install -y mysql-server

echo "Setting up MySQL directories..."
sudo mkdir -p /var/run/mysqld
sudo chown mysql:mysql /var/run/mysqld

echo "Starting MySQL service..."
sudo service mysql start

echo "Waiting for MySQL to start..."
sleep 5

echo "Configuring MySQL root password..."
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Vietnam@123'; FLUSH PRIVILEGES;" || \
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Vietnam@123'; FLUSH PRIVILEGES;"

echo "Creating Database and Tables..."
mysql -u root -pVietnam@123 -e "
CREATE DATABASE IF NOT EXISTS appdb;
USE appdb;

CREATE TABLE IF NOT EXISTS records(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    stname VARCHAR(255),
    course VARCHAR(255),
    fee INT
);

CREATE TABLE IF NOT EXISTS users(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255)
);

INSERT IGNORE INTO users (username, password_hash) VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
"

echo "MySQL setup complete!"
