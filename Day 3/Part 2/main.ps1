$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")
$regex = [regex]::new("#(\d+) @ (\d+),(\d+): (\d+)x(\d+)")
$timer = [System.Diagnostics.Stopwatch]::StartNew()

Write-Output "Building canvas"

$cloth = new-object 'int[,]' 1000, 1000
for ($i = 0; $i -lt $content.Count; ++$i) {
    # Parse first cloth
    $m = $regex.Match($content[$i]).Groups | ForEach-Object {Invoke-Expression $_.Value }
    $r = $m[1], $m[2], ($m[1] + $m[3]), ($m[2] + $m[4])
    
    # Fill canvas with first cloth
    for ($x = $r[0]; $x -lt $r[2] ; ++$x) {
        for ($y = $r[1]; $y -lt $r[3]; ++$y) {
            ++$cloth[$x, $y]
        }
    }

    "$($i+1)/$($content.Length) - $($timer.Elapsed.ToString())ms"
}

Write-Output "Search for non overlapping"

for ($i = 0; $i -lt $content.Count; ++$i) {
    # Parse cloth
    $m = $regex.Match($content[$i]).Groups | ForEach-Object {Invoke-Expression $_.Value }
    $r = $m[1], $m[2], ($m[1] + $m[3]), ($m[2] + $m[4])
    
    $isOverlapping = $false

    # Fill canvas with cloth
    for ($x = $r[0]; $x -lt $r[2] ; ++$x) {
        for ($y = $r[1]; $y -lt $r[3]; ++$y) {
            $isOverlapping = $isOverlapping -or ($cloth[$x, $y] -gt 1)
        }
    }

    if ($isOverlapping -eq $false) {
        $content[$i]
        return
    }

    "$($i+1)/$($content.Length) - $($timer.Elapsed.ToString())ms - $isOverlapping"
}