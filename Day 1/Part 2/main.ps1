$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")
$list = $content.Split([System.Environment]::NewLine)
$sum = 0;
$freq = @{}

$isFound = $false
do {
    foreach ($item in $list) {
        $sum += $item
        if ($freq.ContainsKey($sum)) {
            $isFound = $true
            Write-Output "Duplicate found: $sum"
            break
        }
        $freq[$sum] = $true
    }
} while ($isFound -match $false)