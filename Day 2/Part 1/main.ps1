$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")
$list = $content.Split([System.Environment]::NewLine)
$checksum = $(0, 0)
$length = $(2, 3)
$list | ForEach-Object {
    for ($i = 0; $i -lt $length.Count; $i++) {
        $checksum[$i] += ($_.ToCharArray() | Group-Object | Where-Object {$_.Count -eq $length[$i]}).Count -ne 0
    }
}
$checksum[0] * $checksum[1]