 # Kubernetes
  -> Kubernetes coordinates a highly available cluster of computers that are connected to work as a single unit.

  -> allows you to deploy containerized applications to a cluster without tying them specifically to individual machines.

  -> automates the distribution and scheduling of application containers across a cluster in a more efficient way. 
  
  -> Control Plane (master node) coordinates/manages the cluster

  -> Nodes are the workers that run applications,  VM or a physical computer that serves as a worker machine in a Kubernetes cluster

  -> Each node has a Kubelet, which is an agent for managing the node and communicating with the Kubernetes control plane. The node should also have tools for handling container operations, such as containerd or Docker. 

  -> A Kubernetes cluster that handles production traffic should have a minimum of three nodes because if one node goes down, both an etcd member and a control plane instance are lost, and redundancy is compromised. You can mitigate this risk by adding more control plane nodes.

  -> The nodes communicate with the control plane using the Kubernetes API, 

  -> Minikube is a lightweight Kubernetes implementation that creates a VM on your local machine and deploys a simple cluster containing only one node.
  
  -> container runtime, kubelete, and kube-proxy runs on all worker and master node. Kubelete is responsible for API comm with master API server.

  -> API server, scheduler, kube controller manger, cloud contorller manager (interaction with cloud service provider wehere k8s cluster is run), etcd (service that manaages all logs) runs in master ndoe only.


## Pods
-> smallest unit of work load, shares volumes, and network space

-> may contain one or more container.
## Create deployment:
 -> Usually pods are not deployed manually, deployment is used

 -> pods grouped together in deployment, makes easier to scale

## Nodes:
  -> A Pod always runs on a Node. 

  -> A Node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster. Each Node is managed by the control plane. 

  -> must contain kubelet, and container runtime.

## Services:

  -> use to expose services from inside pods.

## scalibility:

  -> scaling with replicas



## Updates
**Rolling updates** allow Deployments' update to take place with zero downtime by incrementally updating Pods instances with new ones. The new Pods will be scheduled on Nodes with available resources.

**NOTE: have multiple replicas before hand**


## Common workflow

1. .\minikube.exe --driver=docker|virtualbox start  // to start minikube

2. minikube ip  // gets minikube ip

3. ssh docker@192.168.49.2 (will not work when run in docker)
  minikube ssh

4. docker ps  // list dokcer containers inside minikube

5. kubectl cluster-info

6. kubectl get namespaces

 namespaces used to group different resources and objects

 kubectl get pods --namespace=kube-system

7. kubectl run {pod_name} --image=nginx  # create a pod, pulls the image and runs it, difficult in scaling


8.  kubectl describe pod {pod_name}

  /puase locks namespace for the pod

  To get inside the container
  minikube ssh, get the container id and exec into it

9. kubectl get pods -o wide

10. kubectl delete pod  {name}

11. k create deployment nginx-deployment --image=nginx
  k get deployments

  selectors connect pods to deployments, replicas  quantity of pods

  podsname start with name of replica set
  replica-set-hash
  replica-set-hash21
12. k scale deployment nginx-deployment --replicas=2
  
13. k expose deployment nginx-deployment --port=8080 --target-port=80
  port 8080 will be exposed outside mapping to internal port of 80


services = connect to deployments, 

cluster IP, only connect within these clusters, a signle ip for entier IP address, only accessible via any k8s node inside the cluster

external IP address, open deployment to outside IP addresses

14. kubectl create deployment name --image=nishan8583/k8s_test

k delete deployment nginx-deployment

15. kubectl expose deployment nishan-hello --type=NodePort --port=8080
  map internal port 8080, chek which random port is mapped via command

  kubectl get svc

13. kubectl expose deployment nishan-hello --type=LoadBalancer --port=8080

 get random port, in cloud external ip will not be pending

 14. Rolling Update, pods will be replaced one by one, obviously need replicas
 kubectl.exe set image deployment k8s-test k8s-test=nishan8583/k8s-test:2.0.0

 this wierd requirement, deployment name and image name must be same for some reason, here deployment name is same as image name k8s-test

 15. minikube dashboard

 16. declarative approach, yaml config files

 17. kubectl delete all --all  // delete everything in default namespace

 18. Declarative deployment: see the yaml files.

 kubectl.exe apply -f file_path.yaml
 
 kubectl.exe delete -f file_path.yaml

 selector: matchabale, describe which pods will be managed by this deployment, label must be same in pods and selector
 500m half the cpu core, 240m 1/4th of CPU core

 reference: https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/
 https://kubernetes.io/docs/reference/kubernetes-api/service-resources/

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



