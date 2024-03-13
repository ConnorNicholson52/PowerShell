# Function to find an AD User based off of a known attribute
function Find-ADUser {
    Write-Host "Search for an AD User/Users by a known attribute"
    Write-Host "------------------------------------------"
    Write-Host "1: SamAccountName"
    Write-Host "2: Name"
    Write-Host "3: User Principal Name"
    Write-Host "4: Email Address"
    Write-Host "5: Given Name"
    Write-Host "6: Surname"
    Write-Host ""

    do {
    $action = Read-Host "Select a number"

        switch ($action) {
            "1" {
                $SamAccountName = Read-Host "Enter the SamAccountName"
                Get-ADUser -Filter {SamAccountName -eq $SamAccountName}
                $validOption = $true
            }
            "2" {
                $Name = Read-Host "Enter the Name"
                Get-ADUser -Filter {Name -eq $Name}
                $validOption = $true
            }
            "3" {
                $UserPrincipalName = Read-Host "Enter the User Principal Name"
                Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}
                $validOption = $true
            }
            "4" {
                $EmailAddress = Read-Host "Enter the Email Address"
                Get-ADUser -Filter {EmailAddress -eq $EmailAddress}
                $validOption = $true
            }
            "5" {
                $GivenName = Read-Host "Enter the Given Name"
                Get-ADUser -Filter {GivenName -eq $GivenName}
                $validOption = $true
            }
            "6" {
                $Surname = Read-Host "Enter the Surname"
                Get-ADUser -Filter {Surname -eq $Surname}
                $validOption = $true
            }
            default {
                Write-Host "Invalid action. Please select a valid action."
                $validOption = $false
            }
        }
    } while (-not$validOption)
}