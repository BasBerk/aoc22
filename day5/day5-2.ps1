$data = Get-Content -path .\input.txt

$stacks = [PsCustomObject] @{
    1 = [PsCustomObject[]] @()
    2 = [PsCustomObject[]] @()
    3 = [PsCustomObject[]] @()
    4 = [PsCustomObject[]] @()
    5 = [PsCustomObject[]] @()
    6 = [PsCustomObject[]] @()
    7 = [PsCustomObject[]] @()
    8 = [PsCustomObject[]] @()
    9 = [PsCustomObject[]] @()

}

$stack = 9
$i =5

for ($i = 7; $i -ge 0; $i--) {
   
    for ($stack = 1; $stack -lt 10; $stack++) {
        
        [int32]$selectStack = [int32]$stack * 4 - 3

        if ($selectStack -eq 33) { $selectStack =31}
        $load = $data[$i].Substring($selectStack, 4)
        $load = $load -replace '[\[\]]', ''
        if ($load -match "[A-Z]") {  #lucht verplaatsen is niet wat we doen
        $stackNumber = $data[8].Substring($selectStack, 4).trim()

        $stacks.$stackNumber += $load
      #  $stackNumber
        }
    }  
   

}



function moveCrates {
    param (
        [int32]$moves = 4,
        [int32]$from =1,
        [int32]$to =2
    )
    
        
        #select create value

        $crate = $stacks.$from | Select-Object -Last $moves
        
        #remove create
        $pos = $stacks.$from | Measure-Object
        $pos =$pos.Count
        [System.Collections.ArrayList]$tempStack = $stacks.$from
        for ($item = 0; $item -lt $moves; $item++) {
            
            $tempStack.RemoveAt($pos -1 )
            $pos =$pos -1
        }
        
        $stacks.$from = $tempStack
        #dump on other stack
        $stacks.$to += $crate
    
}

#MoveCrates -moves 3 -from 1 -to 2

for ($line = 10; $line -lt $data.Count; $line++) {
    #$data[$line]

    
  
        
    $moves = $data[$line] -replace "[a-z]" -split " "
   
    moveCrates -moves $moves[1] -from $moves[3] -to $moves[5]
   <#  clear
    $stacks #>
}



for ($i =1 ; $i -lt 10; $i++) {
    $stacks.$i | select -last 1
}