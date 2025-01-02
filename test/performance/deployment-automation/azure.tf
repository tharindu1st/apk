variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string

}
provider "azurerm" {
  features {}
  use_cli         = true
  subscription_id = var.subscription_id
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "key_vault_id" {
  description = "The name of the azure keyvault"
  type        = string
}
variable "resource_created_for" {
  description = "The name of the created_for tag"
  type        = string
}
variable "resource_created_by" {
  description = "The name of the created_by tag"
  type        = string
}
variable "build_number" {
  description = "build number"
  type        = string
}
# Retrieve the certificate from Key Vault
data "azurerm_key_vault_secret" "apk-perf-test-cert" {
  name         = "apk-perf-test-public-key"
  key_vault_id = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.KeyVault/vaults/%s",var.subscription_id,var.resource_group_name,var.key_vault_id)
}

# Retrieve the key from Key Vault
data "azurerm_key_vault_secret" "apk-perf-test-key" {
  name         = "apk-perf-test-private-key"
  key_vault_id = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.KeyVault/vaults/%s",var.subscription_id,var.resource_group_name,var.key_vault_id)
}

# Virtual Network (VPC)
resource "azurerm_virtual_network" "apk_perf_test_vpc" {
  name                = format("apk-perf-test-vpc-%s", var.build_number)
  address_space       = ["10.224.0.0/12"]
  location            = "Southeast Asia"
  resource_group_name = var.resource_group_name
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

# Subnet 1 - Default Subnet
resource "azurerm_subnet" "default_subnet" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.apk_perf_test_vpc.name
  address_prefixes     = ["10.224.0.0/16"]
}

# Subnet 2 - VM Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = "vm-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.apk_perf_test_vpc.name
  address_prefixes     = ["10.225.0.0/24"]
}
resource "azurerm_public_ip" "jmeter_server_1_ip" {
  name                = "apk-perf-test-jmeter-server-1-ip"
  resource_group_name = var.resource_group_name
  location            = "Southeast Asia"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
# Retrieve the public IP address
data "azurerm_public_ip" "jmeter_server_1_ip" {
  name                = azurerm_public_ip.jmeter_server_1_ip.name
  resource_group_name = var.resource_group_name
}
resource "azurerm_network_interface" "jmeter_server1_nic" {
  name                = format("apk-perf-test-jmeter-server1-nic-%s", var.build_number)
  location            = "Southeast Asia"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jmeter_server_1_ip.id
  }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

resource "azurerm_public_ip" "jmeter_server_2_ip" {
  name                = "apk-perf-test-jmeter-server-2-ip"
  resource_group_name = var.resource_group_name
  location            = "Southeast Asia"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# Retrieve the public IP address
data "azurerm_public_ip" "jmeter_server_2_ip" {
  name                = azurerm_public_ip.jmeter_server_2_ip.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "jmeter_server2_nic" {
  name                = format("apk-perf-test-jmeter-server2-nic-%s", var.build_number)
  location            = "Southeast Asia"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jmeter_server_2_ip.id
  }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}
resource "azurerm_network_interface" "jmeter_client_nic" {
  name                = format("apk-perf-test-jmeter-client-nic-%s", var.build_number)
  location            = "Southeast Asia"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jmeter_client_ip.id

  }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

# Virtual Machines - JMeter Servers and Client
resource "azurerm_linux_virtual_machine" "jmeter_server1" {
  name                            = format("apk-perf-test-jmeter-server-1-%s", var.build_number)
  resource_group_name             = var.resource_group_name
  location                        = "Southeast Asia"
  size                            = "Standard_F8s_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "adminuser"
    public_key = data.azurerm_key_vault_secret.apk-perf-test-cert.value
  }
  network_interface_ids = [
    azurerm_network_interface.jmeter_server1_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "22.04.202410020"
  }
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "adminuser"
#       private_key = data.azurerm_key_vault_secret.apk-perf-test-key.value
#       host        = self.public_ip_address
#     }
#     inline = [
#       "sudo apt-get update -y && sudo apt-get install -y unzip",
#       "wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.24%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "tar -xvf OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "sudo mv jdk-11.0.24+8 /opt/jdk",
#       "echo 'export JAVA_HOME=/opt/jdk' >> ~/.bashrc",
#       "source ~/.bashrc",
#       "wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz",
#       "tar -xvf apache-jmeter-5.6.3.tgz",
#       "sudo mv apache-jmeter-5.6.3 /opt/jmeter"
#     ]
#   }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

resource "azurerm_linux_virtual_machine" "jmeter_server2" {
  name                            = format("apk-perf-test-jmeter-server-2-%s", var.build_number)
  resource_group_name             = var.resource_group_name
  location                        = "Southeast Asia"
  size                            = "Standard_F8s_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "adminuser"
    public_key = data.azurerm_key_vault_secret.apk-perf-test-cert.value
  }
  network_interface_ids = [
    azurerm_network_interface.jmeter_server2_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "22.04.202410020"
  }
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "adminuser"
#       private_key = data.azurerm_key_vault_secret.apk-perf-test-key.value
#       host        = self.public_ip_address
#     }
#     inline = [
#       "sudo apt-get update -y && sudo apt-get install -y unzip",
#       "wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.24%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "tar -xvf OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "sudo mv jdk-11.0.24+8 /opt/jdk",
#       "echo 'export JAVA_HOME=/opt/jdk' >> ~/.bashrc",
#       "source ~/.bashrc",
#       "wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz",
#       "tar -xvf apache-jmeter-5.6.3.tgz",
#       "sudo mv apache-jmeter-5.6.3 /opt/jmeter"
#     ]
#   }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

# Retrieve the network interface details
data "azurerm_network_interface" "jmeter_client_nic" {
  name                = azurerm_network_interface.jmeter_client_nic.name
  resource_group_name = var.resource_group_name
}

# Public IP for JMeter Client
resource "azurerm_public_ip" "jmeter_client_ip" {
  name                = "apk-perf-test-jmeter-client-ip"
  resource_group_name = var.resource_group_name
  location            = "Southeast Asia"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
# Retrieve the public IP address
data "azurerm_public_ip" "jmeter_client_ip" {
  name                = azurerm_public_ip.jmeter_client_ip.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine" "jmeter_client" {
  name                            = format("apk-perf-test-jmeter-client-%s", var.build_number)
  resource_group_name             = var.resource_group_name
  location                        = "Southeast Asia"
  size                            = "Standard_F8s_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "adminuser"
    public_key = data.azurerm_key_vault_secret.apk-perf-test-cert.value
  }
  network_interface_ids = [
    azurerm_network_interface.jmeter_client_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "22.04.202410020"
  }
  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}

# User-Assigned Managed Identity
resource "azurerm_user_assigned_identity" "apk_perf_test_aks_identity" {
  name                = "apk-perf-test-aks-identity"
  resource_group_name = var.resource_group_name
  location            = "Southeast Asia"
}

# Role Assignment for Network Contributor
resource "azurerm_role_assignment" "network_contributor" {
  principal_id         = azurerm_user_assigned_identity.apk_perf_test_aks_identity.principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_virtual_network.apk_perf_test_vpc.id
}

# Role Assignment for Reader
resource "azurerm_role_assignment" "reader" {
  principal_id         = azurerm_user_assigned_identity.apk_perf_test_aks_identity.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("apk-perf-test-%s", var.build_number)
  location            = "Southeast Asia"
  resource_group_name = var.resource_group_name
  dns_prefix          = format("apk-perf-test-%s", var.build_number)
  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
    pod_cidr            = "10.244.0.0/16"
    service_cidr        = "10.0.0.0/16"
    dns_service_ip      = "10.0.0.10"
  }
  default_node_pool {
    name                 = "agentpool"
    node_count           = 2
    vm_size              = "Standard_F8s_v2"
    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 5
    node_labels = {
      role = "agent"
    }
    vnet_subnet_id = azurerm_subnet.default_subnet.id
    zones          = []
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.apk_perf_test_aks_identity.id]
  }
}
# Additional Node Pool (user pool)
resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  name                  = "userpool" # Name of the new node pool
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_F8s_v2"                # VM size for the new node pool
  node_count            = 2                                # Initial number of nodes
  auto_scaling_enabled  = true                             # Enable auto-scaling
  min_count             = 2                                # Minimum number of nodes for auto-scaling
  max_count             = 10                               # Maximum number of nodes for auto-scaling
  vnet_subnet_id        = azurerm_subnet.default_subnet.id # Attach the new pool to the same custom subnet
  node_labels = {
    role = "user" # Labels for this node pool
  }

  tags = {
    CreatedBy  = var.resource_created_by
    CreatedFor = var.resource_created_for
  }
}
output "aks_cluster_name" {
    value = azurerm_kubernetes_cluster.aks_cluster.name
}
output "jmeter_server_1_public_ip" {
  value = data.azurerm_public_ip.jmeter_server_1_ip.ip_address
}
output "jmeter_server_1_private_ip" {
  value = azurerm_network_interface.jmeter_server1_nic.private_ip_address
}

output "jmeter_server_2_public_ip" {
  value = data.azurerm_public_ip.jmeter_server_2_ip.ip_address
}
output "jmeter_server_2_private_ip" {
  value = azurerm_network_interface.jmeter_server2_nic.private_ip_address
}

output "jmeter_client_public_ip" {
  value = data.azurerm_public_ip.jmeter_client_ip.ip_address
}
output "jmeter_client_private_ip" {
  value = azurerm_network_interface.jmeter_client_nic.private_ip_address
}
output "private_key" {
  value = data.azurerm_key_vault_secret.apk-perf-test-key.value
  sensitive = true
}