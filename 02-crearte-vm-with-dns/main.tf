# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "main" {
  name                = "Lokesh-nic"
  location            = "denmarkeast"
  resource_group_name = "vm-ware-DenmarkEast"

  ip_configuration {
    name                          = "Lokeshconfiguration1"
    subnet_id                     = "/subscriptions/b1302eea-54e8-482b-a20f-fcc64ece4d78/resourceGroups/vm-ware-DenmarkEast/providers/Microsoft.Network/virtualNetworks/AnsibleControler-vnet/subnets/default/"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "main" {
  name                  = "Lokesh-vm"
  location              = "denmarkeast"
  resource_group_name   = "vm-ware-DenmarkEast"
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = "Standard_D2s_v3"

  source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "TLokesh@0609L"
  admin_username = "Lokesh"

  disable_password_authentication = false

  secure_boot_enabled = false
  vtpm_enabled        = false

}