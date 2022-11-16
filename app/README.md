Affichage du hostname et de la version
====================================================

> GoLang webserver which purpose is to reply with the hostname and if existing,
the environment variable VERSION.

## Getting started

### Development
```
$ cd app
$ go run main.go
```

### Docker

#### Build

```
$ cd app
$ docker build -t myapp/reply-server . 
```

#### Run

```
$ docker run -d \
    --name reply-server \
    -p 8080:8080 \
    -p 8086:8086 \
    -p 9101:9101\
    -e VERSION=v1.0.0
    myapp/reply-server
```

#### Test

```
$ curl localhost:8080
2018-01-28T00:22:04+01:00 - Host: host-1, Version: v1.0.0
```

Liveness and readiness probes are replying on `:8086/live` and `:8086/ready`.

Prometheus metrics are served at `:9101/metrics`.

#### Cleanup

```
$ docker stop reply-server
```
