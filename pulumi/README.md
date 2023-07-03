# Pulumi

Run this locally:

```
pulumi stack init dev
pulumi preview
pulumi up
pulumi stack select dev
pulumi stack output kubeconfig --show-secrets > kubeconfig.json
KUBECONFIG=./kubeconfig.json kubectl get nodes

kubectl config view --minify -o 'jsonpath={.clusters[0].cluster.server}'

kubectl delete deployment hello-world-backend hello-world-frontend
kubectl delete service hello-world-backend hello-world-frontend

pulumi destroy --yes
# pulumi stack rm --yes
```