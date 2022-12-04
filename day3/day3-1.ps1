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


foreach ($line in Get-Content -path .\input.txt) {
    $length = $line.Length / 2
    $begin = $line.Substring(0, $length).Trim()
    $end = $line.Substring($length).Trim()
    $beginArr = $begin -split ''
    $endArr = $end -split ''
    $endArr
    "Line {0} lengte{3}: `n{1}`n{2} score {4}" -f $line, $begin.Length, $end.Length, $line.Length, $total

    foreach ($i in $beginArr) {
        if ($endArr -ccontains $i ) {
            if ($i -match '[a-zA-Z]') {
                "{0} found double" -f $i | Write-Host -ForegroundColor Green
                $total = $total + ( prio -item $i)
                prio -item $i
                break
            }
        
        }
    }
}

$total