do {
    #Requests directory path from user
    $directoryPath = Read-Host "Type the directory path"

    #If user input is not a valid path, prompt to try again
    if (-not (Test-Path $directoryPath)) {
        Write-Host -ForegroundColor Red "Invalid path. Try again."
    }

  #Once the input is a valid path, continue the script
} until (
    Test-Path $directoryPath
    )

#Retrieves items within the specified directory
$items = Get-ChildItem -Path $directoryPath

#Checks if child items are folders, then displays the name and current permissions set for each folder. If child item is not a folder, notifies the user
foreach($item in $items){
    if($item.PSIsContainer){
        $acl = Get-Acl -Path $item.FullName
        Write-Host "Folder: $($item.FullName)"
        foreach($accessRule in $acl.Access){
            Write-Host "$($accessRule.IdentityReference) - $($accessRule.FileSystemRights)"
        }
        #Separates items with a space
        Write-Host ""
    } else{
        Write-Host "$item is not a valid directory"
    }
}