Canary deployment
==========================================================


## Steps to follow

1. 10 replicas of version 1 is serving traffic
1. deploy 1 replicas version 2 (meaning ~10% of traffic)
1. wait enought time to confirm that version 2 is stable and not throwing
   unexpected errors
1. scale up version 2 replicas to 10
1. wait until all instances are ready
1. shutdown version 1

## In practice

```bash
# upload your image on your cluster
$ kind load docker-image myapp/reply-server --name mycluster

# Deploy the first application
$ kubectl apply -f app-v1.yaml

# Test if the deployment was successful
$ kubectl port-forward svc/reply-server 8081:89 8080:80
$ curl http://localhost:8080

# launch the `check.sh` script
$ ./check.sh

# Then deploy version 2 of the application and scale down version 1 to 9 replicas at same time
$ kubectl apply -f app-v2.yaml
$ ???

# Only one pod with the new version should be running. => TEST IT

# If you are happy with it, scale up the version 2 to 10 replicas
$ ???

# Then, when all pods are running, you can safely delete the old deployment
$ kubectl delete deploy reply-server-v1
```

### Cleanup

```bash
$ kubectl delete all -l app=my-app
```
