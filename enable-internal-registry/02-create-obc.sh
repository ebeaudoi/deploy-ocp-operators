#!/bin/bash
#
echo
echo "Create obc-internal-imagery Object Storage class"
echo

cat <<EOF | oc apply -f -
apiVersion: objectbucket.io/v1alpha1
kind: ObjectBucketClaim
metadata:
  name: obc-internal-imagery
  namespace: openshift-storage
spec:
  storageClassName: ebdn-bucket-class
  generateBucketName: obc-internal-imagery
EOF
