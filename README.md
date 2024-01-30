# deploy-ocp-operators
- Description

Those kustomization has been created to deploy Openshift operators in an air-gapped environment

In each opertor folder, you can find an update script use to update the kustomization.yaml files

# See below the details for each operator

### Nutanix Operator/Instance/Storage class
- Update the air-gapped kustomize file
   - cd nutanix
   - operator/overlay/airgapped/kustomization.yaml
      - Update the channel 
      - RH catalog name 

   - storageclass/overlay/airgapped/kustomization.yaml
     - Update the PRISM iscsi 
     - Storage name
     - The login information values

- Deploy
  - Operator
  
    oc create -k operator/overlay/airgapped/

  -  Instance
  
    oc create -k instance/base/

  - Storage Class
  
    oc create -k storageclass/overlay/airgapped/

- Monitor Nutanix Operator installation

  oc get all -n openshift-cluster-csi-drivers

### RHACM operator/Instance
- ACM Operator on INFRA node
  - Update the air-gapped kustomize file
    - cd rhacm
    - operator/overlays/airgapped/kustomization.yaml
      - Update the channel
      - RH catalog name

    - instance/overlay/airgapped/kustomization.yaml 
      - Update the mce-subscription-spec value

    - observability/overlay/airgapped/kustomization.yaml
      - Update the ose-cli image value from the private Quay

  - Deploy
    - Operator
    
    oc create -k operator/overlay/airgapped/
    - Instance
    
    oc create -k instance/overlay/airgapped/
  
  - Monitor RHACM Operator installation
  
    oc get pods -w -n open-cluster-management

### Obesrvability  (ACM)

    - Observability
    oc create -k observability/overlay/airgapped/
  
    - Monitor
    oc get pods -w -n open-cluster-management-observability

### Devspaces operator/Instance
- Devspaces Operator - all namespace
  - Update the air-gapped kustomize file
    - under devspaces
      - Update the Operator/overlay/airgapped/kustomization.yaml
        - Update the channel 
        - Update the RH catalog name

  - Deploy the devspace components
    - Operator
      - oc apply -k operator/overlay/airgapped/

    - Instance
      - oc apply -k instance/overlay/airgapped

  - Monitor
    - oc get pods -n openshift-devspaces -w

### Single Sign-On operator/Instance
- Single Sign-On Operator - sso namespace
  - Update the air-gapped kustomize file
    - under rhsso
      - Update the Operator/overlay/airgapped/kustomization.yaml
        - Update the channel 
        - Update the RH catalog name
        - Upadte the postgresql-10 (from private Quay)

  - Deploy the devspace components
    - Operator
      - oc apply -k operator/overlay/airgapped/

    - Instance
      - oc apply -k instance/overlay/airgapped/

  - Monitor
    - oc get pods -n sso -w

### logging/loki operators/instances

  - Use the README file under logging folder for all the details
  
### ODF operator/Instance
  Note: The "update-odf-default-values.sh" script can be used to update the default values
  
- ODF Operator on INFRA node
  - Update the air-gapped kustomize file
    - cd odf
    - operator/overlays/airgapped/kustomization.yaml
      - Update the channel
      - RH catalog name
      - ose_cli_image

    - noobaa/overlay/airgapped/kustomization.yaml 
      - Update the mce-subscription-spec value

  - Deploy
    - Operator
    
    oc create -k operator/overlay/airgapped/
    - Instance
    
    oc create -k noobaa/overlay/airgapped/
  
  - Monitor ODF Operator installation
  
    oc get pods -w -n openshift-storage

### RHACS operator/Instance
- ACS Operator on INFRA node
  - Update the air-gapped kustomize file
    - cd rhacs
    - operator/overlays/airgapped/kustomization.yaml
      - Update the channel
      - RH catalog name

    - central-secure-instance/overlay/airgapped/kustomization.yaml
      - Update the channel
      - RH catalog name
      - Update the ose-cli image value from the private Quay

  - Deploy
    - Operator

    oc create -k operator/overlay/airgapped/
    - Central and secured cluster

    oc create -k central-secure-instance/overlay/airgapped/

  - Monitor RHACS Operator installation

    oc get pods -w -n rhacs-operator

### Elasticsearch operator
- Update the air-gapped kustomize file
  - Option 1 - Using update-elasticsearch-default-values.sh
    - Edit the script and update those values:
      CHANNEL="stable-5.8"
      CATALOG="cs-my-redhat-catalog"
    - Run the script
      ./update-elasticsearch-default-values.sh

- Option 2 - Manually - Under elasticsearch folder

  overlays/airgapped/kustomization.yaml
    Update the channel 
    Update the RH catalog name

- Deploy the operator components
  - Operator
    oc apply -k overlays/airgapped/

  - Monitor
    oc get all -n openshift-operators-redhat

### Jaeger operator
- Update the air-gapped kustomize file
  - Option 1 - Using update-jaeger-default-values.sh
    Edit the script and update those values:
    CHANNEL="stable"
    CATALOG="cs-my-redhat-catalog"
  - Run the script
    ./update-jaeger-default-values.sh

- Option 2 - Manually - Under jaeger folder
  overlays/airgapped/kustomization.yaml
    Update the channel 
    Update the RH catalog name

- Deploy the operator components
  oc apply -k overlays/airgapped/

- Monitor
  oc get all -n openshift-distributed-tracing

### Jaeger operator
- Update the air-gapped kustomize file
  - Option 1 - Using update-kiali-op-default-values.sh
    - Edit the script and update those values:
      CHANNEL="stable"
      CATALOG="cs-my-redhat-catalog"
    - Run the script
      ./update-kiali-op-default-values.sh

  - Option 2 - Manually - Under kiali folder
    overlays/airgapped/kustomization.yaml
    - Update the channel 
    - Update the RH catalog name
- Deploy the operator components
  oc apply -k overlays/airgapped/
- Monitor
  oc get all -n openshift-operators

### ServiceMesh operator
- Installing ServiceMesh operator
  - Update the air-gapped kustomize file
    - Option 1 - Using update-servicemesh-default-values.sh
      - Edit the script and update those values:
        CHANNEL="stable"
        CATALOG="cs-my-redhat-catalog"
        startingCSV=”servicemeshoperator.v2.4.5”
      - Run the script
        ./update-servicemesh-default-values.sh

    - Option 2 - Manually - Under servicemesh folder
      operator/overlays/airgapped/kustomization.yaml
      - Update the channel 
      - Update the RH catalog name
      - Update startingCSV
- Deploy the operator components
  oc apply -k operator/overlays/airgapped/
- Monitor
  oc get all -n openshift-operators

### Serverless operator
- Installing Serverless operator
  - Update the air-gapped kustomize file
    - Option 1 - Using update-serverless-default-values.sh
      - Edit the script and update those values:
        CHANNEL="stable"
        CATALOG="cs-my-redhat-catalog"
      - Run the script
        ./update-serverless-default-values.sh

    - Option 2 - Manually - Under serverless folder
      operator/overlays/airgapped/kustomization.yaml
      - Update the channel 
      - Update the RH catalog name
- Deploy the operator components
  oc apply -k operator/overlays/airgapped/
- Monitor
  oc get all -n openshift-serverless

### Pipeline operator
- Installing Pipeline operator
  - Update the air-gapped kustomize file
    - Option 1 - Using update-pipeline-op-default-values.sh
      - Edit the script and update those values:
        CHANNEL="latest"
        CATALOG="cs-my-redhat-catalog"
      - Run the script
        ./update-pipeline-op-default-values.sh

    - Option 2 - Manually - Under pipeline folder
      overlays/airgapped/kustomization.yaml
      - Update the channel 
      - Update the RH catalog name

- Deploy the operator components
  oc apply -k overlays/airgapped/

- Monitor
  oc get all -n openshift-operators

### Openshift Data Science (rhods)
- Installing Openshift Data Science (rhods)
  - Prerequisite:
    - Pipeline operator
    - Serverless operator
    - Servicemesh operator
      - Elasticsearch operator
      - Jaeger operator
      - Kiali operator
    - References:
      - Servicemessh https://docs.openshift.com/container-platform/4.14/service_mesh/v1x/installing-ossm.html
      - RHODS https://access.redhat.com/documentation/en-us/red_hat_openshift_ai_self-managed/2.5/html-single/installing_and_uninstalling_openshift_ai_self-managed_in_a_disconnected_environment/index

  - Update the air-gapped kustomize file
    - Option 1 - Using update-rhods-default-values.sh
      - Edit the script and update those values:
        CHANNEL="stable"
        CATALOG="cs-my-redhat-catalog"
      - Run the script
        ./update-rhods-default-values.sh

    - Option 2 - Manually - Under rhods folder
      operator/overlays/airgapped/kustomization.yaml
      - Update the channel 
      - Update the RH catalog name
- Deploy the operator components
  oc apply -k operator/overlays/airgapped/

- Note - The following projects will be created
  redhat-ods-applications
  redhat-ods-monitoring
  Redhat-ods-operator
- Deploy the instance components
  oc apply -k instance/overlays/airgapped/
- Monitor
  - Operator
    oc get pods -w -n redhat-ods-operator
  - Instance
    oc get pods -n redhat-ods-applications

### gitops operator
- Installing gitops operator
  - Update the air-gapped kustomize file
    - Option 1 - Using update-gitops-default-values.sh
      - Edit the script and update those values:
        CHANNEL="latest"
        CATALOG="cs-my-redhat-catalog"
      - Run the script
        ./update-gitops-default-values.sh

    - Option 2 - Manually - Under pipeline folder
      operator/overlays/airgapped/kustomization.yaml
      - Update the channel
      - Update the RH catalog name

- Deploy the operator components
  oc apply -k operator/overlays/airgapped/

- Monitor
  - Operator
    oc get pods -n openshift-gitops-operator
  - Default ARGOCD
    Oc get pods -n openshift-gitops

