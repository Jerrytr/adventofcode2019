$InputFile = ".\input.txt"

$Wire1Instructions = ((Get-Content $InputFile).Split('\n')[0]).Split(',')
$Wire2Instructions = ((Get-Content $InputFile).Split('\n')[1]).Split(',')

function Plotter {
    param(
        [int]$XPos,
        [int]$YPos,
        [char]$Direction,
        [int]$Distance
    )
    switch ($Direction) {
        'U' { $YPos += $Distance }
        'R' { $XPos += $Distance }
        'D' { $YPos -= $Distance }
        'L' { $XPos -= $Distance }
    }
    Return "$Xpos,$Ypos"
}

function Run-Wire {
    param(
        [int]$XPos,
        [int]$YPos,
        [array]$Instructions
    )
    foreach ($Instruction in $Instructions) {
        $Direction = $Instruction[0]
        $Distance = $Instruction.Substring(1, ($Instruction.Length - 1))
        
        for ($i = 1; $i -le $Distance; $i ++) {
            $NewPosition = Plotter -XPos $XPos -YPos $YPos -Direction $Direction -Distance 1
            $XPos = $NewPosition.Split(',')[0]
            $YPos = $NewPosition.Split(',')[1]
            [array]$Locations += "$Xpos,$Ypos"
        }

    }
    Return $Locations
}

function Get-Distance {
    param(
        [int]$X1,
        [int]$Y1,
        [int]$X2,
        [int]$Y2
    )
    return ([Math]::Abs($X1 - $X2) + [Math]::Abs($Y1 - $Y2))
}

$Wire1Locations = Run-Wire -XPos 0 -YPos 0 -Instructions $Wire1Instructions
$Wire1Locations
$Wire2Locations = Run-Wire -XPos 0 -YPos 0 -Instructions $Wire2Instructions

foreach ($Location in $Wire1Locations) {
    Write-Output "Trying $Location"
    if ($Wire2Locations -contains $Location) {
        [array]$CrossPoints += $Location
    }
}

foreach ($CrossPoint in $CrossPoints) {
    $X1 = 0
    $Y1 = 0
    $X2 = $CrossPoint.split(',')[0]
    $Y2 = $CrossPoint.split(',')[1]

    $Distance = Get-Distance -X1 $X1 -X2 $X2 -Y1 $Y1 -Y2 $Y2
    [Array]$Distances += $Distance
}

($Distances | Sort-Object)[0]



