echo "Make sure you update the domain name in the sample-ingress and update the dns of the domain to point the host ip"
# ipcheck=$(dig +short sample.app)
sudo true
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# Install Arcade
curl -sLS https://dl.get-arkade.dev | sudo sh
# Install krew, helm
arkade get helm
arkade get krew
export PATH=$PATH:$HOME/.arkade/bin/
sudo mv $HOME/.arkade/bin/krew /usr/local/bin/
sudo mv $HOME/.arkade/bin/helm /usr/local/bin/
arkade install cert-manager
echo "Waiting for cert-manager to become ready ..."
kubectl wait --for=condition=ready pod -l app=webhook -n cert-manager
kubectl apply -f ./
# To uninstall k3s
# /usr/local/bin/k3s-uninstall.sh

# To Integrate the cluster with gitlab follow the steps at
# https://betterprogramming.pub/using-a-k3s-kubernetes-cluster-for-your-gitlab-project-b0b035c291a9
# kubectl create secret docker-registry regcred --docker-server=registry.gitlab.com --docker-username=<username> --docker-password=<password> -n prod
# kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "regcred"}]}'
