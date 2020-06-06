# vscode-kubebuilder

Start right away with a development environment for [kubebuilder](https://github.com/kubernetes-sigs/kubebuilder) using [Visual Studio Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers).

## Preparation steps

We assume you have a running docker daemon and a working connection to a kubernetes cluster.

1. [configure vscode in order to be able to use Visual Studio Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers#_installation)
2. configure connection to your k8s cluster: copy your kubernetes config file to the `.devcontainer` directory. e.g. `cp ~/.kube/config .devcontainer`
3. use this repo as remote container: Press <kbd>F1</kbd> and select the Remote-Containers: Open Folder in Container... command.

After vscode is has been setup ( can last a few minutes for the first time) check whether all tools are present:

```bash
# k8s cluster
kubectl cluster-info
# golang
go version
# docker
docker info
# kubebuilder
kubebuilder version
# kustomize
kustomize version
```

## create a project `guestbook` ( see [kubebuilder-book](https://book.kubebuilder.io/quick-start.html) for details)

### create new go module 

```bash
go mod init guestbook
```
### initialze project framework

```bash
kubebuilder init
```

### create API artefacts

```bash
kubebuilder create api --group webapp --version v1 --kind Guestbook
```

### install CRDs

```bash
make install
```

### run controller

standard with make `make run` or press <kbd>F5</kbd> for debugging with vscode

### install CR

```bash
kubectl apply -f config/samples/
```

### build controller image

```bash
make docker-build IMG=guestbook-controller:latest
```

### push controller image

You can skip this step when using local cluster. 
If you have push access rights to the registry:
```bash
make docker-push IMG=<registry>/guestbook-controller:latest
```

Here an example for using [docker hub](https://hub.docker.com/) (`docker.io`):

```bash
docker login
docker tag guestbook-controller:latest <dockerhub-username>/guestbook-controller:latest
make docker-push IMG=<dockerhub-username>/guestbook-controller:latest
```

### deploy controller on cluster

```bash
make deploy IMG=<dockerhub-username>/guestbook-controller:latest
```


