$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")
$min = $content.Length

foreach ($i in 0..25) {
    $lower = [string][char]([int]'a'[-0] + $i )
    $polymer = $content.Replace($lower, "").Replace($lower.ToUpper(), "")

    do {
        $current = $polymer    
        
        foreach ($i in 0..25) {
            $lower = [string][char]([int]'a'[-0] + $i )
            $upper = $lower.ToUpper()
            
            $polymer = $polymer.Replace($lower + $upper, "").Replace($upper + $lower, "")
            
        }
        
    } until ($current -eq $polymer)

    $min = [math]::Min($min, $polymer.Length)
}

$min