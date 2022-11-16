Blue/green deployment to release a single service
=================================================

> In this example, we release a new version of a single service using the
blue/green deployment strategy.

## Steps to follow

1. version 1 is serving traffic
1. deploy version 2
1. wait until version 2 is ready
1. switch incoming traffic from version 1 to version 2
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

# Then deploy version 2 of the application
$ kubectl apply -f app-v2.yaml

# Wait for all the version 2 pods to be running
$ kubectl rollout status deploy reply-server-v2 -w
deployment "reply-server-v2" successfully rolled out

# Side by side, 3 pods are running with version 2 but the service still send
# traffic to the first deployment.

# If necessary, you can manually test one of the pod by port-forwarding it to
# your local environment:
$ kubectl port-forward <name of pod> 8080:8080

# Once your are ready, you can switch the traffic to the new version by patching
# the service to send traffic to all pods with label version=v2.0.0
$ kubectl patch service reply-server -p '{"spec":{"selector":{"version":"v2.0.0"}}}'

# Test if the second deployment was successful ==> HOW ??


# In case you need to rollback to the previous version ==> HOW ??

# If everything is working as expected, you can then delete the v1.0.0 ==> HOW ?
# deployment
```

### Cleanup

```bash
$ kubectl delete all -l app=reply-server
```
