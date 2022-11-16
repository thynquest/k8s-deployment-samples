Ramped deployment
=================

> Version B is slowly rolled out and replacing version A. Also known as
rolling-update or incremental.

![kubernetes ramped deployment](grafana-ramped.png)

The ramped deployment strategy consists of slowly rolling out a version of an
application by replacing instances one after the other until all the instances
are rolled out. It usually follows the following process: with a pool of version
A behind a load balancer, one instance of version B is deployed. When the
service is ready to accept traffic, the instance is added to the pool. Then, one
instance of version A is removed from the pool and shut down.

Depending on the system taking care of the ramped deployment, you can tweak the
following parameters to increase the deployment time:

- Parallelism, max batch size: Number of concurrent instances to roll out.
- Max surge: How many instances to add in addition of the current amount.
- Max unavailable: Number of unavailable instances during the rolling update
  procedure.

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
# rollout
$ kubectl rollout undo deploy reply-server

# If you can also pause the rollout if you want to run the application for a
# subset of users
$ kubectl rollout pause deploy reply-server

# Then if you are satisfied with the result, resume rollout
$ kubectl rollout resume deploy reply-server
```

### Cleanup

```bash
$ kubectl delete all -l app=reply-server
```
