$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")
$regex = [regex]::new("#\d+ @ (\d+),(\d+): (\d+)x(\d+)")
$timer = [System.Diagnostics.Stopwatch]::StartNew()

# Create a canvas for both cloths
$cloth = new-object 'int[,]' 1000, 1000
for ($i = 0; $i -lt $content.Count; ++$i) {
    # Parse first cloth
    $m = $regex.Match($content[$i]).Groups | ForEach-Object {Invoke-Expression $_.Value }
    $r1 = $m[0], $m[1], ($m[0] + $m[2]), ($m[1] + $m[3])

    # Fill canvas with first cloth
    for ($x = $r1[0]; $x -lt $r1[2] ; ++$x) {
        for ($y = $r1[1]; $y -lt $r1[3]; ++$y) {
            ++$cloth[$x, $y]
        }
    }

    "$($i+1)/$($content.Length) - $($timer.Elapsed.ToString())ms"
}
$cloth -gt 1 | Measure-Object | Select-Object -ExpandProperty "Count"