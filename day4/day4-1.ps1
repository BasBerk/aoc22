$data = Get-Content -path .\input.txt
$count = 0
clear
$linecounter = 0
foreach ($line in $data) {
    $Pair = $line -split ','
    $first = $Pair[0] -split '-'
    $second = $pair[1] -split '-'
    $firstArr = $first[0]..$first[1]
    $secondArr = $second[0]..$second[1]

    for ($i = 0; $i -lt $firstArr.Count; $i++) {
        if ($firstArr[$i] -in $secondArr){
          
          
            $count++
            break
        }
    }
}



$count