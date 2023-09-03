title "AzureRM Storage Account"

storage_account_name = attribute('storage_account_name')
storage_account_id   = attribute('storage_account_id')
# you add controls here
control "azurerm_storage_account" do
  title "AzureRM Storage Account"
  desc "An optional description..."
  describe azurerm_storage_account(resource_id: storage_account_id) do
    it { should exist }
    its('properties.provisioningState') { should cmp "Succeeded" }
  end
end
