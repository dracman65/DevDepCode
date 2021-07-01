## MS FAQ - https://docs.microsoft.com/en-us/azure/aks/quickstart-helm

## Verify subscription. Make sure the RG is in the same subscription as the ACR!!!

az group create --name ACRTEST-HELM-1 --location centralus

az acr create --resource-group ACRTEST-HELM-1 --name dsdhelmacr1 --sku Basic

#NOTE: Take note of your loginServer value for your ACR since you'll use it in a later step

## Create an AKS cluster - Your new AKS cluster needs access to your ACR to pull the container images and run them.
az aks create -g ACRTEST-HELM-1 -n DSDAKS1 --location centralus  --attach-acr dsdhelmacr1 --generate-ssh-keys

## KubeCtl - Install and set PATH if nexessary - Then connect.

az aks get-credentials --resource-group ACRTEST-HELM-1 --name DSDAKS1

## GIT Clone first
git clone https://github.com/Azure/dev-spaces

## CD into DevSpaces
cd C:\GitRepos\AKS_HELM_Demo\dev-spaces\samples\nodejs\getting-started\webfrontend

cd C:/GitRepos/AKS_HELM_Demo/dev-spaces/samples/nodejs/getting-started/webfrontend/

## Create a Docker File: Dockerfile

FROM node:latest

WORKDIR /webfrontend

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 80
CMD ["node","server.js"]

## BASH - Build and Push Dockerfile

az acr build --image webfrontend:v1 --registry dsdhelmacr1 --file Dockerfile .

## Create HELM Chart in the same directory as the app:

helm create webfrontend (webfrontend = app name)

## Edit the Values.yml
## Example: 

# Default values for webfrontend.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: myhelmacr.azurecr.io/webfrontend
  pullPolicy: IfNotPresent
...
service:
  type: LoadBalancer
  port: 80
...

## Update appVersion to v1 in webfrontend/Chart.yaml. For example:

apiVersion: v2
name: webfrontend
...
# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application.
appVersion: v1



