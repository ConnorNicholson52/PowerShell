# Function to create an ADUser. Prompts for mandatory information.
function Create-ADUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$SamAccountName,

        [Parameter(Mandatory = $true)]
        [string]$Password,

        [Parameter(Mandatory = $true)]
        [string]$UserPrincipalName,

        [Parameter(Mandatory = $true)]
        [string]$GivenName,

        [Parameter(Mandatory = $true)]
        [string]$Surname,

        [Parameter(Mandatory = $true)]
        [string]$Description,

        [Parameter(Mandatory = $true)]
        [string]$Office
    )

    # Takes a plaintext input and converts it into a secure string.
    $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force

    # Passes the given variables into an array to be passed into New-ADUser
    $userParams = @{
        Name = $Name
        SamAccountName = $SamAccountName
        UserPrincipalName = $UserPrincipalName
        GivenName = $GivenName
        Surname = $Surname
        Description = $Description
        Office = $Office
        AccountPassword = $securePassword
        Enabled = $true
    }

    New-ADUser @userParams
}  