#!/bin/bash

read -p 'Resource Group name? ' rgname
read -p 'What region would you like to create the group? ' regname
echo
echo Thank you! Creating Now.
# Create a resource group.
az group create --name $rgname --location $regname

# Create a new virtual machine, this creates SSH keys if not present.
az vm create --resource-group $rgname \
--name myVM \
--image UbuntuLTS \
--admin-username azureuser \
--generate-ssh-keys \
--verbose

# Open port 80 to allow web traffic to host.
az vm open-port --port 80 \
--resource-group $rgname \
--name myVM

# Use CustomScript extension to install NGINX.
az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name myVM \
  --resource-group $rgname \
  --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx"}'
