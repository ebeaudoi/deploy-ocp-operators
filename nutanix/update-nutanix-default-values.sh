#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
NUTANIX_CHANNEL="stable"
RH_CATALOG="my-redhat-v413-catalog"
PRISM_ISCSI_IP="10.10.10.10"
PRISM_STORAGE_NAME="os-storage"
PRISM_EL_LOGIN="10.10.17.90:9440:username:password"
#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $NUTANIX_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RH_CATALOG/g }" operator/overlay/airgapped/kustomization.yaml

##########################################
# Update Storage Class overlay yaml file #
  # Update the PRISM Element ISCSI IP
sed -i "/path:\ \/parameters\/dataServiceEndPoint/{ n; s/value: .*$/value: $PRISM_ISCSI_IP/g }" storageclass/overlay/airgapped/kustomization.yaml
  # Update the PRISM Element storage name
sed -i "/path:\ \/parameters\/storageContainer/{ n; s/value: .*$/value: $PRISM_STORAGE_NAME/g }" storageclass/overlay/airgapped/kustomization.yaml
  # Update the PRISM Element login information
sed -i "/path:\ \/stringData\/key/{ n; s/value: .*$/value: $PRISM_EL_LOGIN/g }" storageclass/overlay/airgapped/kustomization.yaml

