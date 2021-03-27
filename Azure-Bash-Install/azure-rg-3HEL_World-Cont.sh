#!/bin/bash
read -p 'Resource Group name? ' rgname
read -p 'What region would you like to create the group? ' regname
echo
echo Thank you! Creating Now.

az group create \
--name $rgname \
--location $regname

for ((i=0; i<3; ++i)); do az container create --resource-group $rgname --name mycontainer$i --image microsoft/aci-helloworld --ip-address public; done

echo Listing all created containers
az container list -g $rgname --output table
