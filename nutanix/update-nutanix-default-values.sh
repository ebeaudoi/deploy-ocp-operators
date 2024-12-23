#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
NUTANIX_CHANNEL="stable"
CERTCATALOG="my-redhat-v413-catalog"
PRISM_ISCSI_IP="10.10.10.10"
PRISM_STORAGE_NAME="os-storage"
PRISM_EL_LOGIN="10.10.17.90:9440:username:password"

# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp storageclass/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp storageclass/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}

######################
# Showing new values #
echo "-----------------------------"
echo "Channel = $NUTANIX_CHANNEL"
echo "Catalog = $CERTCATALOG"
echo "PRISM ISCSI = $PRISM_ISCSI_IP"
echo "PRISM Storage = $PRISM_STORAGE_NAME"
echo "PRISM Element = $PRISM_EL_LOGIN"
echo "-----------------------------"

#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
echo "Update the subscription - operator/overlay/airgapped/kustomization.yaml"
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $NUTANIX_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CERTCATALOG/g }" operator/overlay/airgapped/kustomization.yaml

##########################################
# Update Storage Class overlay yaml file #
  # Update the PRISM Element ISCSI IP
echo ""
echo "Update the PRISM Element ISCSI IP - storageclass/overlay/airgapped/kustomization.yaml"
sed -i "/path:\ \/parameters\/dataServiceEndPoint/{ n; s/value: .*$/value: $PRISM_ISCSI_IP/g }" storageclass/overlay/airgapped/kustomization.yaml
  # Update the PRISM Element storage name
echo ""
echo "Update the PRISM Element storage name - storageclass/overlay/airgapped/kustomization.yaml"
sed -i "/path:\ \/parameters\/storageContainer/{ n; s/value: .*$/value: $PRISM_STORAGE_NAME/g }" storageclass/overlay/airgapped/kustomization.yaml
  # Update the PRISM Element login information
echo ""
echo "Update the PRISM Element login information - storageclass/overlay/airgapped/kustomization.yaml"
sed -i "/path:\ \/stringData\/key/{ n; s/value: .*$/value: $PRISM_EL_LOGIN/g }" storageclass/overlay/airgapped/kustomization.yaml

