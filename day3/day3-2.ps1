$data = Get-Content -path .\input.txt

function prio {
    param (
        $item
    )
    $list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $result = $list.IndexOf($item) + 1
    return $result
}

$total = 0

for ($line = 0; $line -lt $data.Count +1; $line++) {
    $first = $data[$line] -split ''
    $second = $data[$line + 1] -split ''
    $third = $data[$line + 2] -split ''
    $f = $data[$line]
    $s = $data[$line + 1]
    $t = $data[$line + 2]
    "{0}" -f $line |Write-Host -ForegroundColor Green
    foreach ($i in $first){
        if (($second -ccontains $i) -and ($third -ccontains $i)){
            if ($i -match '[a-zA-Z]'){
                "{0}`n{1}`n{2}`nFound{4} line{3} " -f $f, $s,$t,$line,$i
                $total =$total + (prio -item $i)
                break
            }
        }

    } 
    $line++
    $line++
}

$total

