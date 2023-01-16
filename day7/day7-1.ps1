$data = Get-Content -Path .\input.txt

$structure = @{}
$structure.'/' = [System.Collections.Generic.List[object]]::New()
$pwd = '/'
foreach ($line in $data) {
    $cmd, $operation, $dirLine, $file, $size = $null
    switch -Regex ($line) {
        '^\$\scd\s(?<operation>.*)$' {
            $operation = $matches.operation
            break
        }
        '^(\$\sls|dir\s.*)$' {
            break
        }
        '^(?<size>\d+)\s(?<file>.+)$' {
            [string]$file = $matches.file
            [int]$size = $matches.size
        }
        default {}
    }
 
    # change directory
    switch -Regex ($operation) {
        $null { break }
        '\.\.' {
            $pwd, $null = $pwd -split '\w+/$'
            break
        }
        '/' {
            $pwd = '/'
            break
        }
        '\w*' {
            $pwd = $pwd, $_, '/' -join ''
        }
    }
    # ls
    if ($null -ne $file) {
        $fileData = [pscustomobject]@{
            Directory = $pwd
            file  = $file
            size  = $size
        }
        if ($null -eq $structure["$pwd"]) {
            $structure.$pwd = [System.Collections.Generic.List[object]]::New()
        }
        ($structure.$pwd).Add($fileData)
 
        # Recursively add files to get lower folder sum
        if ($pwd -eq '/') { continue }
        $recursepwd = $pwd
        do {
            $recursepwd, $null = $recursepwd -split '\w+/$'
            if ($null -eq $structure["$recursepwd"]) {
                $structure.$recursepwd = [System.Collections.Generic.List[object]]::New()
            }
            ($structure.$recursepwd).Add($fileData)
        }
        until ($recursepwd -eq '/')
    }
}
 

$total = foreach ($key in $structure.keys) {
    ($structure.$key | Measure -Sum -Property size).Sum
}
($total | Where { $_ -le 100000 } | Measure -Sum).Sum
 
#deel 2
[int]$diffNeeded = 70000000 - $totalUsed
[int]$mustDelete = 30000000 - $diffNeeded
$total | Where { $_ -ge $mustDelete } | Sort | Select -First 1


$structure | sort key