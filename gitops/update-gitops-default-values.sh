#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
CHANNEL="latest"
CATALOG="redhat-operators"
#GITUSER="admin"
# Backup the files
cp operator/overlays/infra/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp instance/overlays/infra/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp example-instance/overlays/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
# Showing new values
echo "-----------------------------"
echo "Channel = $CHANNEL"
echo "Catalog = $CATALOG"
#echo "Git User = $GITUSER"
echo "-----------------------------"

#####################################
# Update operator overlays yaml file #
  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: operator/overlays/infra/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $CHANNEL/g }" operator/overlays/infra/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: operator/overlays/infra/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CATALOG/g }" operator/overlays/infra/kustomization.yaml

# Update gitops instance
  # Add users
#echo "-- Update instance users --"
#echo "File: example-instance/overlays/airgapped/kustomization.yaml"
#sed -i "/path:\ \/users/{ n; s/value: .*$/value: $GITUSER/g }" example-instance/overlays/airgapped/kustomization.yaml

