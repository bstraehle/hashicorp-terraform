```
ssh -i "<key-pair>.pem" ec2-user@<instance>.<region>.compute.amazonaws.com
```

```
export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
```

Run script in eks folder

```
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

Run script in kubernetes folder

```
kubectl get nodes,services,pods
```
