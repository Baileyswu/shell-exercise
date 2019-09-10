#! /bin/sh

AKS_PERS_STORAGE_ACCOUNT_NAME=xxx (no encode)
STORAGE_KEY=xxx


kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=$AKS_PERS_STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$STORAGE_KEY
