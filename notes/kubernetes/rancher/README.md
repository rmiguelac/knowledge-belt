# Rancher

## Connect to unavailable cluster (kubectl)

The control-plane kubelet has a node `/etc/kubernetes/ssl/kubecfg-kube-node.yaml` file that can be used

```shell
alias kc='kubectl --kubeconfig kubecfg-kube-node.yaml -n cattle-system'
```

Then you can interact with a cluster even though you cannot get a new kubeconfig