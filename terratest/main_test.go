package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/azure"
)


func TestStaticSite(t *testing.T) {
	// retryable errors in terraform testing.

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	resourceGroupName := "<resourcegroup name>"
	subscriptionId    := "subscription id"

	expectedStorageName  := "tfinttestepm20230901"
	storage_account_name := terraform.Output(t, terraformOptions, "storage_account_name")
	assert.Equal(t, expectedStorageName, storage_account_name)

	StorageAccountExists  := azure.StorageAccountExists(t, expectedStorageName, resourceGroupName, subscriptionId )
	assert.True(t, StorageAccountExists, "Storage Account not exist")

	StorageBlobContainerImagesExists  := azure.StorageBlobContainerExists(t, "images", expectedStorageName, resourceGroupName, subscriptionId )
	assert.True(t, StorageBlobContainerImagesExists, "Container images not exist")

	StorageBlobContainerReportsExists  := azure.StorageBlobContainerExists(t, "reports", expectedStorageName, resourceGroupName, subscriptionId )
	assert.True(t, StorageBlobContainerReportsExists, "Container reports not exist")
}