#!/bin/bash
cd .infra/terraform && terraform apply -auto-approve
sleep 300
curl -X POST "http://meleeman:$JENKINSTOKEN@localhost:8080/job/odoo-project/build"
