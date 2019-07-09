# Hello world chart 
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

