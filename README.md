# hello-world
Simple  application to deploy in kubernetes with basic configuration files and a helm chart.
The application consiste of serving a simple file "index.html" with apache. Deploying this application will generate three replica-set which can be modified inside the `deployment.yaml` or just run `kubectl scale deployment "deployementname" --replicas=x` where `x` is the desired pod number. 
# Build
In order to deploy this application you need first to build the docker image: 
  - Clone this project and run inside the project `docker build -t image-name:tag .` 
  - Push the generated docker image to your docker registry. 
  - Change the image name isnide the `deployement.yaml` to match the generated docker image.
# Deploy
To deploy this application with basic configurations files run the following commands: 

   ` kubectl create -f deployment.yaml -n yournamespace `  
   ` kubectl create -f svc.yaml -n yournamespace`
# Deploy with Chart
This chart was only tested with ` helm v3 `, to use it run : ` helm install ./hello-world --name-template=deploymentname -set image.repository="yourimage" --set image.tag="yourtag" ` or change manualy the image name and tag in ` templates/deployment.yaml ` to match the generated image.

# Access the application 
This application was tested in OKD 3.11 (Openshift origin), no extra configuration is needed if you're running on OKD, you need only to create a route for the service to be able to access it from outside the cluster. 
If you don't have a Loadbalancer in your cluster you may consider using NodePort or install a LoadBalancer like [MetalLB] (https://metallb.universe.tf) to your cluster. 
 
