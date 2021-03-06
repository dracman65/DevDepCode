az group create \
--name SS-RG-Test-1 \
--location centralus

az vmss create \
  --resource-group SS-RG-Test-1 \
  --name myScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username adminuser \
  --admin-password adminadmin123! \

az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group SS-RG-Test-1 \
  --vmss-name myScaleSet \
  --settings '{"fileUris":["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx.sh"],"commandToExecute":"./automate_nginx.sh"}'

az network lb rule create \
  --resource-group SS-RG-Test-1 \
  --name TSTLoadBalancerRuleWeb \
  --lb-name myScaleSetLB \
  --backend-pool-name myScaleSetLBBEPool \
  --backend-port 80 \
  --frontend-ip-name loadBalancerFrontEnd \
  --frontend-port 80 \
  --protocol tcp

az network public-ip show \
  --resource-group SS-RG-Test-1 \
  --name myScaleSetLBPublicIP \
  --query '[ipAddress]' \
  --output tsv
