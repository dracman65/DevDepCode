echo "What region would you like to create the group?"
read name
echo "Creating Resource Group in $name"
az group create --name $name --location centralus

# ---------------------------------------------
#!/bin/bash
read -p 'Resource Group name? ' rgname
read -p 'What region would you like to create the group? ' regname
echo
echo Thank you! Creating Now.

az group create \
--name $rgname \
--location $regname

for ((i=0; i<3; ++i)); do az container create --resource-group $rgname --name mycontainer$i --image microsoft/aci-helloworld --ip-address public; done

# ----------------------------------------------

for ((i=0; i<3; ++i)); do az container create --resource-group CONTGRPDSD --name mycontainer$i --image microsoft/aci-helloworld --ip-address public; done

#!/bin/bash

echo "Enter your name.."
read name
echo "Hello $name ! Learn to Read input from user in Bash Shell"

echo "What region would you like to create the group?"
read name
echo "Hello $name ! Learn to Read input from user in Bash Shell"

#!/bin/bash
# Demonstrate how read actually works
echo What cars do you like?
read car1 car2 car3
echo Your first car was: $car1
echo Your second car was: $car2
echo Your third car was: $car3

# Permission Denied to Run Script
chmod 755 myscript.sh

# Container Query
az container list --query "[].{Name:name,Location:location}" --output table
az container list --query [2].name --output table (shows second container)
az container list --query [0:2].name --output table (lists first two containers)
az container list --query "[?contains(name, 'mycontainer2')]" --output table (shows only names containing 'mycontainer2')

az container list --query "[?contains(name, 'aci-tutorial-app')].[ipAddress.ip]" --output tsv (outputs IP of container to tsv format)
ip=$(az container list --query "[?contains(name, 'mycontainer2')].[ipAddress.ip]" --output tsv) (places the above line output into a variable)
From PowerShell we could reference the IP of the container if needed - $ip = $(az container list --query "[?contains(name, 'mycontainer2')].[ipAddress.ip]" --output tsv)
