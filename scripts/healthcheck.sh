#!/bin/bash

###############################################################################
# ABC-Technologies
#
# Health Check Script
#
# Purpose:
# Verify application health after deployment.
#
###############################################################################

set -e

echo "========================================================="
echo " ABC-Technologies Health Check Started"
echo "========================================================="

echo ""
echo "Running Ansible Health Check..."
ansible-playbook ansible/playbooks/healthcheck.yml

echo ""
echo "========================================================="
echo " Kubernetes Status"
echo "========================================================="

echo ""
echo "Deployment:"
kubectl get deployment -n abc-technologies

echo ""
echo "Pods:"
kubectl get pods -n abc-technologies -o wide

echo ""
echo "Service:"
kubectl get svc -n abc-technologies

echo ""
echo "Ingress:"
kubectl get ingress -n abc-technologies

echo ""
echo "HPA:"
kubectl get hpa -n abc-technologies

echo ""
echo "ServiceMonitor:"
kubectl get servicemonitor -n monitoring

echo ""
echo "========================================================="
echo " Application Health"
echo "========================================================="

curl -k -I https://abc.192.168.56.100.nip.io

echo ""
echo "========================================================="
echo " Health Check Completed Successfully"
echo "========================================================="