# Creates an empty array to be edited
$Inventory = @{}

# Function to add items to inventory
function Add-Item {
    param (
        [string]$Name,
        [int]$Quantity
    )

    if ($Inventory.ContainsKey($Name)) {
        $Inventory[$Name] += $Quantity
    } else {
        $Inventory[$Name] = $Quantity
    }
}

# Function to remove items from inventory
function Remove-Item {
    param (
        [string]$Name,
        [int]$Quantity
    )

    if ($Inventory.ContainsKey($Name)) {
        if ($Inventory[$Name] -ge $Quantity) {
            $Inventory[$Name] -=$Quantity
        } else {
            Write-Host "Not enough $Name in inventory."
        }
    } else {
        Write-Host "$Name not found in inventory."
    }
}

# Function to update an item's quantity in inventory
function Update-Item {
    param (
        [string]$Name,
        [int]$NewQuantity
    )

    if ($Inventory.ContainsKey($Name)) {
        $Inventory[$Name] = $NewQuantity
    } else {
        Write-Host "$Name not found in inventory."
    }
}

# Function to display contents of inventory
function Get-Inventory {
    $Inventory | Format-Table -AutoSize
}

# Controller function that prompts the user for which above function they want to use.
# Continues displaying prompt until user chooses to exit.
function Edit-Inventory {
    do {
        Write-Host "Select an option"
        Write-Host "------------------------------"
        Write-Host "1. Add item to inventory"
        Write-Host "2. Remove item from inventory"
        Write-Host "3. Update inventory"
        Write-Host "4. Check contents of inventory"
        Write-Host "5. Exit prompt"
        Write-Host ""

        $action = Read-Host "Select an option"

        switch ($action) {
            # Adds a specified quantity of items into the inventory
            "1" {
                [string]$Name = Read-Host "Item Name"
                [int]$Quantity = Read-Host "Quantity to add"
                # Checks if specified item already exists in inventory. If so, adds the quantity to the existing item
                if ($Inventory.ContainsKey($Name)) {
                    $Inventory[$Name] += $Quantity
                    Write-Host "$Quantity $Name added."
                    # Displays the new quantity of the item in inventory
                    Write-Host "$($Inventory[$Name]) $Name total in inventory."
                    Write-Host ""
                # If the item is not already in the inventory, creates it and sets the value equal to the specified quantity
                } else {
                    $Inventory[$Name] = $Quantity
                    Write-Host "$Quantity $Name added."
                    Write-Host "$($Inventory[$Name]) $Name total in inventory."
                    Write-Host ""
                }
                # Brings user back to the prompt
                $breakFunction = $false
            }
            # Removes a specified quantity of items into the inventory
            "2" {
                [string]$Name = Read-Host "Item Name"
                [int]$Quantity = Read-Host "Quantity to remove"
                # Checks if specified item already exists in inventory. If so, continues
                if ($Inventory.ContainsKey($Name)) {
                    # Checks if the specified item has at least the specified quantity to remove. If so, removes specified amount
                    if ($Inventory[$Name] -ge $Quantity) {
                        $Inventory[$Name] -= $Quantity
                        Write-Host "$Quantity $Name removed."
                        # Displays the new quantity of the item in inventory
                        Write-Host "$($Inventory[$Name]) $Name total in inventory."
                        Write-Host ""
                    # If the number of specified item is less than the specified quantity to remove, notifies user
                    } else {
                        Write-Host "Not enough $Name in inventory."
                    }
                # If the specified item does not exist in the inventory, notifies user
                } else {
                    Write-Host "$Name not found in inventory."
                }
                # Brings user back to the prompt
                $breakFunction = $false
            }
            # Updates specified item in inventory to a new specified quantity
            "3" {
                [string]$Name = Read-Host "Item Name"
                [int]$NewQuantity = Read-Host "New quantity of $Name"
                # Checks if specified item already exists in inventory. If so, changes the quantity to the new specified quantity
                if ($Inventory.ContainsKey($Name)) {
                    $Inventory[$Name] = $NewQuantity
                    # Displays the new quantity of the item in inventory
                    Write-Host "$Name changed to $($Inventory[$Name]) now in inventory"
                    Write-Host ""
                # If the specified item does not exist in the inventory, notifies user
                } else {
                    Write-Host "$Name not found in inventory."
                }
                # Brings user back to the prompt
                $breakFunction = $false
            }
            # Displays the current contents of the inventory
            "4" {
                $Inventory | Format-Table -AutoSize
                Write-Host ""
                $breakFunction = $false
            }
            # Changes the $breakFunction variable to true to end the do-while loop
            "5" {
                $breakFunction = $true
            }
            # If user input is not one of the given options, brings user back to the prompt
            default {
                Write-Host "Invalid option. Please select again."
                $breakFunction = $false
            }
        }
    # Ends the function once $breakFunction is set to true
    } while ($breakFunction -eq $false)
}  