$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")

for ($i = 0; $i -lt $content.Count - 1; $i++) {
    $l1 = $content[$i]
    for ($j = $i + 1; $j -lt $content.Count; $j++) {
        $l2 = $content[$j]
        $match = "";
        for ($k = 0; $k -lt $l1.length; $k++) {
            if ($l1[$k] -eq $l2[$k]) { 
                $match += $l1[$k]; 
            }
        }
        if (($l1.Length - $match.Length) -eq 1) { 
            $match
        }
    }
}