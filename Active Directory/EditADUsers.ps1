# Function to enable, disable, reset password, or delete AD users.
function Edit-ADUser {

    $userName = Read-Host "Enter the user SamAccountName"

    $user = Get-ADUser -Filter "SamAccountName -eq '$userName'"

    Write-Host "Current User Account Information:"
    Write-Host "---------------------------------"
    Write-Host "Name: $($user.Name)"
    Write-Host "SamAccountName: $($user.SamAccountName)"
    Write-Host "Enabled: $($user.Enabled)"
    Write-Host "LastLogonDate: $($user.LastLogonDate)"
    Write-Host "PasswordLastSet: $($user.PasswordLastSet)"
    Write-Host ""

    do {
        $action = Read-Host "Enter number of action to perform (1: enable, 2: disable, 3: reset password, 4: delete)"

        switch ($action) {
            "1" {
                Enable-ADAccount -Identity $user.SamAccountName
                Write-Host "User account $($user.SamAccountName) has been enabled."
                $validOption = $true
            }
            "2" {
                Disable-ADAccount -Identity $user.SamAccountName
                Write-Host "User account $($user.SamAccountName) has been disabled."
                $validOption = $true
            }
            "3" {
                $newPassword = Read-Host "Enter the new password" -AsSecureString
                Set-ADAccountPassword -Identity $user.SamAccountName -NewPassword $newPassword -Reset
                Write-Host "Password for user account $($user.SamAccountName) has been reset."
                $validOption = $true
            }
            "4" {
                Remove-ADUser -Identity $user.SamAccountName -Confirm:$false
                Write-Host "User account $($user.SamAccountName) has been deleted."
                $validOption = $true
            }
            default {
                Write-Host "Invalid action. Please select a valid action."
                $validOption = $false
            }
        }
    } while (-not $validOption)
}