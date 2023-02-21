```
ssh -i "DemoKeyPair.pem" ec2-user@ec2-54-202-47-195.us-west-2.compute.amazonaws.com
```

```
export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
```

Run script in eks folder

```
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

```
kubectl cluster-info
kubectl get nodes
```

Run script in kubernetes folder

```
kubectl get services,pods
```

```
scp -i DemoKeyPair.pem ec2-user@ec2-54-202-47-195.us-west-2.compute.amazonaws.com:/home/ec2-user/terraform-eks/*.tf c:/temp/
```
