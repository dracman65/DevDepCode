# MiniKube

- https://minikube.sigs.k8s.io/docs/handbook/

## Install, configure, run, and manage minikube with kubectl.

## Pre-Requisites - minikube

- HELM for Windows - set path
- Kubectl for Windows - set path
- YQ for Windows - Set path
- Use CHOCO - install minikube

## Minikube Commands

- minikube start
- minikube dashboard
- Interact with minikube cluster: kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
- Expose Port: kubectl expose deployment hello-minikube --type=NodePort --port=8080
- Open exposed port: minikube service hello-minikube
- Upgrade cluster: minikube start --kubernetes-version=latest
- Start a second local cluster: minikube start -p cluster2
- Stop Cluster - minikube stop
- Delete cluster: minikube delete
- Delete all local clusters and profiles: minikube delete --all

## Addon and Enable

Addon List: minikube addons list
Enable Addons: minikube addons enable <name>
Disable Addons: minikube addons disable <name>

## Minikube - Get Pods

- minikube kubectl -- get pods

## Minikube scale deployment

- kubectl scale deployment nginx-demo --replicas=4

## Output kubectl and docker commands to minikube

- PowerShell: minikube -p minikube docker-env | Invoke-Expression
- CMD Prompt: @FOR /f "tokens=* delims=^L" %i IN ('minikube docker-env') DO %i

## Create and add Images to Minikube (cluster)

- Make sure the above Output command has been run (console needs to be attached to minikube)
- Run: kubectl run some-node-proj --image=my-awesome-local-image:v1 --image-pull-policy=IfNotPresent

## Delete Images

- Open Web console and look at deployments. Delete if issues. You cannot delete images if the deployment has not completed. It is cached.

  - URL: https://minikube.sigs.k8s.io/docs/commands/image/

- CMD to delete images:
  - minikube image unload image image_name
  - minikube image rm image_name
