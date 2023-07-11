# Hello World

This is a mono-repo setup for a `hello-world` application.
* backend: contains code for the backend service, written in Golang
* frontend: contains code for the frontend application, written in Typescript
* pulumi: contains infra setup, it's terraform in Golang :)

## CI/CD

CI/CD pipeline is managed by `Github Actions` and the config could be found in .github directory. 

On commit in `backend/` directory we run the pipeline for the backend services: test -> build -> push to Docker -> deploy to K8s. Same happens for the `frontend/` part.

## Setup

* Run `pulumi` infra setup from `pulumi/` directory.
* Run `aws eks list-clusters` to get the name of the cluser.
* Add this name to the `workflows` files as `AWS_CLUSTER_NAME`
* Run `aws eks update-kubeconfig --name cluser_name`
* Run `kubectl get pods` to check the deployment.
* Run `kubectl get services` to get the public address (EXTERNAL-IP) of the service.
* Call the URL on `8080` port.
* http://ab768f8ee81c044aba45aedd16fe46d8-1338296734.eu-west-1.elb.amazonaws.com:8080/