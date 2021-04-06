<#
    .Synopsis
        Wraps words based on Window Size so words don't end up split into 2 lines

    .DESCRIPTION
        Wraps words based on Window Size so words don't end up split into 2 lines

    .EXAMPLE
	Invoke-WordWrap -string $theSentenceToOutput -limit 30 # limit tells the function how many characters to limit the line to

    .INPUTS
	[String]$string # The sentence (or multiple line string) to perform on
	[Int]$limit # The length to limit the sentences to

    .OUTPUTS
	[String[]] # array containing the returned lines

    .NOTES
        PowerShell (C) 2020 by Daniel Kill
#>
function Invoke-WordWrap ([string]$string, [int]$limit) {
    $newLine = [Environment]::NewLine
    $newString = ""
    $thisLine = ""
    $lines = 1
    $string = $string.Replace("`t", "        ") # tabs are 8 spaces by default on the PowerShell console
    foreach ($word in $string.Split(" ")) {
        if ($thisLine.Length + $word.Length -lt $limit) {
            if ($thisLine.Length -eq 0) {
                $thisLine += "" + $word
            }
            else {
                $thisLine += " " + $word
            }
        }
        else {
            $lines++
            $newString += ($thisLine + $newLine)
            $thisLine = "$word"
        }
    }
    return ($lines, ($newString + $thisLine))
}

Export-ModuleMember -Function Invoke-WordWrap
