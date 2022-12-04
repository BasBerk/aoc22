$data = Get-Content -path .\input.txt
$count = 0
clear
$linecounter = 0
foreach ($line in $data) {
    $Pair = $line -split ','
    $first = $Pair[0] -split '-'
    $second = $pair[1] -split '-'
     
    if (([int32]$first[0] -le [int32]$second[0]) -and ([int32]$first[1] -ge [int32]$second[1] )) {
        $linecounter++
        "$linecounter second fits in First $line" | Write-Host -ForegroundColor Green
        $count++
        "Current score {0}" -f $count | write-host -ForegroundColor Yellow
        
    }
    elseif ([int32]$second[0] -le [int32]$first[0] -and ([int32]$second[1] -ge [int32]$first[1])) {
        $linecounter++

        "$linecounter first fits in second $line" | Write-Host -ForegroundColor Cyan
        "{0} le {1} and {2} ge {3}" -f [int32]$second[0],[int32]$first[0],[int32]$second[1],[int32]$first[1] |write-host 
        $count++
        "Current score {0}" -f $count | write-host -ForegroundColor Yellow
        
    }
    else {
        $linecounter++
        "$linecounter No complete overlap $line" | Write-Host -ForegroundColor Red
     
        
    }

}

$count