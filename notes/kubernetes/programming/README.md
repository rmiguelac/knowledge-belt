### The Control Loop

* Read the state of the resources (event-driven using watches)
* Change the state of objects in the cluster
* Update status of the resource in the step 1 via API server in the etcd.
* Repeat cycle