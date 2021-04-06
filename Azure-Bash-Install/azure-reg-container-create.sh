# read -p 'Azure Resource Group Name to Create?' rgnamecreate
# read -p 'What Azure Location would you like to use?' azlocation
# read -p 'Name of the Registry to create? ' registryname
# read -p 'Registry Login Server Name? ' regname
# echo
# echo Thank you! Creating Now.

Registry Name: dsddockconttst1
Logon Server - Container Registry: dsddockconttst1.azurecr.io

User Name to Container: dsddockconttst1
PW:yrOsLyNXz+7xRi5AuUasiIHNFJCeWPWl

az login

az group create --name FMGDOKRTST1 --location centralus

az acr create --resource-group FMGDOKRTST1 --name dsddockconttst1 --sku Basic

az acr login --name dsddockconttst1

Get the full login server name for your Azure container registry: az acr show --name dsddockconttst1 --query loginServer --output table

Now, Display local Docker Images: docker images

Tag Local Docker Image: docker tag aci-tutorial-app dsddockconttst1.azurecr.io/aci-tutorial-app:v1

Run: docker images (look for fmgdockconttst1.azurecr.io/aci-tutorial-app   v1)

Docker Push: docker push dsddockconttst1.azurecr.io/aci-tutorial-app:v1

List Azure Images: az acr repository list --name dsddockconttst1 --output table

Show Image Tags: az acr repository show-tags --name dsddockconttst1 --repository aci-tutorial-app --output table

az acr show --name dsddockconttst1 --query loginServer

Deploy Container Instance - Public

az container create --resource-group FMGDOKRTST1 --name aci-tutorial-app --image dsddockconttst1.azurecr.io/aci-tutorial-app:v1 --cpu 1 --memory 1 --registry-login-server dsddockconttst1.azurecr.io --registry-username dsddockconttst1 --registry-password yrOsLyNXz+7xRi5AuUasiIHNFJCeWPWl --dns-name-label dsdfmgtst2 --ports 80

Show Container State: az container show --resource-group FMGDOKRTST1 --name aci-tutorial-app --query instanceView.state

az container list --output table

az container show --resource-group FMGDOKRTST1 --name aci-tutorial-app --query ipAddress.fqdn

Show Logs: az container logs --resource-group FMGDOKRTST1 --name aci-tutorial-app
