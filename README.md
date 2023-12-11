# deploy-ocp-operators
- Description
Those kustomization has been created to deploy Openshift operators in an air-gapped environment

# See below the details for each operator

### Nutanix Operator
- Update the air-gapped kustomize file
   - cd nutanix
   - operator/overlay/airgapped/kustomization.yaml

      Update the channel and RH catalog name 
   - storageclass/overlay/airgapped/kustomization.yaml

     Update the PRISM iscsi, storage name and the login information values

- Deploy
  - Operator
  
    oc create -k operator/overlay/airgapped/

  -  Instance
  
    oc create -k instance/base/

  - Storage Class
  
    oc create -k storageclass/overlay/airgapped/

- Monitor Nutanix Operator installation

  oc get all -n openshift-cluster-csi-drivers

### RHACM operator
- ACM Operator on INFRA node
  - Update the air-gapped kustomize file
    - cd rhacm
    - operator/overlays/airgapped/kustomization.yaml

      Update the channel and RH catalog name
    - instance/overlay/airgapped/kustomization.yaml 

      Update the mce-subscription-spec value
    - observability/overlay/airgapped/kustomization.yaml

      Update the ose-cli image value from the private Quay

- Deploy
  - Operator
  
  oc create -k operator/overlay/airgapped/
  - Instance
  
  oc create -k instance/overlay/airgapped/

### Storage Class  - NOT READY TO USE
  
  oc create -k observability/overlay/airgapped/

- Monitor Nutanix Operator installation

  oc get pods -w -n open-cluster-management




