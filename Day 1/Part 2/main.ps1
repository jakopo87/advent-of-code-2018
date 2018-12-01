$content = Get-Content -Path ($PSScriptRoot + "\input.txt")
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

# $nums = [int[]](gc .\input.txt)
# $lookup = @{}
# $current = 0
# while ($true) { 
#     $nums.foreach{ 
#         $current += $_
#         if ($lookup.ContainsKey($current)) {
#             break
#         }
#         $lookup[$current]++; 
#     } 
# }
# $current