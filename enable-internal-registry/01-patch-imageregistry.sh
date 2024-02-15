#!/bin/bash

# Changing the image registry’s management state
echo ""
echo "Set the configs.imageregistry.operator managementState: Managed"
echo ""
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}}'

