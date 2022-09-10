# Kubernetes one-liners

## Table of contents

* [Get pod init containers](#get-pod-init-containers)  
* [Get pod containers](#get-pod-containers)  

### Get pod init containers

```bash
# with jq
kubectl get -o json po pod_name | jq '.spec.initContainers[] | .name'

# with jsonpath
kubectl get po pod_name -o jsonpath="{.spec['containers','initContainers'][*].name}"
```

### Get pod containers

```bash
# with jq
kubectl get -o json po pod_name | jq '.spec.containers[] | .name'

# with jsonpath
kubectl get po pod_name -o jsonpath="{.spec['containers','containers'][*].name}"
```