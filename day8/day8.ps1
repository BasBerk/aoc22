cls
$data = Get-Content .\input.txt
$counter = 0

For ($lines = 0; $lines -lt $data.Length; $lines++) {
    For ($LR = 0; $LR -lt $data[$lines].Length; $LR++) {
        $Up = 0
        $Down = 0
        $Left = 0
        $Right = 0
        $Current = $data[$lines][$LR]

        If (($lines -eq 0) -or ($lines -eq ($data.Length - 1))) {
            $counter++
            Write-Host "$Current" -NoNewline -ForegroundColor Green
        }
        ElseIf (($LR -eq 0) -or ( $LR -eq ($data[0].Length - 1))) {
            $counter++
            Write-Host "$Current" -NoNewline -ForegroundColor Green
        }
        Else {
            For ($K = $lines - 1; $K -ge 0; $K--) {
                If ($data[$K][$LR] -ge $data[$lines][$LR]) {
                    $Up = 0
                    Break
                }
                $Up++
            }
    
            For ($K = $lines + 1; $K -lt $data.Length; $K++) {
                If ($data[$K][$LR] -ge $data[$lines][$LR]) {
                    $Down = 0
                    Break
                }
                $Down++
            }
    
            For ($K = $LR - 1; $K -ge 0; $K--) {     
                If ($data[$lines][$K] -ge $data[$lines][$LR]) {
                    $Left = 0
                    Break
                }
                $Left++
            }
    
            For ($K = $LR + 1; $K -lt $data[$lines].Length; $K++) {
                If ($data[$lines][$K] -ge $data[$lines][$LR]) {
                    $Right = 0
                    Break
                }
                $Right++
            }
            If ($Up -or $Down -or $Left -or $Right) {
                $counter++
                Write-Host "$Current" -NoNewline -ForegroundColor Green
            }
            Else {
                Write-Host "$Current" -NoNewline -ForegroundColor Red
            }
        }
    }
    Write-Host ""
}
Write-Host "`nAnswer: $counter"

$puzzleInput = Get-Content .\input.txt
[string[]]$grid = $puzzleInput -split '\n' 
[int]$visible = ($grid.Length * 2) + (($grid.count - 2) * 2)
$yMidCount = $grid.count - 2
$xMidLen = $grid.Length - 2
$yCount = $grid.count -1
$xLen = $grid.Length -1
for ($y=1; $y -le $yMidCount; $y++) {
    for ($x=1; $x -le $xMidLen; $x++) {
        $isVisible = $false
        switch ($grid[$y][$x]) {
            {($grid[$($y-1)..0] | foreach {$_[$x] -ge $grid[$y][$x]}) -notcontains $true} {$isVisible = $true;break}
            {($grid[$($y+1)..$yCount] | foreach {$_[$x] -ge $grid[$y][$x]}) -notcontains $true} {$isVisible = $true;break}
            {($grid[$y][$($x-1)..0] | foreach {$_ -ge $grid[$y][$x]}) -notcontains $true} {$isVisible = $true;break}
            {($grid[$y][$($x+1)..$xLen] | foreach {$_ -ge $grid[$y][$x]}) -notcontains $true} {$isVisible = $true;break}
        }
        if ($isVisible -eq $true) {$visible++}
    }
}
$visible

# Part 2
$scenicScore = @{}
for ($y=1; $y -le $yMidCount; $y++) {
    for ($x=1; $x -le $xMidLen; $x++) {
        $upScore = 0
        $downScore = 0
        $leftScore = 0
        $rightScore = 0
 
        # Check up
        $up = $y
        do {$upScore++;$up--}
        until (($grid[$up][$x] -ge $grid[$y][$x]) -or ($up -eq 0))
 
        # Check down
        $down = $y
        do {$downScore++;$down++}
        until (($grid[$down][$x] -ge $grid[$y][$x]) -or ($down -eq $yCount))
 
        # Check left
        $left = $x
        do {$leftScore++;$left--}
        until (($grid[$y][$left] -ge $grid[$y][$x]) -or ($left -eq 0))
 
        # Check right
        $right = $x
        do {$rightScore++;$right++}
        until (($grid[$y][$right] -ge $grid[$y][$x]) -or ($right -eq $xLen))
        $scenicScore["$y,$x"] = $upScore * $downScore * $leftScore * $rightScore
    }
}
$scenicScore.Values | Sort | Select -Last 1