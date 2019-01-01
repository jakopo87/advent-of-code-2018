$content = Get-Content -Path ($PSScriptRoot + "\input.txt") | Sort-Object

$list = @()
$item = $null
foreach ($line in $content) {
    if ($line -match "Guard") {
        $id = [regex]::Match($line, "#(\d+)").Groups[1].Value
        $item = $list | Where-Object {$_.id -eq $id}
        $item = $list|Where-Object {$_.id -eq $id}

        if ($null -eq $item) {
            $item = @{
                "id"    = $id
                "sleep" = @(0) * 60
                "max"   = 0
            }
            $list += $item
        }
    } elseif ($line -match "falls") {
        $start = Get-date ([regex]::Match($line, "\[(.*)\]").Groups[1].Value)
    } else {
        $end = Get-date ([regex]::Match($line, "\[(.*)\]").Groups[1].Value)
        while ($start -lt $end) {
            $item.sleep[$start.Minute] += 1
            $item.max += 1
            $start = $start.AddMinutes(1)
        }
    }
}

# find the guard who sleeps the most
$guard = $list | Sort-Object -Descending -Property {$_.max} | Select-Object -First 1
$max = $guard["sleep"] | Measure-Object -Maximum | Select-Object -ExpandProperty "Maximum"
[array]::IndexOf($guard["sleep"], [int]$max) * $guard["id"]