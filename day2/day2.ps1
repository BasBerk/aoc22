function score {
    param (
        $inp
    )
    switch ($inp) {
        "rock" { $result = 1 }
        "paper" { $result = 2 }
        "scissor" { $result = 3 }
    }
    return $result
}

function convert {
    param(
        $inp
    )
    switch ($inp) {
        "A" { $result = "rock" }
        "B" { $result = "paper" }
        "C" { $result = "scissor" }
        "X" { $result = "rock" }
        "Y" { $result = "paper" }
        "Z" { $result = "scissor" }
    }

    return $result
}

function winner {
    param (
        $y,
        $o
    )
    $lost = 0
    $draw = 3
    $win = 6
  
    $other = convert -inp $o
    $you = convert -inp $y

  # "other:{0}:{1}  You {2}:{3}" -f $o, $other, $y, $you | write-host
    if ($other -eq 'rock' -and $you -eq 'paper') {
        $Score = $win + (score -inp $you)
    }
    if ($other -eq 'rock' -and $you -eq 'scissor') {
        $Score = $Lost + (score -inp $you)
    }
    if ($other -eq 'paper' -and $you -eq 'rock') {
        $Score = $Lost + (score -inp $you) 
    }
    if ($other -eq 'paper' -and $you -eq 'scissor') {
        $Score = $win + (score -inp $you) 
    }
    if ($other -eq 'scissor' -and $you -eq 'rock') {
        $Score = $win + (score -inp $you) 
    }
    if ($other -eq 'scissor' -and $you -eq 'paper') {
        $Score = $lost + (score -inp $you) 
    }
    if ($other -eq $you) {
        $Score = $draw + (score -inp $you)
    }
    return $Score
}
$fight = 1
$totalScore = 0
foreach ($line in Get-Content .\input.txt) {
    
    $o = $line.Split(' ')[0]
    $y = $line.Split(' ')[1]

    If ($y -eq "X") {
      #  Write-host "need to lose" -ForegroundColor yellow
        if ($o -eq "A") { 
            $round = (winner -o $o -y "z")
        }
        if ($o -eq "B") {
            $round = (     winner -o $o -y "X")
        }
        if ($o -eq "C") {
            $round = (winner -o $o -y "Y")
        }
    }

    If ($y -eq "Y") {
       # write-host "Need to draw" -ForegroundColor Cyan
        #Draw other Paper
        $round = (  winner -o $o -y $o)
        
    }

    If ($y -eq "Z") {
      #  write-host "need to win" -ForegroundColor Green
        if ($o -eq "A") {
            $round = (winner -o $o -y "Y")
        }
        if ($o -eq "B") {
            $round = (winner -o $o -y "Z")
        }
        if ($o -eq "C") {
            $round = (winner -o $o -y "X")
        }

    }
    # $round = (winner -o $oine.Split(' ')[0] -y $line.Split(' ')[1])
    $totalScore = $round + $totalScore
  # "fight {0} score:{1} TotalScore:{2}" -f $fight, $round, $totalScore
    $fight++

}
"fight {0} score:{1} TotalScore:{2}" -f $fight, $round, $totalScore