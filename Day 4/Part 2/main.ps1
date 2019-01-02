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
$max = $null
$minute = $null
$id = $null
foreach ($guard in $list.GetEnumerator()) {
    $m = ($guard["sleep"] | Measure-Object -Maximum).Maximum
    if ($m -lt $max) {
        continue
    }

    $max = $m
    $minute = [array]::IndexOf($guard["sleep"], [int]$max)
    $id = $guard["id"]
}
$minute * $id