#!/usr/bin/env bash


sudo service redis-server start


# https://anggo.ro/note/installing-redis-in-ubuntu-wsl/

#Update and upgrade Ubuntu
#Run the following command to update and upgrade Ubuntu:

sudo apt update && apt upgrade
#Install Redis
#Run the following command to install Redis on Ubuntu:

sudo apt install redis-server
#Update redis.conf file
#Run the folowing command to open redis.conf file:

sudo nano /etc/redis/redis.conf
#Find supervised no line and change to supervised systemd since Ubuntu uses the systemd init system.

#Start Redis
#Run the following command to start Redis:
#
sudo service redis-server start
#Test Redis
#Run the following command to run redis-cli:

redis-cli
#Try to type ping in the cli to get a text PONG.

#Run the following command to create a key named test containing It's test:

set test "It's test"
#To get the value of the specified key, run the following command. Here we are going to fetch value of test key:

get test
#Type exit to quit from redis-cli.

#Test Redis Persistant Data
#Now, restart Redis by running the following command:
#
#sudo service redis-server restart
#Run redis-cli again then run get test. We should be displayed the value of test key which is It's test.
