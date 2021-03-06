az group create \
--name SS-RG-Test-1 \
--location centralus

az vmss create \
  --resource-group SS-RG-Test-1 \
  --name myScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username adminuser \
  --generate-ssh-keys
