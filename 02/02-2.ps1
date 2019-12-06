$InputFile = ".\input.txt"

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

function Try-Inputs {
    param(
        [int]$Noun,
        [int]$Verb
    )
    $OpCodes = (Get-Content $InputFile).Split(',')
    $OpCodes[1] = $Noun
    $OpCodes[2] = $Verb
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

    return ($OpCodes[0])
}

$Target = 19690720
$Verb = 0
while ($Answer -ne $Target -and $Verb -le 99) {
    for ($Noun = 0; $Noun -le 99 -and $Answer -ne $Target; $Noun++) {
        $Answer = Try-Inputs -Noun $Noun -Verb $Verb
        if ($Answer -eq $Target) {
            $Noun
            $Verb
            $Answer
        }
    }
    $Verb++
}

