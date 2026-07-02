#!/bin/bash

###############################################################################
# ABC-Technologies
#
# Deploy Script
#
# Purpose:
# Deploy the application to Kubernetes using Ansible.
#
###############################################################################

set -e

echo "========================================================="
echo " ABC-Technologies Deployment Started"
echo "========================================================="

echo ""
echo "Running Auto Fix..."
ansible-playbook ansible/playbooks/auto-fix.yml

echo ""
echo "Running Precheck..."
ansible-playbook ansible/playbooks/precheck.yml

echo ""
echo "Deploying Application..."
ansible-playbook ansible/playbooks/deploy.yml

echo ""
echo "Running Health Check..."
ansible-playbook ansible/playbooks/healthcheck.yml

echo ""
echo "Deployment completed successfully."

echo ""
echo "========================================================="
echo " Kubernetes Resources"
echo "========================================================="

kubectl get pods -n abc-technologies

echo ""

kubectl get svc -n abc-technologies

echo ""

kubectl get ingress -n abc-technologies

echo ""

kubectl get hpa -n abc-technologies

echo ""

kubectl get servicemonitor -n monitoring

echo ""
echo "========================================================="
echo " Deployment Completed Successfully"
echo "========================================================="