$InputFile = ".\input.txt"
$OpCodes = (Get-Content $InputFile).Split(',')

$OpCodes[1] = 12
$OpCodes[2] = 2

function Run-Intcode {
    param(
        [array]$OpCodes,
        [int]$Op1,
        [int]$Op2,
        [int]$Op3
    )

    if ($Op1 -eq 1) {
        return ([int]$OpCodes[$Op2] + [int]$OpCodes[$Op3])
    }
    
    elseif ($Op1 -eq 2) {
        return ([int]$OpCodes[$Op2] * [int]$OpCodes[$Op3])
    }
}

[int]$CurrentPosition = 0
while ($OpCodes[$CurrentPosition] -ne 99) {
    $RunIntcodeParams = @{
        OpCodes = $OpCodes
        Op1 = $OpCodes[$CurrentPosition]
        Op2 = $OpCodes[($CurrentPosition + 1)]
        Op3 = $OpCodes[($CurrentPosition + 2)]
    }
    $Result = Run-Intcode @RunIntcodeParams
    $Destination = $OpCodes[($CurrentPosition + 3)]
    $OpCodes[$Destination] = $Result
    $CurrentPosition += 4
}

$OpCodes[0]