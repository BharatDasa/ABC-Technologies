#!/bin/bash

###############################################################################
# ABC-Technologies
#
# Cleanup Script
#
# Purpose:
# Clean temporary deployment artifacts and display the final deployment status.
#
###############################################################################

set -e

echo "========================================================="
echo " ABC-Technologies Cleanup Started"
echo "========================================================="

echo ""
echo "Running Ansible Cleanup..."
ansible-playbook ansible/playbooks/cleanup.yml

echo ""
echo "========================================================="
echo " Kubernetes Resources"
echo "========================================================="

echo ""
echo "Namespace:"
kubectl get namespace abc-technologies

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
echo " Application URL"
echo "========================================================="

echo "https://abc.192.168.56.100.nip.io"

echo ""
echo "========================================================="
echo " Cleanup Completed Successfully"
echo "========================================================="