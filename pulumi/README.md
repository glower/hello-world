# Pulumi

```
pulumi stack init dev
pulumi preview
pulumi up
pulumi stack select dev
pulumi stack output kubeconfig --show-secrets > kubeconfig.json
KUBECONFIG=./kubeconfig.json kubectl get nodes

kubectl delete deployment hello-world-backend hello-world-frontend
kubectl delete service hello-world-backend hello-world-frontend

pulumi destroy --yes
# pulumi stack rm --yes
```