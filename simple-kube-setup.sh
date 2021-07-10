echo "Make sure you update the domain name in the sample-ingress and update the dns of the domain to point the host ip"
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
kubectl apply -f ./
# To uninstall k3s
# /usr/local/bin/k3s-uninstall.sh
