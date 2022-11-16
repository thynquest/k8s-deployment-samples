Recreate deployment
===================

## Steps to follow

1. version 1 is service traffic
1. delete version 1
1. deploy version 2
1. wait until all replicas are ready

## In practice

```
# upload your image on your cluster
$ kind load docker-image myapp/reply-server --name mycluster

# Deploy the first application
$ kubectl apply -f app-v1.yaml

# Test if the deployment was successful
$ kubectl port-forward svc/reply-server 8081:89 8080:80
$ curl http://localhost:8080

# launch the `check.sh` script
$ ./check.sh

# Then deploy version 2 of the application
$ kubectl apply -f app-v2.yaml
```

### Cleanup

```bash
$ kubectl delete all -l app=reply-server
```
