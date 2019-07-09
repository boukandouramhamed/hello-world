# hello-world
Simple  application to deploy in kubernetes with basic configuration files and a helm chart.
The application consiste of serving a simple file "index.html" with apache. Deploying this application will generate three replica-set which can be modified inside the `deployment.yaml` or just run `kubectl scale deployment "deployementname" --replicas=x` where `x` is the desired pod number. 
# Build Docker Image
The Docker image used in this application is already pushed to [docker.hub](https://hub.docker.com/r/akymhd/httpd-centos)
To build this docker image clone the project and run  `docker build -t image-name:tag project_dir`

# Deploy
To deploy this application with basic configurations files run the following commands: 

   ` kubectl create -f deployment.yaml -n yournamespace `  
   ` kubectl create -f svc.yaml -n yournamespace`
# Deploy with Chart
This chart was only tested with ` helm v3 ` 
To use it run : ` helm install ./hello-world --name-template=deploymentname `

Parameter | Description | Default
---|---|---
`image.repository` | Repository for container image | docker.io/akymhd/httpd-centos
`image.tag`   | Image tag |  v3
`image.pullPolicy` | Image pull policy  | IfNotPresent
`replicaCount` | Number of replicas | 3

# Access the application 
This application was tested in OKD 3.11 (Openshift origin), no extra configuration is needed if you're running on OKD, you need only to create a route for the service to be able to access it from outside the cluster. 

If you don't have a Loadbalancer in your cluster you may consider using `NodePort` or install a LoadBalancer like [MetalLB](https://metallb.universe.tf) to your cluster. 

# Update:

To deploy new version of the application with no down time you need only to patch the deployment to point to the new docker image. 

In case you want to rollback to a previous version use:

 `kubectl rollout history deployment "yourdeployement` to check all the available version.

 `kubectl rollout undo deployment hello-world --to-revision=x` where `x` is the desired version.
