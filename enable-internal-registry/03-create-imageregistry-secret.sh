#!/bin/bash

# Get the bucket name by entering the following command:
bucket_name=$(oc get obc -n openshift-storage obc-internal-imagery -o jsonpath='{.spec.bucketName}')

# Get the AWS credentials by entering the following commands:
AWS_ACCESS_KEY_ID=$(oc get secret -n openshift-storage obc-internal-imagery -o yaml | grep -w "AWS_ACCESS_KEY_ID:" | head -n1 | awk '{print $2}' | base64 --decode)

AWS_SECRET_ACCESS_KEY=$(oc get secret -n openshift-storage obc-internal-imagery -o yaml | grep -w "AWS_SECRET_ACCESS_KEY:" | head -n1 | awk '{print $2}' | base64 --decode)

echo "---------------------------------------------------"
echo ""
echo "BUCKET_NAME= $bucket_name"
echo ""
echo "ACCESS_KEY_ID= $AWS_ACCESS_KEY_ID"
echo ""
echo "SECRET_ACCESS_KEY= $AWS_SECRET_ACCESS_KEY"
echo ""
echo "---------------------------------------------------"

# Create the secret image-registry-private-configuration-user with the AWS credentials for the new bucket under openshift-image-registry project by entering the following command:
oc create secret generic image-registry-private-configuration-user --from-literal=REGISTRY_STORAGE_S3_ACCESSKEY=${AWS_ACCESS_KEY_ID} --from-literal=REGISTRY_STORAGE_S3_SECRETKEY=${AWS_SECRET_ACCESS_KEY} --namespace openshift-image-registry

# Get the route host by entering the following command:
route_host=$(oc get route s3 -n openshift-storage -o=jsonpath='{.spec.host}')

# Create a config map that uses an ingress certificate by entering the following commands:
oc extract secret/router-certs-default  -n openshift-ingress  --confirm
oc create configmap image-registry-s3-bundle --from-file=ca-bundle.crt=./tls.crt  -n openshift-config

# Configure the image registry to use the Nooba object storage by entering the following command:
oc patch config.image/cluster -p '{"spec":{"managementState":"Managed","replicas":2,"storage":{"managementState":"Unmanaged","s3":{"bucket":'\"${bucket_name}\"',"region":"us-east-1","regionEndpoint":'\"https://${route_host}\"',"virtualHostedStyle":false,"encrypt":false,"trustedCA":{"name":"image-registry-s3-bundle"}}}}}' --type=merge


