# Helm Charts Repository

This repository contains the Helm charts used to deploy the applications running in this Home Lab Kubernetes environment.

The deployment strategy described in [`raspi-k3s-jenkins`](https://github.com/MyProgrammingProjects/raspi-k3s-jenkins) exposed an important operational issue during CI/CD execution: when multiple Jenkins pipelines attempted to update deployment manifests simultaneously, Git conflicts occurred because independent pipelines were modifying the same repository concurrently.

This happened because:

* pipelines committed changes independently,
* while sharing a single manifests repository.

As a result, the architecture evolved toward:

* repository separation,
* isolation between application source code and deployment manifests,
* and independent deployment ownership per application.

In the actual Home Lab environment, each application deployment manifest is maintained in an isolated repository. This prevents concurrent Jenkins pipelines from modifying the same Git repository and eliminates cross-application Git conflicts during automated image tag updates.

However, for documentation and code sharing purposes, this repository consolidates all Helm charts into a single public repository, while still keeping them logically separated by folders to reflect the operational repository structure used in the cluster environment.

This repository should therefore be viewed as a consolidated reference repository rather than the exact operational GitOps repository layout used internally by the Home Lab.


## Repository Structure

The repository is organized as follows:

* `accounts-service`
  Helm chart for the Accounts service.
  The image tag is automatically updated during the Jenkins CI pipeline execution for the application available in [`AccountsApi`](https://github.com/MyProgrammingProjects/raspi-k3s-applications/tree/main/src/Apis/AccountsApi).

* `users-service`
  Helm chart for the Users service.
  The image tag is automatically updated during the Jenkins CI pipeline execution for the application available in [`UsersApi`](https://github.com/MyProgrammingProjects/raspi-k3s-applications/tree/main/src/Apis/UsersApi).

* `search-service`
  Helm chart for the Search service.
  The image tag is automatically updated during the Jenkins CI pipeline execution for the application available in [`SearchApi`](https://github.com/MyProgrammingProjects/raspi-k3s-applications/tree/main/src/Apis/SearchApi).

* `gateway-service`
  Helm chart for the API Gateway service.
  The image tag is automatically updated during the Jenkins CI pipeline execution for the application available in [`Gateway`](https://github.com/MyProgrammingProjects/raspi-k3s-applications/tree/main/src/Gateway).

## Database Deployment

The repository also contains the `db` Helm chart.

This chart is responsible for deploying PostgreSQL into the Kubernetes cluster using a StatefulSet resource.

Although this chart is still deployed through GitOps using Argo CD, it is not modified by Jenkins pipelines during CI execution.

For production-grade Kubernetes environments, database Operators are usually more appropriate than manually managed StatefulSets, since they provide capabilities such as:

* automated failover,
* backup orchestration,
* replication management,
* and lifecycle automation.

However, for this Home Lab environment, a simplified Helm-based deployment was intentionally chosen to reduce operational complexity.

## Cloudflare Tunnel Resources

This repository also contains the `cloudflare_tunnel` directory.

Although it is not a Helm chart, this directory contains:

* the Deployment responsible for establishing the Cloudflare Tunnel,
* and the Ingress resources used for internal cluster traffic routing.

For the complete platform architecture and infrastructure overview, refer to [`raspi-k3s-platform`](https://github.com/MyProgrammingProjects/raspi-k3s-platform).



