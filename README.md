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
`strategy.maxUnavailable` | Max unavailable pods number during the update. |  30%
`strategy.type` | |  RollingUpdate
`livenessProbe.initialDelaySeconds` | Initial time in secondsto wait before schedule hte first probe. | 10
`livenessProbe.periodSeconds` | Time in seconds to performe probe. | 11
`livenessProbe.successThreshold` |  Minimum consecutive successes for the probe to be considered successful after having failed. | 1
`livenessProbe.failureThreshold` |  Minimum consecutive failures for the probe to be considered failed after having succeeded. | 3
`readinessProbe.initialDelaySeconds` | Initial time in secondsto wait before schedule hte first probe. | 10
`readinessProbe.periodSeconds` | Time in seconds to performe probe. | 11
`readinessProbe.successThreshold` |  Minimum consecutive successes for the probe to be considered successful after having failed. | 1
`readinessProbe.failureThreshold` |  Minimum consecutive failures for the probe to be considered failed after having succeeded. | 3
`service.type` | Service type | ClusterIP
`service.port` | Service port | 8080

# Access the application 

`export deploymentname='yourdeploymentname'`

`export serviceaddress=kubectl get svc $deploymentname | awk 'NR>1 {print $3}'`

`export serviceport=$(kubectl get svc $deploymentname | awk 'NR>1 {print $5}' | sed 's/.\{4\}$//')`

`curl $serviceaddress:$serviceport`

##### Note that this is only accessible from inside the cluster.
##### In OKD (Openshift origin) you can create a route for the service to be able to access it from outside the cluster. 

##### In order to access this application from outside the cluster you need a `LoadBalancer`, if you don't have a `Loadbalancer` in your cluster you may consider using `NodePort` or install a LoadBalancer like [MetalLB](https://metallb.universe.tf) to your cluster. 

# Update:

To deploy new version of the application with no downtime you need only to patch the deployment to point to the new docker image. 

In case you want to rollback to a previous version use:

 `kubectl rollout history deployment "yourdeployement"` to check all the available version.

 `kubectl rollout undo deployment hello-world --to-revision=x` where `x` is the desired version.
