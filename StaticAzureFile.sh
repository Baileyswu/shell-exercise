#!/usr/bin/env bash

# Change these four parameters as needed for your own environment
AKS_PERS_STORAGE_ACCOUNT_NAME=mystorageaccount110
AKS_PERS_RESOURCE_GROUP=t-lidwu
AKS_PERS_LOCATION=eastus
AKS_PERS_SHARE_NAME=aksshare

# Create a resource group
# az group create --name $AKS_PERS_RESOURCE_GROUP --location $AKS_PERS_LOCATION

# Create a storage account
# az storage account create -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -l $AKS_PERS_LOCATION --sku Standard_LRS
# az storage account create -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP --sku Standard_LRS

# Export the connection string as an environment variable, this is used when creating the Azure file share
export AZURE_STORAGE_CONNECTION_STRING=`az storage account show-connection-string -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -o tsv`


# Check for the existence of a file share.
existed=$(az storage share exists -n $AKS_PERS_SHARE_NAME | jq .exists -r)
echo $existed
if [[ "$existed" == "false" ]]
then
    # Create the file share
    echo create a new file share
    az storage share create -n $AKS_PERS_SHARE_NAME --connection-string $AZURE_STORAGE_CONNECTION_STRING
fi


# Get storage account key
# STORAGE_KEY=$(az storage account keys list --resource-group $AKS_PERS_RESOURCE_GROUP --account-name $AKS_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Echo storage account name and key
# echo Storage account name: $AKS_PERS_STORAGE_ACCOUNT_NAME
# echo Storage account key: $STORAGE_KEY



# List the file shares in a storage account.
# az storage share list --connection-string $AZURE_STORAGE_CONNECTION_STRING

# Gets the approximate size of the data stored on the share, rounded up to the nearest gigabyte.
# az storage share stats -n $AKS_PERS_SHARE_NAME --connection-string $AZURE_STORAGE_CONNECTION_STRING

# Creates a new directory under the specified share or parent directory.
NEW_FOLDER=cat
existed=$(az storage directory exists -n $NEW_FOLDER -s $AKS_PERS_SHARE_NAME | jq .exists -r)
echo $existed
if [[ "$existed" == "false" ]]
then
    echo create a new directory
    az storage directory create -n $NEW_FOLDER -s $AKS_PERS_SHARE_NAME
fi

# Upload a file to a share that uses the SMB 3.0 protocol.
# FILE_NAME=`date +%Y%m%d%H%M%S`.log
# echo "hello" >> $FILE_NAME
# az storage file upload -s $AKS_PERS_SHARE_NAME/$NEW_FOLDER --source $FILE_NAME
# result=$(az storage file exists -p $NEW_FOLDER/$FILE_NAME -s $AKS_PERS_SHARE_NAME)
# echo result=$result

ALL_FILE=20190910091112.log
mkdir -p dest
az storage file download -p $NEW_FOLDER/$ALL_FILE -s $AKS_PERS_SHARE_NAME --dest dest/$ALL_FILE