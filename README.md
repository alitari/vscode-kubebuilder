## configure connection to k8s cluster

Copy your kubernetes config file to the `.devcontainer` directory.
e.g. `cp ~/.kube/config .devcontainer`

Check wether all tools are present:

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

## create a project

```bash
go mod init guestbook

kubebuilder init

kubebuilder create api --group webapp --version v1 --kind Guestbook

# install CRDs
make install

# run controller
make run

# install CR
kubectl apply -f config/samples/

# build controller image
make docker-build IMG=guestbook:latest

# deploy
make deploy IMG=guestbook:latest
```