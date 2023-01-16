$data = Get-Content -path .\input.txt -Delimiter \n

$nl = [System.Environment]::NewLine
$items = ($data -split "$nl")
$items.count

$elfTotal = 0
$elfNumber = 1
$elfControl = @{}

for ($i = 0; $i -le $items.Count ; $i++) {
    if ($items[$i] -match '\d') {
        $elfTotal = [int32]$items[$i] + [int32]$elfTotal

    }
    else {
        #"Elf {0} has {1} calories total" -f $elfNumber, $elfTotal
        $elfControl.Add($elfNumber, $elfTotal)
        $elfNumber++
        $elfTotal = 0 

    }
}
$elfsSorted = $elfControl.GetEnumerator() | sort Value 
$TotalElfs = $elfsSorted.count - 1
$strongestElf = $elfsSorted[$TotalElfs]

"Elf {0} carries the most weight with a total of {1}" -f $strongestElf.Name, $strongestElf.Value | Write-Host
#part2
$TotalWeigthTop3 = $elfsSorted[$TotalElfs].Value + $elfsSorted[$TotalElfs - 1].Value + $elfsSorted[$TotalElfs - 2].Value
"the top3 elfs not joking around with a total weight of {0}" -f $TotalWeigthTop3 | Write-Host