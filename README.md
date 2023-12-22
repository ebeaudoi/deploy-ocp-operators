# deploy-ocp-operators
- Description
Those kustomization has been created to deploy Openshift operators in an air-gapped environment

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

### Obesrvability  - NOT READY TO USE
  
  oc create -k observability/overlay/airgapped/

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

### Deploy logging/loki operators/instances
    Move under logging folder 

  - Deploy the logging Operator (The console plugin will need to be enable manually)
    oc apply -k operator/overlays/airgapped/

  - Deploy loki
    oc apply -k loki/operator/overlay/airgapped/

  - create the loki Object storage
    oc create -f 01-create-logging-obc.yaml
  
  - create the loki obc password
    ./02-create-loki-obc-secret.sh
  
  - Deploy loki instance
    oc apply -k loki/instance/overlay/airgapped/
  
  - Monitor
    oc get pods,pvc -n openshift-logging
  
  - Deploy loggin instance
    oc apply -k instance/overlays/airgapped/
  
  - Enable RedHat OpenShift Logging plugin using CLI
    oc get consoles.operator.openshift.io cluster -o yaml |grep logging-view-plugin || oc patch consoles.operator.openshift.io cluster --type=merge --patch '{ "spec": { "plugins": ["logging-view-plugin"]}}'
  

