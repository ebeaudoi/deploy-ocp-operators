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

### Obesrvability 

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

