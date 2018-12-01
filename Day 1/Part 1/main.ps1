$content = Get-Content -Path ($PSScriptRoot + "\input.txt")
$content |
    foreach {
    $sum = 0
} {
    $sum += $_
} {
    $sum
}