 # Kubernetes
  -> Kubernetes coordinates a highly available cluster of computers that are connected to work as a single unit.
  -> allows you to deploy containerized applications to a cluster without tying them specifically to individual machines.
  -> automates the distribution and scheduling of application containers across a cluster in a more efficient way. 
  -> Control Plane coordinates/manages the cluster
  -> Nodes are the workers that run applications,  VM or a physical computer that serves as a worker machine in a Kubernetes cluster
  -> Each node has a Kubelet, which is an agent for managing the node and communicating with the Kubernetes control plane. The node should also have tools for handling container operations, such as containerd or Docker. 
  -> A Kubernetes cluster that handles production traffic should have a minimum of three nodes because if one node goes down, both an etcd member and a control plane instance are lost, and redundancy is compromised. You can mitigate this risk by adding more control plane nodes.
  -> The nodes communicate with the control plane using the Kubernetes API, 
  -> Minikube is a lightweight Kubernetes implementation that creates a VM on your local machine and deploys a simple cluster containing only one node.
    
## Create deployment:
 -> Deploy an app using Kubernetes Deployment configuration
 -> If the Node hosting an instance goes down or is deleted, the Deployment controller replaces the instance with an instance on another Node in the cluster
 -> A Pod is the basic execution unit of a Kubernetes application. Each Pod represents a part of a workload that is running on your cluster.
 -> kubectl is a command line tool to interact with kuberneter cluster
 -> kubectl get nodes --help
 -> kubectl --help
 -> kubectl get nodes  // gets all nodes in a cluster
 -> kubectl get pods
 -> 

 -> deploy app kubectl create deployment <deploy_name> --image=<full docker image path> // the command, searches for node that can run
 the app, schedlues the app to run, configured the cluster to reschedule the instance on a new Node when needed

 -> list deployments: kubectl get deployments

  -> Pods that are running inside Kubernetes are running on a private, isolated network. By default they are visible from other pods and services within the same kubernetes cluster, but not outside that network. When we use kubectl, we're interacting through an API endpoint to communicate with our application.


 -> The kubectl command can create a proxy that will forward communications into the cluster-wide, private network. The proxy can be terminated by pressing control-C and won't show any output while its running.

 ## Pods:
 -> A Pod is a Kubernetes abstraction that represents a group of one or more application containers (such as Docker), and some shared resources for those containers. Those resources include:

    Shared storage, as Volumes
    Networking, as a unique cluster IP address
    Information about how to run each container, such as the container image version or specific ports to use

  -> he containers in a Pod share an IP Address and port space, are always co-located and co-scheduled, and run in a shared context on the same Node.

  ->Pods are the atomic unit on the Kubernetes platform. When we create a Deployment on Kubernetes, that Deployment creates Pods with containers inside them (as opposed to creating containers directly). Each Pod is tied to the Node where it is scheduled, and remains there until termination (according to restart policy) or deletion. In case of a Node failure, identical Pods are scheduled on other available Nodes in the cluster.

## Nodes:
  -> A Pod always runs on a Node. 
  -> A Node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster. Each Node is managed by the control plane. 

Every Kubernetes Node runs at least:

    **Kubelet**, a process responsible for communication between the Kubernetes control plane and the Node; it manages the Pods and the containers running on a machine.
    **A container runtime (like Docker)** responsible for pulling the container image from a registry, unpacking the container, and running the application.


## Commands:
**kubectl get nodes --help**
**kubectl --help**
**kubectl get nodes**: gets all nodes in a cluster
**kubectl get pods**: gets all pods
**kubectl describe pods**: get detailed information about pods
// need to use proxy to get access to pods
**kubectl proxy**: starts a proxy
**export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')**: get pod name and store in variable
**curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/**: see output of application
echo Name of the Pod: $POD_NAM
**kubectl logs $POD_NAME**: view logs of a pod
**kubectl exec $POD_NAME -- {command to execute}**: execute a command in pod
**kubectl exec -ti $POD_NAME -- bash**: interactive bash session

