# Function to roll a specified number of dice, all with the same number of sides.
# Switches on the Detailed parameter to show either the total sum of numbers rolled or the result of each individual role.
function Roll-Dice {
    [CmdletBinding()]
    param (
        # Require user input for the number of dice to roll.
        [Parameter(Mandatory = $true)]
        [int]$DiceCount,

        # Require user input for the number of sides on the dice. 
        [Parameter(Mandatory = $true)]
        [int]$Sides,

        [switch]$Detailed
    )

    process {
        # Creates an empty array which will store the results of each roll.
        # Creates a for loop that iterates from 1 to the value of $DiceCount.
        # Generates a random number between 1 and the number of sides on the dice and stores it in $result.
        # Adds $result into the $results array.
        $results = @()
        for ($i = 1; $i -le $DiceCount; $i++) {
            $result = Get-Random -Minimum 1 -Maximum ($Sides + 1)
            $results += $result
        }
        
        # Calculates the total sum of all dice rolls stored in $results by using Measure-Object cmdlet to specify sum then displays only that property.
        $total = $results | Measure-Object -Sum | Select-Object -ExpandProperty Sum

        # If Detailed is specified, creates a custom object with properties for the dice count, number of sides, individual roles, and total sum.
        if ($Detailed) {
            [PSCustomObject]@{
                "Dice Count" = $DiceCount
                "Sides" = $Sides
                "Rolls" = $results -join ", "
                "Total" = $total
            }
        # If Detailed is not specified, displays the total sum of rolls.
        } else {
            $total
        }
    }
}