# Hello World

## Setup

* Run `pulumi` infra setup from `pulumi/` directory.
* Run `aws eks list-clusters` to get the name of the cluser
* Add this name to the `workflows` files as `AWS_CLUSTER_NAME`
* Run `kubectl get services` to get the public address (EXTERNAL-IP) of the service
* Call the URL on `8080` port