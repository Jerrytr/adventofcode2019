$MassFile = ".\input.txt"
$Masses = Get-Content $MassFile
$TotalFuel = 0

function Measure-Fuel {
    param(
    [int]$Mass
    )
    $Divided = ($Mass / 3)
    $Rounded = ([Math]::floor($Divided))
    $Subtracted = ($Rounded - 2)
    return $Subtracted
}

foreach ($Mass in $Masses) {
    $Fuel = Measure-Fuel -Mass $Mass
    while ($Fuel -gt 0) {
        $TotalFuel += $Fuel
        $Fuel = Measure-Fuel -Mass $Fuel
    }
}

$TotalFuel