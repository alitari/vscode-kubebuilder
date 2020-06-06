export GOPATH="/go"
sudo setfacl -m user:vscode:rw /var/run/docker.sock
helm repo add stable https://kubernetes-charts.storage.googleapis.com/