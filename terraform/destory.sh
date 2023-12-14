#!/bin/bash

# Initialize Terraform
terraform init

# Loop over all resources in the state
for resource in $(terraform state list); do
    # If the resource is not a database, destroy it
    if [[ $resource != "postgresql_database"* ]]; then
        echo "Destroying $resource"
        terraform state rm $resource
        terraform destroy -auto-approve -target=$resource
    fi
done

