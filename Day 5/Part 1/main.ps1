$content = Get-Content -Path ($PSScriptRoot + "\..\input.txt")

do {
    $current = $content    
    
    foreach ($i in 0..25) {
        $lower = [string][char]([int]'a'[-0] + $i )
        $upper = $lower.ToUpper()
        
        $content = $content.Replace($lower + $upper, "").Replace($upper + $lower, "")

    }
    
} until ($current -eq $content)

$content.Length