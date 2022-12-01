[CmdletBinding()]
param (
    [Parameter()]
    [int32]$day = 2 
)

function LoadData {
    [CmdletBinding()]
    param (
        [int32]$day
    )

    $uri = "https://adventofcode.com/2022/day/{0}/input" -f $day
    $cookie = Get-Content .\cookies.txt -Raw
    $session = [Microsoft.PowerShell.Commands.WebRequestSession]::new()
    $session.Cookies.Add($uri, [System.Net.Cookie]::new("session", $cookie))
    $content = Invoke-WebRequest $uri -WebSession $session
   
    return $content.Content

}


function createFiles {
    param (
        $day
    )
    $path = "day$day"
    $filename = Join-Path -Path $path -ChildPath "day$day.ps1"
    $inputdata = Join-Path -Path $path -ChildPath "input.txt"
    $files = @("input.txt","day$day.ps1")

    If (!(Test-Path -Path $path )){
        New-Item -ItemType Directory -Name $path
        foreach ($file in $files){
            $filename = Join-Path -Path $path -ChildPath $file
            New-Item -ItemType File -Path $filename
        }
        Set-Content -Path $filename -Value '$data = Get-Content -path .\input.txt'
    }
    Set-Content -Path $filename -Value '$data = Get-Content -path .\input.txt'
    Set-Content -Path $inputdata -Value (LoadData -day $day )

}

createFiles -day $day