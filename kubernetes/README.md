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


 -> deploy app kubectl create deployment {deploy_name} --image={full docker image path} // the command, searches for node that can run
 the app, schedlues the app to run, configured the cluster to reschedule the instance on a new Node when needed

 -> list deployments: kubectl get deployments

  -> Pods that are running inside Kubernetes are running on a private, isolated network. By default they are visible from other pods and services within the same kubernetes cluster, but not outside that network. When we use kubectl, we're interacting through an API endpoint to communicate with our application.


 -> The kubectl command can create a proxy that will forward communications into the cluster-wide, private network. The proxy can be terminated by pressing control-C and won't show any output while its running.

 ## Pods:
 -> A Pod is a Kubernetes abstraction that represents a group of one or more application containers (such as Docker), and some shared resources for those containers. Those resources include:

    Shared storage, as Volumes
    Networking, as a unique cluster IP address
    Information about how to run each container, such as the container image version or specific ports to use

  -> The containers in a Pod share an IP Address and port space, are always co-located and co-scheduled, and run in a shared context on the same Node.

  ->Pods are the atomic unit on the Kubernetes platform. When we create a Deployment on Kubernetes, that Deployment creates Pods with containers inside them (as opposed to creating containers directly). Each Pod is tied to the Node where it is scheduled, and remains there until termination (according to restart policy) or deletion. In case of a Node failure, identical Pods are scheduled on other available Nodes in the cluster.

## Nodes:
  -> A Pod always runs on a Node. 

  -> A Node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster. Each Node is managed by the control plane. 

Every Kubernetes Node runs at least:

    **Kubelet**, a process responsible for communication between the Kubernetes control plane and the Node; it manages the Pods and the containers running on a machine.

    **A container runtime (like Docker)** responsible for pulling the container image from a registry, unpacking the container, and running the application.


## Services:


Kubernetes Pods are mortal. Pods in fact have a lifecycle. When a worker node dies, the Pods running on the Node are also lost. 

A ReplicaSet might then dynamically drive the cluster back to desired state via creation of new Pods to keep your application running. As another example, consider an image-processing backend with 3 replicas. Those replicas are exchangeable; the front-end system should not care about backend replicas or even if a Pod is lost and recreated. That said, each Pod in a Kubernetes cluster has a unique IP address, even Pods on the same Node, so there needs to be a way of automatically reconciling changes among Pods so that your applications continue to function.

A Service in Kubernetes is an abstraction which defines a logical set of Pods and a policy by which to access them. Services enable a loose coupling between dependent Pods. A Service is defined using YAML (preferred) or JSON, like all Kubernetes objects. The set of Pods targeted by a Service is usually determined by a LabelSelector (see below for why you might want a Service without including selector in the spec).

Although each Pod has a unique IP address, those IPs are not exposed outside the cluster without a Service. Services allow your applications to receive traffic. Services can be exposed in different ways by specifying a type in the ServiceSpec:

    ClusterIP (default) - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.

    NodePort - Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>. Superset of ClusterIP.

    LoadBalancer - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.

    ExternalName - Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up. This type requires v1.7 or higher of kube-dns, or CoreDNS version 0.0.8 or higher.



Additionally, note that there are some use cases with Services that involve not defining selector in the spec. A Service created without selector will also not create the corresponding Endpoints object. This allows users to manually map a Service to specific endpoints. Another possibility why there may be no selector is you are strictly using type: ExternalName.



A Service routes traffic across a set of Pods. Services are the abstraction that allow pods to die and replicate in Kubernetes without impacting your application. Discovery and routing among dependent Pods (such as the frontend and backend components in an application) is handled by Kubernetes Services.

Services match a set of Pods using labels and selectors, a grouping primitive that allows logical operation on objects in Kubernetes. Labels are key/value pairs attached to objects and can be used in any number of ways:

    Designate objects for development, test, and production
    Embed version tags
    Classify an object using tags



Labels can be attached to objects at creation time or later on. They can be modified at any time. Let's expose our application now using a Service and apply some labels.

## scalibility:

Scaling is accomplished by changing the number of replicas in a Deployment



Scaling out a Deployment will ensure new Pods are created and scheduled to Nodes with available resources. Scaling will increase the number of Pods to the new desired state. 

Running multiple instances of an application will require a way to distribute the traffic to all of them. Services have an integrated load-balancer that will distribute network traffic to all Pods of an exposed Deployment. Services will monitor continuously the running Pods using endpoints, to ensure the traffic is sent only to available Pods.

Scaling is accomplished by changing the number of replicas in a Deployment.



## Updates
**Rolling updates** allow Deployments' update to take place with zero downtime by incrementally updating Pods instances with new ones. The new Pods will be scheduled on Nodes with available resources.

**NOTE: have multiple replicas before hand**


## Commands:
**kubectl get nodes --help**

**kubectl --help**

**kubectl get nodes**: gets all nodes in a cluster

**kubectl get pods**: gets all pods

**kubectl describe pods**: get detailed information about pods

**deploy app kubectl create deployment {deploy_name} --image={full docker image path}**: create a deployment
// need to use proxy to get access to pods

**kubectl proxy**: starts a proxy

**export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')**: get pod name and store in variable

**curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/**: see output of application

**kubectl logs $POD_NAME**: view logs of a pod

**kubectl exec $POD_NAME -- {command to execute}**: execute a command in pod

**kubectl exec -ti $POD_NAME -- bash**: interactive bash session

**kubectl get services**: gets all services

**kubectl expose deployment/{service_name} --type="NodePort" --port 8080**: 8080 will be mapped to something else

**kubectl describe services/{service_name}**: describe services


**export NODE_PORT=$(kubectl get services/{service_name} -o go-template='{{(index .spec.ports 0).nodePort}}')**: node that is exposed

**kubectl describe deployment**: describe deployment

**kubectl get pods -l app={{service_name}}**

**kubectl get services -l app={serv-ce_name}**: 

**kubectl label pods $POD_NAME key=value**: label a pod

**kubectl get pods -l version=v1**

**kubectl delete service -l app={service_name}**

**kubectl get rs**: shows DESIRED number of replicas and CURRENT number of replicas currently running.

**kubectl scale deployments/kubernetes-bootcamp --replicas=4**: increase number of replicas, basically increase number of pods runing
with every request a different pod is hit (load balancing). To scale down decrease number of replicas

**kubectl set image deployments/{deployment_name} {deployment_name}={different image}:v2**: for updating

**kubectl rollout undo deployments/{}**: to roll back to last working version