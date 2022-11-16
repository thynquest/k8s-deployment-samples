Rolling-update deployment
=================

## Steps to follow

1. version 1 is serving traffic
1. deploy version 2
1. wait until all replicas are replaced with version 2

## In practice

```bash
# Deploy the first application
$ kubectl apply -f app-v1.yaml

# Test if the deployment was successful
$ kubectl port-forward svc/reply-server 8081:89 8080:80
$ curl http://localhost:8080

# launch the `check.sh` script
$ ./check.sh

# Then deploy version 2 of the application
$ kubectl apply -f app-v2.yaml

# In case you discover some issue with the new version, you can undo the
# rollout ==> HOW ??


# If you can also pause the rollout if you want to run the application for a
# subset of users ==> HOW ??


# Then if you are satisfied with the result, resume rollout ==> HOW ??
```

### Cleanup

```bash
$ kubectl delete all -l app=reply-server
```
