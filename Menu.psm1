<#
    .Synopsis
        Creates Menus

    .DESCRIPTION
        New-Menu

    .EXAMPLE
	New-Menu -Question "`tWould you like to view the instructions?" -Choices (
        ("&Yes", "View the Instructions"),
        ("&No", "Start the Game")
    )

    .INPUTS
	[String]$Question
	[String[]]$Choices

    .OUTPUTS
	[String[]] of the Choice chosen
	or
	[String]Error Message

    .NOTES
        PowerShell (C) 2020 by Daniel Kill
#>
function New-Menu {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Question,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $Choices
    )
    $result = "***ERROR***"
    $message = ""
    do {
        If ($message -ne "") {
            Write-Host
            Write-Warning $message
        }
        for ($i = 0; $i -lt $Choices.Count; $i++) {
            Write-Host -NoNewline ("[{0}], " -f ($Choices[$i][0])[1])
        }
        Write-Host -NoNewline "[?]"
        Write-Host -NoNewline ("`n{0} " -f $Question)
        do {
            $keyPressed = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
        } while ($keyPressed.Character -notmatch "[0-9a-zA-Z\?]")
        Write-Host
        for ($i = 0; $i -lt $Choices.Count; $i++) {
            If ($keyPressed.Character -eq ($Choices[$i][0])[1]) {
                $result = $i
            }
        }
        If ($keyPressed.Character -eq "?") {
            $result = "HELP"
        }
        If ($result -eq "***ERROR***") {
            $message = @(
                "How very original, now try again.",
                ("Even a {0} could do better than that." -f ($monsters | Get-Random)),
                ("While you're messing around a {0} is going hungry." -f ($monsters | Get-Random)),
                ("With skills like that, you'll be no challenge for a {0}." -f ($monsters | Get-Random)),
                ("You'll need to be smarter than a {0} to find Zot's orb." -f ($monsters | Get-Random)),
                ("You bumbling buffoon, '{0}' is not a choice, please read the question and answer correctly!" -f $keyPressed.Character),
                "Yawn, hurry up you buffoon.",
                "Please make a valid selection.",
                "Ha! Ha! I peed myself with laughter.",
                "You're wearing my patience thin.",
                "You really are a stupid one aren't you.",
                "Stop that now, it's really annoying.",
                "I guess following directions is hard for you.",
                "Have you always been this difficult?",
                "Chop chop! Let's get on with it.",
                "Would you please just pick one.",
                "Maybe next time you should play solitaire."
            )
            $message = ("`t* {0} *`n" -f ($message | Get-Random))
        }
        If ($result -eq "HELP") {
            for ($i = 0; $i -lt $Choices.Count; $i++) {
                Write-Host ("[{0}] - {1}" -f ($Choices[$i][0])[1], $Choices[$i][1])
            }
            $result = "***ERROR***"
            $message = ""
        }
    } while ($result -eq "***ERROR***")
    return $Choices[$result]
}

Export-ModuleMember -Function New-Menu
