<#
.Synopsis
    Wizard's Castle game: Original: Copyright (C) 1980 by Joseph R Power
.DESCRIPTION
    Wizard's Castle 40th Anniversary PowerShell Version: (C) 2020 by Daniel Kill
.EXAMPLE
    .\The_Wizards_Castle.ps1
.INPUTS
    * NONE *
.OUTPUTS
    An enjoyable game of Wizard's Castle
.NOTES
    Original: Copyright (C) 1980 by Joseph R Power
    PowerShell version: (C) 2020 by Daniel Kill
.FUNCTIONALITY
    Implements Wizard's Castle in PowerShell with some fun modifications to the original game.
#>
Clear-Host
Set-Location -Path $PSScriptRoot
Import-Module "$($PSScriptRoot)\New-Character.psm1"


function Get-WindowSize() {
    $Host.UI.RawUI.WindowSize
}

function Get-WindowWidth() {
    (Get-WindowSize).Width
}

function Get-WindowHeight() {
    (Get-WindowSize).Height
}

function Show-StartingMessages {
    Write-Output "Welcome to Wizard's Castle (40th Anniversary PowerShell Edition)"
    Write-Output "`nCopyright (C) 1980 by Joseph R Power"
    Write-Output "Last Revised - 04/12/80  11:10 PM"
    
    Write-Output "`nPowerShell version written by Daniel Kill"
    # Modified: 2020-07-14 by Daniel Kill
    # Modified: 2020-07-15 by Daniel Kill
    # Modified: 2020-07-16 by Daniel Kill
    # Modified: 2020-07-17 by Daniel Kill
    # Modified: 2020-07-18 by Daniel Kill
    # Modified: 2020-07-19 by Daniel Kill
    # Modified: 2020-07-20 by Daniel Kill
    # Modified: 2020-07-21 by Daniel Kill
    # Modified: 2020-07-22 by Daniel Kill
    # Modified: 2020-07-23 by Daniel Kill
    # Modified: 2020-07-24 by Daniel Kill
    # Modified: 2020-07-25 by Daniel Kill
    # Modified: 2020-07-26 by Daniel Kill
    # Modified: 2020-07-27 by Daniel Kill
    # Modified: 2020-07-28 by Daniel Kill
    # Modified: 2020-07-29 by Daniel Kill
    # Modified: 2020-07-30 by Daniel Kill
    # Modified: 2020-07-31 by Daniel Kill
    # Modified: 2020-08-01 by Daniel Kill
    # Modified: 2020-08-02 by Daniel Kill
    # Modified: 2020-08-03 by Daniel Kill
    # Modified: 2020-09-03 by Daniel Kill
    # Modified: 2020-09-12 by Daniel Kill
    Write-Output "# Modified: 2020-09-12 by Daniel Kill"
    Read-Host -Prompt "`nPress Enter to continue"
    
    Clear-Host
    $choice = New-Menu -Question "`tWould you like to view the instructions?" -Choices (
        ("&Yes", "View the Instructions"),
        ("&No", "Start the Game")
    )
    If ($choice[0] -like "*Yes*") {
        $content = Get-Content -Path "./Instructions.txt"
        $i = 0
        $j = 0
        $regExPattern = [Regex]::new('^[A-Z]{2,15}')
        Clear-Host
        $linesFromWordWrap, $outFromWordWrap = Invoke-WordWrap ("{0}" -f $content[0]) (Get-WindowWidth)
        Write-Output ($outFromWordWrap)
        $j += $linesFromWordWrap
        while ($i -lt $content.Length) {
            do {
                $i++
                If ($content[$i] -notmatch $regExPattern -and $i -lt $content.Length) {
                    If ($j -lt ((Get-WindowHeight) - 5)) {
                        $linesFromWordWrap, $outFromWordWrap = Invoke-WordWrap ("{0}" -f $content[$i]) (Get-WindowWidth)
                        Write-Output ($outFromWordWrap)
                        $j += $linesFromWordWrap
                    }
                    elseif ($content[$i] -notmatch $regExPattern -or $content[$i] -ne "*** END OF INSTRUCTIONS ***") {
                        If ($content[$i].Length -gt 1) {
                            Read-Host -Prompt "Press Enter to continue"
                            $linesFromWordWrap, $outFromWordWrap = Invoke-WordWrap ("{0}" -f $content[$i]) (Get-WindowWidth)
                            Write-Output ($outFromWordWrap)
                        }
                        $j = $linesFromWordWrap
                    }
                }
            } until ($content[$i] -match $regExPattern -or $content[$i] -eq "*** END OF INSTRUCTIONS ***" -or $i -gt $content.Length)
            If ($i -lt $content.Length) {
                Read-Host -Prompt "Press Enter to continue"
                Clear-Host
                $linesFromWordWrap, $outFromWordWrap = Invoke-WordWrap ("{0}" -f $content[$i]) (Get-WindowWidth)
                Write-Output ($outFromWordWrap)
                $j = $linesFromWordWrap
            }
        }
    }
}

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

function New-GameMessage([String]$messAttribute) {
    $randMess = @(
        ("You smell a " + $messAttribute + " frying."),
        "You feel like you are being watched.",
        "You stepped on a frog.",
        ("You stepped in " + $messAttribute + " shit."),
        ("You hear a " + $messAttribute + " snoring."),
        "You get the strange feeling that you're playing The Wizard's Castle.",
        ("You see messages written in " + $messAttribute + " on the wall."),
        "You think you hear Zot laughing at you.",
        "You suddenly have the feeling of deja vu.",
        "You start to wonder if you will ever make it out of here.",
        "You hear your stomach growling and feel hungry.",
        "You have a bad feeling about this.",
        ("You hear a " + $messAttribute + " talking."),
        ("You " + ("belched", "farted", "sneezed", "yawned", "coughed" | Get-Random) + " loudly.")
    )
    return $randMess[(Get-Random -Maximum ($randMess.Length))]       
}

function Invoke-Chest($funcMap, $funcPlayer) {
    $level = Get-Random -Maximum $funcMap.levels.Count
    $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
    $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    $attributeChange = ((Get-Random -Minimum 2 -Maximum 10) + 1)
    $randomPotion = ("Dexterity", "Intelligence", "Strength") | Get-Random
    $randomCurse = ("Forgetfulness", "Leech", "Lethargy") | Get-Random
    $randomDirection = ("N", "S", "E", "W") | Get-Random
    $randomGold = ((Get-Random -Minimum 99 -Maximum 1000) + 1)
    $tempValue = @(
        ("you find {0} gold pieces." -f $randomGold),
        ("you find a potion of {0}." -f $randomPotion),
        "Gas! You stagger from the room!",
        "Kaboom! It Explodes!",
        ("a wizard jumps out and puts the curse of {0} on you and runs out of the room!" -f $randomCurse),
        ("you find a piece of a map revealing the area around ({1}, {2}) Level {0}." -f ($level + 1), ($row + 1), ($column + 1))
    )
    $tempValue = ($tempValue | Get-Random)
    if ($tempValue -like "*$randomPotion*") {
        $funcPlayer.("Inc" + $randomPotion)($attributeChange)
    }
    if ($tempValue -like "*Kaboom!*") {
        if ($funcPlayer.armor -eq "Leather") { $attributeChange -= 1 }
        if ($funcPlayer.armor -eq "ChainMail") { $attributeChange -= 2 }
        if ($funcPlayer.armor -eq "Plate") { $attributeChange -= 3 }
        if ($attributeChange -gt 0) { $funcPlayer.DecStrength($attributeChange) }
        If ((Get-Random -Maximum 100) -gt 74 -and $funcPlayer.armor -gt 0) {
            $tempValue += ("`nOh no, your {0} armor is destroyed!" -f $funcPlayer.armor)
            $funcPlayer.armor = ""
        }
        If ((Get-Random -Maximum 100) -gt 60 -and $funcPlayer.lamp -eq $true) {
            $tempValue += "`nThe blast broke your lamp!"
            $funcPlayer.lamp = $false
            $funcPlayer.lampBurn = 0
        }
    }
    if ($tempValue -like "*$randomCurse*") {
        $funcPlayer.$randomCurse = $true
    }
    if ($tempValue -like "*gold*") {
        $funcPlayer.gold += $randomGold
    }
    if ($tempValue -like "*stagger*") {
        If ($randomDirection -eq "E") { $funcPlayer.East($funcMap) }     
        If ($randomDirection -eq "N") { $funcPlayer.North($funcMap) }     
        If ($randomDirection -eq "S") { $funcPlayer.South($funcMap) }     
        If ($randomDirection -eq "W") { $funcPlayer.West($funcMap) }     
    }
    if ($tempValue -like "*revealing*") {
        $rowMinus = $row - 1; If ($rowMinus -lt 0) { $rowMinus = ($funcMap.levels[$level].rows.Count - 1) } 
        $rowPlus = $row + 1; If ($rowPlus -gt ($funcMap.levels[$level].rows.Count - 1)) { $rowPlus = 0 } 
        $columnMinus = $column - 1; If ($columnMinus -lt 0) { $columnMinus = ($funcMap.levels[$level].rows[$row].columns.Count - 1) } 
        $columnPlus = $column + 1; If ($columnPlus -gt ($funcMap.levels[$level].rows[$row].columns.Count - 1)) { $columnPlus = 0 }
        $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = $funcMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = "-" }
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = "W" }
        $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = $funcMap.levels[$level].rows[$rowMinus].columns[$column].value
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "-" }
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "W" }
        $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = $funcMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = "-" }
        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = "W" }
        $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = $funcMap.levels[$level].rows[$row].columns[$columnMinus].value
        If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "-" }
        If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "W" }
        $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = $funcMap.levels[$level].rows[$row].columns[$columnPlus].value
        If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "-" }
        If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "W" }
        $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = $funcMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = "-" }
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = "W" }
        $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = $funcMap.levels[$level].rows[$rowPlus].columns[$column].value
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "-" }
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "W" }
        $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = $funcMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = "-" }
        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = "W" }
        $knownMap.levels[$level].rows[$row].columns[$column].value = $funcMap.levels[$level].rows[$row].columns[$column].value
        If ($knownMap.levels[$level].rows[$row].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$column].value = "-" }
        If ($knownMap.levels[$level].rows[$row].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$column].value = "W" }
    }
    return $tempValue
}

function Invoke-Orb($funcMap, $funcRaces, $funcPlayer, $funcMonsters, $funcTreasures) {
    $level = Get-Random -Maximum $funcMap.levels.Count
    $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
    $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    $tempValueArray = @(
        "yourself in a bloody heap.",
        "your mother telling you to clean your room.",
        "a soap opera re-run.",
        "yourself playing The Wizard's Castle.",
        "your life drifting before your eyes.",
        ("yourself in {0} class." -f (("fencing", "religion", "language", "alchemy") | Get-Random)),
        ("a {0} gazing back at you." -f ($funcMonsters | Get-Random)),
        ("a {0} eating the flesh from your corpse." -f ($funcMonsters | Get-Random)),
        ("a {0} using your leg-bone as a tooth-pick." -f ($funcMonsters | Get-Random)),
        ("yourself drinking from a pool and becomine a {0}." -f ($funcRaces[((0..($funcRaces.Length - 1) | Where-Object -FilterScript { $funcRaces[$PSItem][0] -ne $funcPlayer.race }) | Get-Random)][0])),
        ("a large mug of ale at ({0}, {1}) Level {2} and you feel VERY thristy." -f ($row + 1), ($column + 1), ($level + 1)),
        ("the {0} at ({2}, {3}) Level {1}!" -f $(If ($null -eq (Find-Treasure -funcMap $funcMap -funcTreasure ($funcTreasures | Get-Random))) { ("Bad Value", "Bad Value") } else { (Find-Treasure -funcMap $funcMap -funcTreasure ($funcTreasures | Get-Random)) })),
        ("a pile of gold at ({0}, {1})." -f $(If ($null -eq (Find-Gold -funcMap $funcMap -funcPlayer $funcPlayer)) { ("Bad Value", "Bad Value") } else { Find-Gold -funcMap $funcMap -funcPlayer $funcPlayer })),
        ("flares at ({0}, {1})." -f $(If ($null -eq (Find-Flares -funcMap $funcMap -funcPlayer $funcPlayer)) { ("Bad Value", "Bad Value") } else { Find-Flares -funcMap $funcMap -funcPlayer $funcPlayer })),
        ("stairs going {0} at ({2}, {3}) Level {1}." -f $(If ($null -eq (Find-Stairs -funcMap $funcMap)) { ("Bad Value", "Bad Value") } else { Find-Stairs -funcMap $funcMap })),
        ("a Chest at ({1}, {2}) Level {0}." -f $(If ($null -eq (Find-Chest -funcMap $funcMap)) { ("Bad Value", "Bad Value") } else { Find-Chest -funcMap $funcMap })),
        ("a {3} at ({1}, {2}) Level {0}." -f $(If ($null -eq (Find-Monster -funcMap $funcMap -funcMonsters $funcMonsters)) { ("Bad Value", "Bad Value") } else { Find-Monster -funcMap $funcMap -funcMonsters $funcMonsters })),
        ("a Sink-Hole at ({1}, {2}) Level {0}." -f (Find-SinkHole -funcMap $funcMap)),
        ("a Warp at ({1}, {2}) Level {0}." -f (Find-Warp -funcMap $funcMap)),
        ("THE ORB OF ZOT AT ({1}, {2}) Level {0}!" -f $(If ($null -eq (Find-Zot -funcMap $funcMap)) { ("Bad Value", "Bad Value") } else { Find-Zot -funcMap $funcMap }))
    )
    do {
        $tempValue = ($tempValueArray | Get-Random)    
    } while ($tempValue -like "*Bad Value*")
    return $tempValue
}

function Invoke-Pool($funcRaces, $funcPlayer) {
    If ($funcPlayer.Sex -eq "Male") { $newSex = "Female" } else { $newSex = "Male" }
    $newRace = $funcRaces[((0..($funcRaces.Length - 1) | Where-Object -FilterScript { $funcRaces[$PSItem][0] -ne $funcPlayer.race }) | Get-Random)][0]
    $tempValue = @(
        ("you turn into a {0}." -f $newRace),
        ("you are now a {0} {1}." -f $newSex, $funcPlayer.race),
        "you feel nimbler.",
        "you feel clumsier.",
        "you feel smarter.",
        "you feel dumber.",
        "you feel stronger.",
        "you feel weaker."
    )
    $tempValue = ($tempValue | Get-Random)
    if ($tempValue -clike "*are now a*") {
        $funcPlayer.Sex = $newSex
    }
    if ($tempValue -clike "*turn into*") {
        $funcPlayer.race = $newRace
    }
    if ($tempValue -like "*nimbler*") {
        $funcPlayer.IncDexterity(1)
    }
    if ($tempValue -like "*clumsier*") {
        $funcPlayer.DecDexterity(1)
    }
    if ($tempValue -like "*smarter*") {
        $funcPlayer.IncIntelligence(1)
    }
    if ($tempValue -like "*dumber*") {
        $funcPlayer.DecIntelligence(1)
    }
    if ($tempValue -like "*stronger*") {
        $funcPlayer.IncStrength(1)
    }
    if ($tempValue -like "*weaker*") {
        $funcPlayer.DecStrength(1)
    }
    return $tempValue
}

function Invoke-Forgetfulness($funcMap) {
    $i = 0
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
        $i++
    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -eq "X" -and $i -lt 1000)
    $funcMap.levels[$level].rows[$row].columns[$column].value = "X"
}

function Read-Book($funcMap, $funcRaces, $funcPlayer, $funcMonsters, $funcTreasures) {
    Write-Host $valueOne, $valueTwo
    $tempValueArray = @(
        "it's another volume of Zot's poetry. Yeech!",
        ("it's an old copy of play {0}." -f ($funcRaces[((0..($funcRaces.Length - 1)) | Get-Random)][0])),
        ("it's a {0} cook book." -f ($funcMonsters | Get-Random)),
        ("it's a self-improvement book on how to be a better {0}." -f $funcPlayer.race),
        ("it's a treasure map leading to a pile of gold at ({0}, {1})" -f $(If ($null -eq (Find-Gold -funcMap $funcMap -funcPlayer $funcPlayer)) { ("Bad Value", "Bad Value") } else { Find-Gold -funcMap $funcMap -funcPlayer $funcPlayer })),
        ("it's a manual of {0}!" -f (("dexterity", "intelligence", "strength") | Get-Random)),
        ("FLASH! OH NO! YOU ARE NOW A BLIND {0}" -f $funcPlayer.race),
        ("It sticks to your hands. Now you can't grab your {0}!" -f $funcPlayer.Weapon)
    )
    do {
        $tempValue = ($tempValueArray | Get-Random)    
    } while ($tempValue -like "*No Gold*")
    if ($tempValue -like "*dexterity*") {
        $funcPlayer.dexterity = $funcPlayer.maxAttrib
    }
    if ($tempValue -like "*intelligence*") {
        $funcPlayer.intelligence = $funcPlayer.maxAttrib
    }
    if ($tempValue -like "*strength*") {
        $funcPlayer.strength = $funcPlayer.maxAttrib
    }
    if ($tempValue -like "*blind*") {
        $funcPlayer.blind = $true
    }
    if ($tempValue -like "*sticks*") {
        $funcPlayer.bookStuck = $true
    }
    return $tempValue
}

function Find-Gold($funcMap, $funcPlayer) {
    for ($row = 0; $row -lt $funcMap.levels[$funcPlayer.location[0]].rows.Count; $row++) {
        for ($column = 0; $column -lt $funcMap.levels[$funcPlayer.location[0]].rows[$row].Columns.Count; $column++) {
            If ($funcMap.levels[$funcPlayer.location[0]].rows[$row].Columns[$column].value -eq "G") {
                return ($row + 1), ($column + 1)
            }
        }
    }
}

function Find-Flares($funcMap, $funcPlayer) {
    for ($row = 0; $row -lt $funcMap.levels[$funcPlayer.location[0]].rows.Count; $row++) {
        for ($column = 0; $column -lt $funcMap.levels[$funcPlayer.location[0]].rows[$row].Columns.Count; $column++) {
            If ($funcMap.levels[$funcPlayer.location[0]].rows[$row].Columns[$column].value -eq "F") {
                return ($row + 1), ($column + 1)
            }
        }
    }
}

function Find-Treasure($funcTreasure, $funcMap) {
    for ($level = 0; $level -lt $funcMap.levels.Count; $level++) {
        for ($row = 0; $row -lt $funcMap.levels[$level].rows.Count; $row++) {
            for ($column = 0; $column -lt $funcMap.levels[$level].rows[$row].Columns.Count; $column++) {
                If ($funcMap.levels[$level].rows[$row].Columns[$column].value -eq $funcTreasure) {
                    return $funcTreasure, ($level + 1), ($row + 1), ($column + 1)
                }
            }
        }
    }
}

function Find-Stairs($funcMap) {
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -ne "D" -and $funcMap.levels[$level].rows[$row].columns[$column].value -ne "U")
    return $funcMap.levels[$level].rows[$row].columns[$column].value, ($level + 1), ($row + 1), ($column + 1)
}

function Find-Chest($funcMap) {
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -ne "C")
    return ($level + 1), ($row + 1), ($column + 1)
}

function Find-SinkHole($funcMap) {
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -ne "S")
    return ($level + 1), ($row + 1), ($column + 1)
}

function Find-Warp($funcMap) {
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -ne "W")
    return ($level + 1), ($row + 1), ($column + 1)
}

function Find-Monster($funcMap, $funcMonsters) {
    do {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
    } while (-not ($funcMonsters.Contains($funcMap.levels[$level].rows[$row].columns[$column].value)))
    return ($level + 1), ($row + 1), ($column + 1), $funcMap.levels[$level].rows[$row].columns[$column].value
}

function Find-Zot($funcMap) {
    If ((Get-Random -Maximum 100) -gt 50) {
        for ($level = 0; $level -lt $funcMap.levels.Count; $level++) {
            for ($row = 0; $row -lt $funcMap.levels[$level].rows.Count; $row++) {
                for ($column = 0; $column -lt $funcMap.levels[$level].rows[$row].Columns.Count; $column++) {
                    If ($funcMap.levels[$level].rows[$row].Columns[$column].value -eq "Z") {
                        return ($level + 1), ($row + 1), ($column + 1)
                    }
                }
            }
        }
    }
    else {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
        return ($level + 1), ($row + 1), ($column + 1)
    }
}

function Show-Map($funcKnownMap, $funcPlayer, $funcTreasures, $funcMonsters) {
    Remove-Variable -Name tempValueLocal -ErrorAction SilentlyContinue
    $funcKnownMap.levels[$funcPlayer.location[0]].rows[$funcPlayer.location[1]].columns[$funcPlayer.location[2]].value = "<*>"
    for ($row = 0; $row -lt $funcKnownMap.levels[$funcPlayer.location[0]].rows.Count; $row++) {
        $tempValueLocal = ""
        $funcKnownMap.levels[$funcPlayer.location[0]].rows[$row].columns.value | ForEach-Object {
            If ($funcTreasures.Contains($PSItem)) {
                $tempValueLocal += " T "
            }
            elseif ($funcMonsters.Contains($PSItem)) {
                $tempValueLocal += " M "
            }
            elseif ($PSItem -eq "Z") {
                $tempValueLocal += " W "
            }
            elseif ($PSItem -eq "<*>") {
                $tempValueLocal += "{0}" -f $PSItem
            }
            else {
                $tempValueLocal += " {0} " -f $PSItem
            }
        }
        Write-Output ($tempValueLocal)
    }
}

function Start-MonsterAttack($funcMonster, $funcPlayer) {
    If ($funcMonster.Webbed -ne $true) {
        Write-Output ("`nThe {0} attacks." -f $funcMonster.race)
        If (((Get-Random -Maximum 100) + $funcMonster.dexterity) -gt 60) {
            Write-Output ("The {0} hit you!`n" -f $funcMonster.race)
            If ((Get-Random -Maximum 100) -gt 90) {
                Write-Output "`n"
                Write-Warning ("Oh no, your {0} armor just broke!" -f $funcPlayer.armor)
                $funcPlayer.armor = ""
            }
            elseif ((Get-Random -Maximum 100) -gt 95 -and $funcPlayer.lamp -eq $true) {
                Write-Output "`n"
                Write-Warning "Your Lamp just got broken!"
                $funcPlayer.lamp = $false
            }
            $funcDamage = ((Get-Random -Maximum 10) + 1)
            if ($funcPlayer.armor -eq "Leather") { $funcDamage -= 1 }
            if ($funcPlayer.armor -eq "ChainMail") { $funcDamage -= 2 }
            if ($funcPlayer.armor -eq "Plate") { $funcDamage -= 3 }
            if ($funcDamage -gt 0) { $funcPlayer.DecStrength($funcDamage) }
        }
        else {
            Write-Output ("What luck, the {0} missed.`n" -f $funcMonster.race)
        }
    }
    else {
        Write-Output ("The {0} is stuck in a web and can't attack." -f $funcMonster.race)
    }
}

function Start-PlayerAttack($funcMonster, $funcPlayer) {
    If ($funcPlayer.bookStuck) {
        Write-Output ("`nYou can't beat it to death with a book stupid {0}!" -f $funcPlayer.race)
    }
    elseif (-not ($funcPlayer.weapon -gt 0)) {
        Write-Output ("`nYou reach for your weapon and come up empty handed!")
        Write-Output ("Sorry stupid {0}, but ** pounding ** on it won't do any good." -f $funcPlayer.race)
    }
    else {
        Write-Output ("`nYou attack the {0}!" -f $funcMonster.race)
        If (((Get-Random -Maximum 100) + $funcPlayer.dexterity) -gt 60) {
            Write-Output ("You hit this {0}!`n" -f $funcMonster.race)
            $funcDamage = ((Get-Random -Maximum 10) + 1)
            if ($funcPlayer.weapon -eq "Dagger") { $funcDamage += 1 }
            if ($funcPlayer.weapon -eq "Mace") { $funcDamage += 2 }
            if ($funcPlayer.weapon -eq "Sword") { $funcDamage += 3 }
            if ($funcDamage -gt 0) { $funcMonster.DecStrength($funcDamage) }
            If ($funcMonster.race -eq "Dragon" -or $funcMonster.race -eq "Gargoyle") {
                If ((Get-Random -Maximum 100) -gt 90) {
                    Write-Output "`n"
                    Write-Warning ("Oh no, your {0} just shatterd!" -f $funcPlayer.weapon)
                    $funcPlayer.weapon = ""
                }
            }
        }
        else {
            Write-Output ("Drats, you missed the {0}.`n" -f $funcMonster.race)
        }
    }
}

function Start-VendorTrade($funcMonster, $funcPlayer, [ref]$funcMonsterIgnore) {
    If ($funcPlayer.treasures.Count -eq 0 -and $funcPlayer.gold -lt 1000) {
        Write-Output ("`nSorry, {0}, you are too poor to trade!" -f $funcPlayer.race)
    }
    else {
        If ($funcPlayer.treasures.Count -gt 0) {
            $toRemove = @(0..7)
            for ($i = 0; $i -lt $funcPlayer.treasures.Count; $i++) {
                $tempValue = (Get-Random -Minimum 1000 -Maximum 10001)
                $choice = New-Menu -Question ("`n`tDo you want to sell the {0} for {1} gold pieces?" -f $funcPlayer.treasures[$i], $tempValue) -Choices (
                    ("&Yes", ("Sell the {0}." -f $funcPlayer.treasures[$i])),
                    ("&No", "No sale!")
                )
                If ($choice[0] -like "*Yes*") {
                    $funcPlayer.gold += $tempValue
                    $toRemove[$i] = $funcPlayer.treasures[$i]
                }
            }
            for ($i = 0; $i -lt $toRemove.Count; $i++) {
                If ($toRemove[$i] -notmatch "[0-9]") { $funcPlayer.treasures.remove($toRemove[$i]) | Out-Null }
            }
        }
        If ($funcPlayer.gold -lt 1000) {
            Write-Output ("`nSorry, {0}, you are too poor to trade!" -f $funcPlayer.race)
        }
        else {
            If ($funcPlayer.gold -gt 1499) {
                Get-Armor($funcPlayer)
            }
            If ($funcPlayer.gold -gt 1499) {
                Get-Weapon($funcPlayer)
            }
            If ($funcPlayer.gold -gt 999) {
                Get-Lamp($funcPlayer)
            }
            foreach ($item in ("Dexterity", "Intelligence", "Strength")) {
                If ($funcPlayer.gold -gt 999) {
                    do {
                        Write-Output ("`nOK, {0}, you have {1} gold pieces." -f $funcPlayer.race, $funcPlayer.gold)
                        Write-Output ("Your {0} is {1}." -f $item, $player.$item)
                        $choice = New-Menu -Question ("`tDo you want to buy a potion of {0} for 1000 gold pieces?" -f $item) -Choices (
                            ("&Yes", ("Buy the {0} potion." -f $item)),
                            ("&No", "Don't buy it!")
                        )
                        If ($choice[0] -like "*Yes*") {
                            $attributeChange = ((Get-Random -Minimum 2 -Maximum 10) + 1)
                            $funcPlayer.("Inc" + $item)($attributeChange)
                            $funcPlayer.gold -= 1000
                        }
                    } while ($funcPlayer.gold -gt 999 -and $choice[0] -like "*Yes*")            
                }
            }
            If ($funcPlayer.gold -gt 499 -and $funcPlayer.lamp) {
                Write-Output ("`nOK, {0}, you have {1} gold pieces." -f $funcPlayer.race, $funcPlayer.gold)
                Write-Output ("Your Lamp has {0} uses left." -f $funcPlayer.lampBurn)
                $choice = New-Menu -Question ("`tDo you want to buy a Oil for your Lamp for 500 gold pieces?") -Choices (
                    ("&Yes", "Buy the Lamp Oil."),
                    ("&No", "Don't buy it!")
                )
                If ($choice[0] -like "*Yes*") {
                    $funcPlayer.gold -= 500
                    $funcPlayer.lampBurn = 10
                }
            }
        }
    }
    $funcMonsterIgnore.Value = $true
}

function Get-Race($funcRaces) {
    do {
        $funcRace = Read-Host -Prompt ("`n`tChoose Your Race`n" + "Would you like to be a {0}, {1}, {2}, or {3}" -f $($funcRaces | ForEach-Object { $PSItem[0] }))
        $funcRace = $(Get-Culture).TextInfo.ToTitleCase($funcRace.ToLower())
        If ($funcRace -notin $($funcRaces | ForEach-Object { $PSItem[0] })) {
            Write-Output "`n"
            Write-Warning "You bumbling buffoon, $funcRace is not a choice, please read the question and answer correctly!"
        }
    } while ($funcRace -notin $($funcRaces | ForEach-Object { $PSItem[0] }))

    for ($i = 0; $i -lt $funcRaces.Count; $i++) {
        If ($funcRaces[$i][0] -eq $funcRace) {
            $funcRace = $i
        }
    }
    return $funcRace
}

function Get-Sex($funcRace) {
    while ($sex -ne "Male" -and $sex -ne "Female" -and $sex -ne "Other") {
        $sex = Read-Host -Prompt ("`n`tOk, {0}, choose Your Sex`n Would you like to be a Male, Female, or Other" -f $funcRace[0])
        $sex = (Get-Culture).TextInfo.ToTitleCase($sex.ToLower())
        If ($sex -ne "Male" -and $sex -ne "Female" -and $sex -ne "Other") {
            Write-Output "`n"
            Write-Warning ("You stupid {0}, $sex is not a choice!" -f $funcRace[0])
        }
    }
    return $sex
}

function Get-ExtraPoints($funcPlayer) {
    [Int16]$extraPoints = 8
    If ($funcPlayer.race -eq "Hobbit") {
        $extraPoints -= 4 # Hobbits get 4 less points than other races
    }
    do {
        Write-Output ("`n`tOk, {0}, you have $extraPoints points left to distribute." -f $funcPlayer.race)
        $choice = New-Menu -Question "`tWhat attribute do you want to increase?" -Choices (
            ("&Dexterity", "Increase Dexterity"),
            ("&Intelligence", "Increase Intelligence"),
            ("&Strength", "Increase Strength")
        )
        $choice = ($choice[0]).Substring(1, ($choice[0]).Length - 1)
        $amount = Read-Host -Prompt ("`nHow many points do you want to assign to {0} (current {0} = {1})" -f $choice, $funcPlayer.$choice)
        If (-not ($amount -match "^[0-9]+$")) {
            Write-Output "`n"
            Write-Warning ("Stupid, {0}, {1} is not a positive number!" -f $funcPlayer.race, $amount)
        }
        elseif ([Int16]$amount -gt $extraPoints) {
            Write-Output "`n"
            Write-Warning ("Stupid, {0}, you only have {1} points left to distribute!" -f $funcPlayer.race, $extraPoints)
        }
        elseif (($funcPlayer.$choice + $amount) -gt $funcPlayer.maxAttrib) {
            Write-Output "`n"
            Write-Warning ("Stupid, {0}, your {1} can't be greater than {2}!" -f $funcPlayer.race, $choice, $funcPlayer.maxAttrib)
        }
        else {
            $funcPlayer.("Inc" + $choice)($amount)
            $extraPoints -= $amount
        }
    } while ($extraPoints -gt 0)
}

function Get-Armor($funcPlayer) {
    Write-Output ("`n`tOk, {0}, you have {1} gold to buy items." -f $funcPlayer.race, $funcPlayer.gold)
    Write-Output ("You have {0} armor." -f $(if ($funcPlayer.armor -gt 0) { $funcPlayer.armor } else { "NO" } ) )
    If ($player.gold -gt 1000) {
        $plateCost = 2500
        $chainMailCost = 2000
        $leatherCost = 1500
    }
    else {
        $plateCost = 30
        $chainMailCost = 20
        $leatherCost = 10
    }
    do {
        $choice = New-Menu -Question "`n`tWhat type of armor do you want?" -Choices (
            ("&Plate", ("Plate cost {0} Gold" -f $plateCost)),
            ("&ChainMail", ("ChainMail cost {0} Gold" -f $chainMailCost)),
            ("&Leather", ("Leather cost {0} Gold" -f $leatherCost)),
            ("&None", "None")
        )
        $tempValue = $choice[0]
        If ([Int32]($choice[1] -replace '[^0-9]', '') -gt $funcPlayer.gold) {
            Write-Output ("You don't have that much gold you silly {0}." -f $funcPlayer.race)
        }
        elseif ($tempValue -notlike "*none*") {
            $funcPlayer.armor = ($choice[0]).Substring(1, ($choice[0]).Length - 1)
            $funcPlayer.gold -= ($choice[1] -replace '[^0-9]', '')
            $tempValue = "&None"
        }
    } while ($tempValue -notlike "*none*")
}

function Get-Weapon($funcPlayer) {
    Write-Output ("`n`tOk, {0}, you have {1} gold to buy items." -f $funcPlayer.race, $funcPlayer.gold)
    Write-Output ("You have {0}." -f $(if ($funcPlayer.weapon -gt 0) { "a {0}" -f $funcPlayer.weapon } else { "NO WEAPON" } ) )
    If ($player.gold -gt 1000) {
        $swordCost = 2500
        $maceCost = 2000
        $daggerCost = 1500
    }
    else {
        $swordCost = 30
        $maceCost = 20
        $daggerCost = 10
    }
    do {
        $choice = New-Menu -Question "`n`tWhat type of weapon do you want?" -Choices (
            ("&Sword", ("Sword cost {0} Gold" -f $swordCost)),
            ("&Mace", ("Mace cost {0} Gold" -f $maceCost)),
            ("&Dagger", ("Dagger cost {0} Gold" -f $daggerCost)),
            ("&None", "None")
        )
        $tempValue = $choice[0]
        If ([Int32]($choice[1] -replace '[^0-9]', '') -gt $funcPlayer.gold) {
            Write-Output ("You don't have that much gold you silly {0}." -f $funcPlayer.race)
        }
        elseif ($tempValue -notlike "*none*") {
            $funcPlayer.weapon = ($choice[0]).Substring(1, ($choice[0]).Length - 1)
            $funcPlayer.gold -= ($choice[1] -replace '[^0-9]', '')
            $tempValue = "&None"
        }
    } while ($tempValue -notlike "*none*")
}

function Get-Lamp($funcPlayer) {
    If ($funcPlayer.gold -gt 19) {
        Write-Output ("`n`tOk, {0}, you have {1} gold to buy items." -f $funcPlayer.race, $funcPlayer.gold)
        If ($player.gold -gt 999) {
            $lampCost = 1000
        }
        else {
            $lampCost = 20
        }
        $choice = New-Menu -Question "`tDo you want to buy a lamp?" -Choices (
            ("&Yes", ("Lamp cost {0} Gold" -f $lampCost)),
            ("&No", "Do not purchase a lamp")
        )
        If ($choice[0] -like "*Yes*") {
            $funcPlayer.lamp = $true
            $funcPlayer.lampBurn = 10
            $funcPlayer.gold -= ($choice[1] -replace '[^0-9]', '')
        }
    }
}

function Get-Flares($funcPlayer) {
    if ($funcPlayer.gold -gt 0) {
        do {
            Write-Output ("`n`tOk, {0}, you have {1} gold to buy items." -f $funcPlayer.race, $funcPlayer.gold)
            $amount = Read-Host -Prompt ("`nHow many flares would you like to purchase (1 Gold each)")
            If (-not ($amount -match "^[0-9]+$")) {
                Write-Output "`n"
                Write-Warning ("Stupid, {0}, {1} is not a positive number!" -f $funcPlayer.race, $amount)
            }
            elseif ([Int32]$amount -gt $funcPlayer.gold) {
                Write-Output "`n"
                Write-Warning ("Stupid, {0}, you only have {1} gold!" -f $funcPlayer.race, $funcPlayer.gold)
            }
            else {
                $funcPlayer.flares += $amount
                $funcPlayer.gold -= $amount
            }
        } while ($funcPlayer.gold -gt 0 -and $amount -gt 0)
    }
}

function New-Map($randLevels, $randRows, $randColumns) {
    $newMap = { @() }.Invoke()
    $newMap.Add('{')
    $newMap.Add('    "map": "MainMap",')
    $newMap.Add('    "levels": [')
    for ($i = 0; $i -lt $randLevels; $i++) {
        $newMap.Add('        {')
        $newMap.Add(('            "level": "{0}",' -f ($i + 1)))
        $newMap.Add('            "rows": [')
        for ($j = 0; $j -lt $randRows; $j++) {
            $newMap.Add('                {')
            $newMap.Add(('                    "row": "{0}",' -f ($j + 1)))
            $newMap.Add('                    "columns": [')
            for ($k = 0; $k -lt $randColumns; $k++) {
                $newMap.Add('                        {')
                $newMap.Add(('                            "column": "{0}",' -f ($k + 1)))
                $newMap.Add('                            "value": "x"')
                $newMap.Add('                        },')
            }
            $newMap.Add('                    ]')
            $newMap.Add('                },')
        }
        $newMap.Add('            ]')
        $newMap.Add('        },')
    }
    $newMap.Add('    ]')
    $newMap.Add('}')
    for ($i = 0; $i -lt ($newMap.Count - 1); $i++) {
        If ($newMap[$i + 1].Contains("]")) {
            $newMap[$i] = $newMap[$i].Replace("},", "}")
        }
    }
    Write-Output $newMap | Out-File -FilePath "./Map.json" -Force
}

function Initialize-Map($funcMap, $funcTreasures, $funcRoomValues, $funcMonsters) {
    $funcMap.levels[0].rows[0].columns[3].value = "E"
    $tempValue = { @($funcTreasures) }.Invoke()
    $tempTotal = $tempValue.Count
    for ($i = 0; $i -lt ($tempTotal + 1); $i++) {
        do {
            $level = Get-Random -Maximum $funcMap.levels.Count
            $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
            $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
        } while ($funcMap.levels[$level].rows[$row].columns[$column].value -cne "x")
        If ($i -eq 0) {
            $funcMap.levels[$level].rows[$row].columns[$column].value = "Z"
        }
        else {
            $funcMap.levels[$level].rows[$row].columns[$column].value = ($tempValue[(Get-Random -Maximum $tempValue.Count)])
            $tempValue.Remove($funcMap.levels[$level].rows[$row].columns[$column].value) | Out-Null
        }
    }

    for ($level = 0; $level -lt $funcMap.levels.Count; $level++) {
        for ($row = 0; $row -lt $funcMap.levels[$level].rows.Count; $row++) {
            for ($column = 0; $column -lt $funcMap.levels[$level].rows[$row].columns.Count; $column ++) {
                If ($funcMap.levels[$level].rows[$row].columns[$column].value -ceq "x") {
                    do {
                        $roomObject = Get-Random -InputObject ($funcRoomValues + "M")
                        If ((Get-Random -Maximum 100) -gt 60) { $roomObject = "X" } elseif ((Get-Random -Maximum 100) -gt 70) { $roomObject = "M" } 
                        If (($roomObject -eq "D") -and ($level -ne ($funcMap.levels.Count - 1)) -and ($funcMap.levels[$level + 1].rows[$row].columns[$column].value -eq "x")) {
                            $funcMap.levels[$level].rows[$row].columns[$column].value = $roomObject
                            $funcMap.levels[$level + 1].rows[$row].columns[$column].value = "U"
                        }
                        elseif (($roomObject -eq "S") -and ($level -ne ($funcMap.levels.Count - 1))) {
                            $funcMap.levels[$level].rows[$row].columns[$column].value = $roomObject
                        }
                        elseif (($roomObject -ne "D") -and ($roomObject -ne "S")) {
                            If ($roomObject -eq "M") {
                                $roomObject = $funcMonsters[(Get-Random -Maximum ($funcMonsters.Count))]
                            }
                            $funcMap.levels[$level].rows[$row].columns[$column].value = $roomObject
                        }
                    } while ($funcMap.levels[$level].rows[$row].columns[$column].value -ceq "x")                    
                }
            }
        }
    }
    return $funcMap
}

function Initialize-KnownMap($funcKnownMap) {
    for ($level = 0; $level -lt $funcKnownMap.levels.Count; $level++) {
        for ($row = 0; $row -lt $funcKnownMap.levels[$level].rows.Count; $row++) {
            for ($column = 0; $column -lt $funcKnownMap.levels[$level].rows[$row].columns.Count; $column ++) {
                If ($funcKnownMap.levels[$level].rows[$row].columns[$column].value -ne "E") {
                    $funcKnownMap.levels[$level].rows[$row].columns[$column].value = "X"
                }
            }
        }
    }
    return $funcKnownMap
}

function Invoke-PlayerExit($funcPlayer) {
    foreach ($treas in $funcPlayer.treasures) { $funcTreasure += ($treas + ",") }
    if ($funcTreasure.Length -gt 0) { $funcTreasure = $funcTreasure.Substring(0, ($funcTreasure.Length - 1)) }
    $tempValue = "**** YOU EXITED THE CASTLE! ****" 
    $tempValue += "`n`tWhen you exited, you had:"
    If ($funcPlayer.OrbOfZot -eq $true) {
        $tempValue += "`n`t*** Congratulations, you made it out alive with the Orb Of Zot ***"
    }
    else {
        $tempValue += "`n`tYour miserable life"
    }
    If ($funcTreasure.Length -gt 0) {
        $tempValue += ("`n`tTreasures: {0}" -f $funcTreasure)
    }
    else {
        $tempValue += ("`n`t* No Treasures *")
    }
    If ($funcPlayer.armor.Length -gt 0) {
        $tempValue += ("`n`t{0} armor" -f $funcPlayer.armor)
    }
    else {
        $tempValue += "`n`t* No armor *"
    }
    If ($funcPlayer.weapon.Length -gt 0) {
        $tempValue += ("`n`ta {0}" -f $funcPlayer.weapon)
    }
    else {
        $tempValue += "`n`t* No weapon *"
    }
    If ($funcPlayer.lamp -eq $true) {
        $tempValue += "`n`ta lamp"
    }
    $tempValue += ("`n`tYou also had {0} flares and {1} pieces of gold" -f $funcPlayer.flares, $funcPlayer.gold)
    $tempValue += ("`n`tYou were in Zot's Castle for {0} turns" -f $funcPlayer.turns)
    return $tempValue
}

function Invoke-PlayerDeath($funcPlayer) {
    Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
    foreach ($treas in $funcPlayer.treasures) { $funcTreasure += ($treas + ",") }
    if ($funcTreasure.Length -gt 0) { $funcTreasure = $funcTreasure.Substring(0, ($funcTreasure.Length - 1)) }
    $tempValue = "**** YOU DIED! ****" 
    $tempValue += "`n`tWhen you died, you had:"
    If ($funcTreasure.Length -gt 0) {
        $tempValue += ("`n`tTreasures: {0}" -f $funcTreasure)
    }
    else {
        $tempValue += ("`n`t* No Treasures *")
    }
    If ($funcPlayer.armor.Length -gt 0) {
        $tempValue += ("`n`t{0} armor" -f $funcPlayer.armor)
    }
    else {
        $tempValue += "`n`t* No armor *"
    }
    If ($funcPlayer.weapon.Length -gt 0) {
        $tempValue += ("`n`ta {0}" -f $funcPlayer.weapon)
    }
    else {
        $tempValue += "`n`t* No weapon *"
    }
    If ($funcPlayer.lamp -eq $true) {
        $tempValue += "`n`ta lamp"
    }
    $tempValue += ("`n`tYou also had {0} flares and {1} pieces of gold" -f $funcPlayer.flares, $funcPlayer.gold)
    $tempValue += ("`n`tYou managed to stay alive for {0} turns" -f $funcPlayer.turns)
    return $tempValue
}

function Invoke-MainFunc {
    [bool]$noCommand = $false
    [System.Array]$runestaffLocation = @(0, 0, 0)
    [System.Array]$tempLocation = @(0, 0, 0)
    [bool]$monsterIgnore = $false
    [bool]$allVendorMad = $false
    [String[]]$roomValues = @("B", "C", "D", "F", "G", "O", "P", "S", "V", "W", "X")
    [String]$sex = ""
    [System.Object]$race = ""
    [System.Collections.ArrayList]$emptyRoomContent = @()
    [System.Collections.ObjectModel.Collection[String]]$monsters = @(
        "Balrog",
        "Bear",
        "Chimera",
        "Dragon",
        "Gargoyle",
        "Goblin",
        "Kobold",
        "Minotaur",
        "Ogre",
        "Orc",
        "Troll",
        "Wolf"
    )
    [System.Collections.ObjectModel.Collection[String]]$treasures = @(
        "The Blue Flame",
        "The Green Gem",
        "The Norn Stone",
        "The Opal Eye",
        "The Palantir",
        "The Pale Pearl",
        "The Ruby Red",
        "The Silmaril"
    )
    [System.Array]$races = @(
        [System.Array]("Dwarf", 6, 8, 10),
        [System.Array]("Elf", 10, 8, 6),
        [System.Array]("Hobbit", 12, 8, 4),
        [System.Array]("Homo-Sapien", 8, 8, 8)
    ) # Race, Dexterity, Intelligence, Strength
    [System.Array]$availableActions = @(
        [System.Array]("&M", "Show map"),
        [System.Array]("&O", "Open book or chest"),
        [System.Array]("&P", "Drink from pool"),
        [System.Array]("&T", "Use the Runestaff to teleport"),
        [System.Array]("&U", "Up stairs"),
        [System.Array]("&D", "Down stairs"),
        [System.Array]("&N", "North"),
        [System.Array]("&S", "South"),
        [System.Array]("&E", "East"),
        [System.Array]("&W", "West"),
        [System.Array]("&G", "Gaze into crystal orb"),
        [System.Array]("&F", "Light a flare"),
        [System.Array]("&L", "Shine lamp into adjacent room"),
        [System.Array]("&Q", "Quit the game"),
        [System.Array]("&A", "Attack monster or vendor"),
        [System.Array]("&R", "Retreat from battle"),
        [System.Array]("&B", "Bribe monster or vendor")
    )
    Remove-Variable -Name tempValue -ErrorAction SilentlyContinue

    Show-StartingMessages
    Clear-Host
    $choice = New-Menu -Question "`tWould you like the standard 8x8x8 map or a random map?" -Choices (
        ("&Standard", "Standard 8x8x8 Map"),
        ("&Random", "Random RxRxR")
    )
    If ($choice[0] -clike "*Standard*") {
        $randLevels = 8
        $randRows = 8
        $randColumns = 8
    }
    else {
        $randLevels = ((Get-Random -Minimum 8 -Maximum 15) + 1) 
        $randRows = ((Get-Random -Minimum 8 -Maximum 30) + 1) 
        $randColumns = ((Get-Random -Minimum 8 -Maximum 50) + 1)
    }
    New-Map -randLevels $randLevels -randRows $randRows -randColumns $randColumns
    $map = (Initialize-Map -funcMap (Get-Content -Path ".\Map.json" | ConvertFrom-Json) -funcTreasures $treasures -funcRoomValues $roomValues -funcMonsters $monsters)
    $knownMap = (Initialize-KnownMap -funcKnownMap (Get-Content -Path ".\Map.json" | ConvertFrom-Json))
    Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
    [string]$tempValue = Get-Race -funcRaces $races
    $tempValue = $tempValue.Trim()
    $race = $races[$tempValue]
    Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
    $sex = Get-Sex -funcRace $race
    $player = New-Character -Race $race[0] -Sex $sex -Dexterity $race[1] -Intelligence $race[2] -Strength $race[3]
    Get-ExtraPoints($player)
    Get-Armor($player)
    Get-Weapon($player)
    Get-Lamp($player)
    Get-Flares($player)

    Clear-Host
    $runestaffLocation[0], $runestaffLocation[1], $runestaffLocation[2], $tempValue = Find-Monster -funcMap $map -funcMonsters $monsters
    $runestaffLocation[0] -= 1
    $runestaffLocation[1] -= 1
    $runestaffLocation[2] -= 1
    # $player.strength = 800; $player.intelligence = 800; $player.dexterity = 800 # COMMENT
    Write-Output ("Ok, {0}, you are now entering Zot's castle!" -f $player.race)
    Write-Output ("Levels = {0}, Rows = {1}, Columns = {2}" -f $map.levels.Count, $map.levels[0].rows.Count, $map.levels[0].rows[0].columns.Count)

    do {
        If ($player.dexterity -lt 1 -or $player.intelligence -lt 1 -or $player.strength -lt 1) {
            Write-Output "`n"
            Write-Warning ("{0}" -f (Invoke-PlayerDeath($player)))
            Read-Host -Prompt "Press Enter to continue"
            Clear-Host
            $noCommand = $true
            $action = "Q"
        }
        $player.turns += 1
        $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value
        If ($knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -ceq "X") {
            $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
        }
        $playerActions = $($availableActions)
        Write-Output ("`nYou are at ({0}, {1}) Level {2}" -f ($player.location[1] + 1), ($player.location[2] + 1), ($player.location[0] + 1))
        Write-Output ("`nDexterity = {0}  Intelligence = {1}  Strength = {2}" -f $player.dexterity, $player.intelligence, $player.strength)
        Write-Output ("Treasures = {0}  Flares = {1}  Gold = {2}" -f $player.treasures.Count, $player.flares, $player.gold)
        Write-Output ("Armor = {0}  Weapon = {1} $(If($player.lamp -eq $true){" and you have a Lamp"}else{$null})" -f $player.armor, $player.weapon)
        If ($player.Runestaff) { Write-Output ("You have the Runestaff!") }
        If ($player.treasures.Contains("The Ruby Red") -and $player.lethargy -eq $true) {
            $player.lethargy = $false
            Write-Output "`n"
            Write-Warning "The Ruby Red cures your Lethargy!"
        }
        If ($player.treasures.Contains("The Pale Pearl") -and $player.leech -eq $true) {
            $player.leech = $false
            Write-Output "`n"
            Write-Warning "The Pale Pearl heals the curse of the Leech!"
        }
        If ($player.treasures.Contains("The Opal Eye") -and $player.blind -eq $true) {
            $player.blind = $false
            Write-Output "`n"
            Write-Warning "The Opal Eye cures your blindness!"
        }
        If ($player.treasures.Contains("The Green Gem") -and $player.forgetfulness -eq $true) {
            $player.forgetfulness = $false
            Write-Output "`n"
            Write-Warning "The Green Gem cures your forgetfulness!"
        }
        If ($player.treasures.Contains("The Blue Flame") -and $player.bookStuck -eq $true) {
            $player.bookStuck = $false
            Write-Output "`n"
            Write-Warning "The Blue Flame burns the book off your hands!"
        }
        $cursed = ""
        If ($player.blind) {
            $cursed += "Blind "
        }
        If ($player.forgetfulness) {
            $cursed += "Forgetfulness "
            Invoke-Forgetfulness($knownMap)
        }
        If ($player.leech) {
            $cursed += "Leech "
            $player.DecStrength($([Int16](Get-Random -Minimum 1 -Maximum 3)))
        }
        If ($player.lethargy) {
            $cursed += "Lethargy "
        }
        If ($cursed.Length -gt 0) {
            Write-Output ("You are cursed with {0}" -f $cursed)
        }

        # Entrance in room sequence
        If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "E") {
            Write-Output ("`nHere you find the Entrance.")
        }
        # Treaure in room sequence
        elseif ($treasures.Contains($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value)) {
            Write-Output "`n"
            Write-Warning ("Here you find {0}. The {0} is now yours!" -f $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value)
            $player.treasures.Add($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value)
            $treasures.Remove($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value) | Out-Null
            $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
            $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
            $emptyRoomContent.Add((($player.location -join ""), ("an empty room"))) | Out-Null
        }
        # Gold in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "G") {
            Write-Output "`n"
            Write-Output ("Here you find Gold.")
            $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
            $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
            $emptyRoomContent.Add((($player.location -join ""), ("an empty room"))) | Out-Null
            Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
            $tempValue = (Get-Random -Maximum 1000) + 1
            Write-Output ("You found {0} gold, you now have {1} gold." -f $tempValue, ($player.gold += $tempValue))
        }
        # Flares in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "F") {
            Write-Output "`n"
            Write-Output ("Here you find Flares.")
            $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
            $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
            $emptyRoomContent.Add((($player.location -join ""), ("an empty room"))) | Out-Null
            Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
            $tempValue = (Get-Random -Maximum 10) + 1
            Write-Output ("You found {0} flares, you now have {1} flares." -f $tempValue, ($player.flares += $tempValue))
        }
        # Sink-Hole in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "S") {
            Write-Output "`n"
            Write-Warning ("Here you find a Sink-Hole.")
            Write-Output "You sink to the next level!"
            Start-Sleep -Seconds 2
            $player.Sink()
            $noCommand = $true
        }
        # Warp in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "W") {
            Write-Output "`n"
            Write-Warning ("Here you find a Warp.")
            Write-Output "You are being warped!"
            Start-Sleep -Seconds 2
            $player.Warp($map)
            $noCommand = $true        
        }
        # Crystal-Orb in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "O") {
            Write-Output "`n"
            Write-Output ("Here you find a Crystal-Orb.")
        }
        # Stairs-Down in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "D") {
            Write-Output "`n"
            Write-Output ("Here you find a Stairs-Down.")
        }
        # Stairs-Up in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "U") {
            Write-Output "`n"
            Write-Output ("Here you find a Stairs-Up.")
        }
        # Empty-Room in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "X") {
            Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
            for ($i = 0; $i -lt $emptyRoomContent.Count; $i++) {
                If (($player.location -join "") -eq ($emptyRoomContent[$i][0])) {
                    $tempValue = $emptyRoomContent[$i][1]
                }
            }
            If (-not ($tempValue -gt 0)) {
                If (((Get-Random -Maximum 100) + 1) -gt 70) {
                    $tempValue = @(
                        "the skeletal remains and rusted armor of a former seeker of Zot's Orb",
                        "a bloody sacrificial altar",
                        ("a wandering {0}" -f (("cat", "dog", "rat", "raccoon", "goat", "pig") | Get-Random)),
                        ("the decaying remains of a {0}" -f ($monsters | Get-Random))
                    )
                    $tempValue = ($tempValue | Get-Random)
                }
                else {
                    $tempValue = "an empty room"
                }
                $emptyRoomContent.Add((($player.location -join ""), ($tempValue))) | Out-Null
            }
            Write-Output "`n"
            Write-Output ("Here you find {0}." -f $tempValue)
        }
        # Book in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "B") {
            Write-Output "`n"
            Write-Output ("Here you find a Book.")
        }
        # Chest in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "C") {
            Write-Output "`n"
            Write-Output ("Here you find a Chest.")
        }
        # Pool in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "P") {
            Write-Output ("`nHere you find a Pool.")
        }
        # Monster or Vendor in room sequence
        elseif ($monsters.Contains($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value) -or $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "V") {
            Remove-Variable -Name monster -ErrorAction SilentlyContinue
            If (-not (Get-Variable -Name ("monster" + ($player.location -join "") -replace (" ", "")) -ErrorAction SilentlyContinue)) {
                New-Variable -Name ("monster" + ($player.location -join "") -replace (" ", "")) -Value (New-Character -Race ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value) -Dexterity ((Get-Random -Maximum 18) + 1) -Intelligence ((Get-Random -Maximum 18) + 1) -Strength ((Get-Random -Minimum 9 -Maximum 18) + 1))
                $monster = (Get-Variable -Name ("monster" + ($player.location -join "") -replace (" ", ""))).Value
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "V") {
                    $monster.race = "Vendor"
                    If (-not ($allVendorMad)) {
                        $monster.mad = $false
                    }
                }
                If ($monster.race -eq "Goblin" -or $monster.race -eq "Kobold" -or $monster.race -eq "Wolf") {
                    $monster.strength += 1
                }
                elseif ($monster.race -eq "Bear") {
                    $monster.strength += 2
                }
                elseif ($monster.race -eq "Gargoyle" -or $monster.race -eq "Orc" -or $monster.race -eq "Troll") {
                    $monster.strength += 3
                }
                elseif ($monster.race -eq "Chimera" -or $monster.race -eq "Minotaur" -or $monster.race -eq "Ogre") {
                    $monster.strength += 4
                }
                elseif ($monster.race -eq "Balrog" -or $monster.race) {
                    $monster.strength += 5
                }
                elseif ($monster.race -eq "Dragon") {
                    $monster.strength += 8
                }
                elseif ($monster.race -eq "Vendor") {
                    $monster.dexterity = 20
                    $monster.intelligence = 20
                    $monster.strength += 12
                }
                $monster.location = $player.location
                If ($monster.location[0] -eq $runestaffLocation[0] -and $monster.location[1] -eq $runestaffLocation[1] -and $monster.location[2] -eq $runestaffLocation[2]) {
                    $monster.Runestaff = $true
                }
            }
            else {
                $monster = (Get-Variable -Name ("monster" + ($player.location -join "") -replace (" ", ""))).Value
            }
            Write-Output "`n"
            Write-Output ("Here you find a {0}." -f $monster.race)
            $canCast = $false
            Remove-Variable -Name webbedTurns -ErrorAction SilentlyContinue
            If (-not ($monster.mad) -and $monster.race -ne "Vendor" -and -not ($monsterIgnore)) {
                $choice = New-Menu -Question ("`tThe {0} seems to not notice you, do you want to suprise attack?" -f $monster.race) -Choices (
                    ("&Yes", ("Attack the {0}" -f $monster.race)),
                    ("&No", "Let it be and go on with your quest")
                )
                If ($choice[0] -clike "*Yes*") {
                    $firstAttackRound = $false
                    $monster.mad = $true
                    Start-PlayerAttack -funcMonster $monster -funcPlayer $player
                }
                If ($choice[0] -clike "*No*") {
                    $monsterIgnore = $true
                    $noCommand = $true
                }
            }
            If ($monster.race -eq "Vendor" -and -not ($monsterIgnore) -and -not ($monster.mad)) {
                Write-Output "You may Ignore, Trade, or Attack."
                $choice = New-Menu -Question "`tWhat do you want to do?" -Choices (
                    ("&Ignore", ("Ignore the {0}" -f $monster.race)),
                    ("&Trade", ("Trade with the {0}" -f $monster.race)),
                    ("&Attack", ("Attack the {0}" -f $monster.race))
                )
                If ($choice[0] -clike "*Attack*") {
                    $firstAttackRound = $false
                    $allVendorMad = $true
                    $monster.mad = $true
                    Start-PlayerAttack -funcMonster $monster -funcPlayer $player
                }
                If ($choice[0] -clike "*Trade*") {
                    Start-VendorTrade -funcMonster $monster -funcPlayer $player -funcMonsterIgnore ([ref]$monsterIgnore)
                    $noCommand = $true
                }
                If ($choice[0] -clike "*Ignore*") {
                    $monsterIgnore = $true
                    $noCommand = $true
                }
            }
            $battleOver = $false
            $firstAttackRound = $true
            while ($monster.mad -and $player.strength -gt 0 -and $player.intelligence -gt 0 -and $monster.strength -gt 0 -and $battleOver -ne $true) {
                $randomMonsterMessage = @(
                    ("The {0} sees you, snarls and lunges towards you!" -f $monster.race),
                    ("The {0} looks angrily at you moves in your direction!" -f $monster.race),
                    ("The {0} stops what it's doing and focuses its attention on you!" -f $monster.race),
                    ("The {0} looks at you agitatedly!" -f $monster.race),
                    ($(if ($monster.race -eq "Dragon") { ("The {0} says, you've come seeking treasure and instead have found death!" -f $monster.race) } else { ("The {0} growls and prepares for battle!" -f $monster.race) })),
                    ($(if ($monster.race -eq "Dragon") { ("The {0} says, you will be a small meal for a {0}, {1}!" -f $monster.race, $player.race) } else { ("The {0} growls and prepares for battle!" -f $monster.race) })),
                    ($(if ($monster.race -eq "Dragon") { ("The {0} says, welcome to your death pitiful {1}!" -f $monster.race, $player.race) } else { ("The {0} growls and prepares for battle!" -f $monster.race) }))
                )
                $randomMonsterMessage = ($randomMonsterMessage | Get-Random)
                if ($firstAttackRound) {
                    Write-Warning $randomMonsterMessage
                }
                Write-Output ("You are facing a {0}!" -f $monster.race)
                # Write-Output ("The {0}'s strength is {1}" -f $monster.race, $monster.strength) # COMMENT
                If ((((Get-Random -Maximum 100) + $monster.dexterity) -gt 75) -or $player.lethargy -and $firstAttackRound) {
                    $firstAttackRound = $false
                }
                else {
                    If ($player.intelligence -gt 14 -and -not ($player.lethargy)) {
                        $canCast = $true
                    }
                    If (((Get-Random -Maximum 100) + $player.dexterity) -gt 50 -and $firstAttackRound) { 
                        $tempValue = "You may also attempt a bribe." 
                    }
                    else {
                        $tempValue = $null
                    }
                    Write-Output "You may Attack or Retreat."
                    If ($canCast) {
                        Write-Output "You can also CAST a spell."
                    }
                    Write-Output $tempValue
                    Write-Output ("Your Dexterity is {0}, your Intelligence is {1}, and your strength is {2}." -f $player.dexterity, $player.intelligence, $player.strength)
                    If (-not ($tempValue) -and -not ($canCast)) {
                        $choice = New-Menu -Question "`tWhat do you want to do?" -Choices (
                            ("&Attack", ("Attack the {0}" -f $monster.race)),
                            ("&Retreat", "Retreat to another room")
                        )
                    }
                    elseif (-not ($tempValue) -and $canCast) {
                        $choice = New-Menu -Question "`tWhat do you want to do?" -Choices (
                            ("&Attack", ("Attack the {0}" -f $monster.race)),
                            ("&Retreat", "Retreat to another room"),
                            ("&Cast", "Cast a Spell")
                        )
                    }
                    elseif ($tempValue -and -not ($canCast)) {
                        $choice = New-Menu -Question "`tWhat do you want to do?" -Choices (
                            ("&Attack", ("Attack the {0}" -f $monster.race)),
                            ("&Retreat", "Retreat to another room"),
                            ("&Bribe", ("Attempt to bribe the {0}" -f $monster.race))
                        )
                    }
                    elseif ($tempValue -and $canCast) {
                        $choice = New-Menu -Question "`tWhat do you want to do?" -Choices (
                            ("&Attack", ("Attack the {0}" -f $monster.race)),
                            ("&Retreat", "Retreat to another room"),
                            ("&Cast", "CAST a Spell"),
                            ("&Bribe", ("Attempt to bribe the {0}" -f $monster.race))
                        )
                    }
                    If ($choice[0] -clike "*Cast*") {
                        $firstAttackRound = $false
                        $choice = New-Menu -Question "`n`tCAST which spell?" -Choices (
                            ("&Web", "CAST a Web spell"),
                            ("&Fireball", ("CAST a Fireball at the {0}" -f $monster.race)),
                            ("&Deathspell", "CAST the spell of Death (careful, it may be yours)")
                        )
                        If ($choice[0] -clike "*Web*") {
                            $webbedTurns = ((Get-Random -Minimum 1 -Maximum 9) + 1)
                            $monster.webbed = $true
                            $player.strength -= 1
                            Write-Output "`n"
                            Write-Warning ("`tYou trap the {0} in a web." -f $monster.race)
                        }
                        If ($choice[0] -clike "*Fireball*") {
                            $FireballDamage = ((Get-Random -Minimum 1 -Maximum 14) + 1)
                            $monster.strength -= $FireballDamage
                            $player.strength -= 1
                            $player.intelligence -= 1
                            Write-Output "`n"
                            Write-Warning ("`tYour Fireball blasted the {0}." -f $monster.race)
                        }
                        If ($choice[0] -clike "*Death*") {
                            $DeathSpellChance = ((Get-Random -Maximum 100) + 1)
                            If ($player.intelligence -gt $monster.intelligence -and $DeathSpellChance -lt 75) {
                                $monster.strength = 0
                                Write-Output "`n"
                                Write-Warning ("`tDEATH! The {0}'s!" -f $monster.race)
                            }
                            else {
                                $player.strength = 0
                                Write-Output "`n"
                                Write-Warning ("`tDEATH! The STUPID {0}'s!" -f $player.race)
                            }
                        }
                    }
                    If ($choice[0] -clike "*Attack*") {
                        $firstAttackRound = $false
                        Start-PlayerAttack -funcMonster $monster -funcPlayer $player
                    }
                    If ($choice[0] -clike "*Retreat*") {
                        If ((((Get-Random -Maximum 100) + $monster.dexterity) -gt 75) -or $player.lethargy) {
                            Start-MonsterAttack -funcMonster $monster -funcPlayer $player
                            if ($webbedTurns -gt 0) {
                                $webbedTurns -= 1
                                if ($webbedTurns -lt 1) {
                                    $monster.webbed = $false
                                }
                            }
                        }
                        $choice = New-Menu -Question ("`n`tRetreat which way?") -Choices (
                            ("&East", "Retreat East"),
                            ("&North", "Retreat North"),
                            ("&South", "Retreat South"),
                            ("&West", "Retreat West")
                        )
                        $battleOver = $true
                        If ($choice[0] -clike "*East*") { $player.East($map) }     
                        If ($choice[0] -clike "*North*") { $player.North($map) }
                        If ($choice[0] -clike "*South*") { $player.South($map) }     
                        If ($choice[0] -clike "*West*") { $player.West($map) }
                        $noCommand = $true
                    }
                    elseif ($choice[0] -clike "*Bribe*") { 
                        $firstAttackRound = $false
                        If ($player.treasures.Count -gt 0) { 
                            $bribe = ($player.treasures | Get-Random)
                            $choice = New-Menu -Question (("`tThe {0} says I want the {1}. Will you give it to me?" -f $monster.race, $bribe)) -Choices (
                                ("&Yes", ("Give the {0} to the {1}" -f $bribe, $monster.race)),
                                ("&No", "Refuse and do battle")
                            )
                            If ($choice[0] -like "*Yes*") {
                                $monster.mad = $false
                                $player.treasures.Remove($bribe) | Out-Null
                                $monster.treasures.Add($bribe) | Out-Null
                                If ($monster.race -eq "Vendor") {
                                    $allVendorMad = $false
                                }
                                $noCommand = $true
                            }
                        }
                        If ($monster.mad -or $choice[0] -notlike "*Yes*") {
                            Write-Output "`n"
                            Write-Output ("The {0} says: `"All I want is your life!`"" -f $monster.race)
                        }
                    }
                }
                If ($monster.mad -and $monster.strength -gt 0 -and $firstAttackRound -eq $false -and $player.strength -gt 0) {
                    Start-MonsterAttack -funcMonster $monster -funcPlayer $player
                    if ($webbedTurns -gt 0) {
                        $webbedTurns -= 1
                        if ($webbedTurns -lt 1) {
                            $monster.webbed = $false
                        }
                    }
                }
                $firstAttackRound = $false
            }
            If ($monster.strength -lt 1) {
                $noCommand = $true
                $tempValue = ((Get-Random -Maximum 1000) + 1)
                Write-Output "`n"
                Write-Output ("You killed the {0} {1}!" -f (("evil", "nasty", "wicked", "depraved", "vile", "unholy") | Get-Random), $monster.race)
                Write-Output ("You gather the dead {0}'s {1} pieces of gold in your rucksack." -f $monster.race, $tempValue) 
                $player.gold += $tempValue
                If ($monster.Runestaff) {
                    $player.Runestaff = $true
                    Write-Output ("The {0} was carrying the Runestaff, it's now yours." -f $monster.race) 
                }
                If ($monster.treasures.Count -gt 0) {
                    Write-Output ("The {0} was carrying the {1}, it's now yours." -f $monster.race, $monster.treasures[0])
                    $player.treasures.Add($monster.treasures[0])
                }
                If ($monster.race -eq "Vendor") {
                    Write-Output ("You also get the {0}'s Plate armor and Sword." -f $monster.race)
                    $player.armor = "Plate"
                    $player.weapon = "Sword"
                }
                $emptyRoomContent.Add((($player.location -join ""), ("the decaying remains of a {0}" -f $monster.race))) | Out-Null
                $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
                $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
            }
        }
        # Orb-Of-Zot in room sequence
        elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "Z") {
            If ($action -eq "Teleport") {
                Write-Output "`n"
                Write-Warning ("Here you find the `"Orb-Of-Zot!`"!")
                Write-Warning ("The Runestaff vanishes!")
                $player.OrbOfZot = $true
                $player.Runestaff = $false
                $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
                $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
            }
            else {
                If (-not ($player.OrbOfZot)) {
                    $noCommand = $true
                    if ($action -eq "E") {
                        $player.East($map)
                    }
                    if ($action -eq "N") {
                        $player.North($map)
                    }
                    if ($action -eq "S") {
                        $player.South($map)
                    }
                    if ($action -eq "W") {
                        $player.West($map)
                    }
                }
            }
        }

        If (("B", "C", "F", "G", "O", "P", "D", "U", "X").Contains($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value)) {
            If ((Get-Random -Maximum 90) -gt 59) { Write-Output ("`n{0}" -f (New-GameMessage -messAttribute ($monsters[(Get-Random -Maximum ($monsters.Count))]))) }
        }

        If ($player.dexterity -lt 1 -or $player.intelligence -lt 1 -or $player.strength -lt 1) {
            Write-Output "`n"
            Write-Warning ("{0}" -f (Invoke-PlayerDeath($player)))
            Read-Host -Prompt "Press Enter to continue"
            Clear-Host
            $noCommand = $true
            $action = "Q"
        }
        If ($noCommand -eq $false) {
            $choice = New-Menu -Question "`tYour command?" -Choices $playerActions
            $action = ($choice[0])[1]

            # action Map sequence
            If ($action -eq "M") {
                If ($player.blind -eq $false) {
                    Show-Map -funcKnownMap $knownMap -funcPlayer $player -funcTreasures $treasures -funcMonsters $monsters
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, you're blind and can't see your map." -f $player.race) 
                }
            }
            # action Gaze sequence
            If ($action -eq "G") {
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "O" -and $player.blind -eq $false) {
                    Write-Output "`n"
                    $orbGaze = (Invoke-Orb -funcMap $map -funcRaces $races -funcPlayer $player -funcMonsters $monsters -funcTreasures $treasures)
                    Write-Warning ("You gaze into the orb and you see {0}" -f $orbGaze)
                    If ($orbGaze -like "*bloody heap*") {
                        $strengthLoss = (Get-Random -Minimum 1 -Maximum 3)
                        Write-Warning ("Seeing {0} causes you to lose {1} strength points!" -f ($orbGaze -replace ".$"), $strengthLoss)
                        $player.DecStrength($strengthLoss)
                    }
                }
                elseif ($player.blind -eq $false) {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, there's no orb in here." -f $player.race)
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, you're blind and can't see the nose on your face, let alone Gaze at anything." -f $player.race) 
                }
            }
            # action Open sequence
            If ($action -eq "O") {
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "B") {
                    If ($player.blind -eq $false) {
                        Write-Output "`n"
                        Write-Warning ("You open the book and {0}" -f (Read-Book -funcMap $map -funcRaces $races -funcPlayer $player -funcMonsters $monsters -funcTreasures $treasures))
                        $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
                        $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
                        $emptyRoomContent.Add((($player.location -join ""), ("an empty room"))) | Out-Null
                    }
                    else {
                        Write-Output "`n"
                        Write-Warning ("Stupid, {0}, you're BLIND and it's not written in braille." -f $player.race)
                    }
                }
                elseif ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "C") {
                    $map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "X"
                    $knownMap.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value = "-"
                    $emptyRoomContent.Add((($player.location -join ""), ("an empty room"))) | Out-Null
                    Write-Output "`n"
                    Write-Warning ("You open the chest and {0}" -f (Invoke-Chest -funcMap $map -funcPlayer $player))
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, the only thing you opened was your big mouth." -f $player.race)
                }
            }
            # action Drink sequence
            If ($action -eq "P") {
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "P") {
                    Write-Output "`n"
                    Write-Warning ("You drink from the pool and {0}" -f (Invoke-Pool -funcRaces $races -funcPlayer $player))
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, if you want a drink, find a pool." -f $player.race)
                }
            }
            # action Flare (light flare) sequence
            If ($action -eq "F") {
                If ($player.blind -eq $false) {
                    If ($player.flares -gt 0) {
                        $player.flares -= 1
                        $level = $player.location[0]
                        $row = $player.location[1]
                        $column = $player.location[2]
                        $rowMinus = $row - 1; If ($rowMinus -lt 0) { $rowMinus = ($map.levels[$level].rows.Count - 1) } 
                        $rowPlus = $row + 1; If ($rowPlus -gt ($map.levels[$level].rows.Count - 1)) { $rowPlus = 0 } 
                        $columnMinus = $column - 1; If ($columnMinus -lt 0) { $columnMinus = ($map.levels[$level].rows[$row].columns.Count - 1) } 
                        $columnPlus = $column + 1; If ($columnPlus -gt ($map.levels[$level].rows[$row].columns.Count - 1)) { $columnPlus = 0 }
                        $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = $map.levels[$level].rows[$rowMinus].columns[$columnMinus].value
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnMinus].value = "W" }
                        $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = $map.levels[$level].rows[$rowMinus].columns[$column].value
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "W" }
                        $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = $map.levels[$level].rows[$rowMinus].columns[$columnPlus].value
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$columnPlus].value = "W" }
                        $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = $map.levels[$level].rows[$row].columns[$columnMinus].value
                        If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "-" }
                        If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "W" }
                        $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = $map.levels[$level].rows[$row].columns[$columnPlus].value
                        If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "-" }
                        If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "W" }
                        $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = $map.levels[$level].rows[$rowPlus].columns[$columnMinus].value
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnMinus].value = "W" }
                        $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = $map.levels[$level].rows[$rowPlus].columns[$column].value
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "W" }
                        $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = $map.levels[$level].rows[$rowPlus].columns[$columnPlus].value
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = "-" }
                        If ($knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$columnPlus].value = "W" }
                        Show-Map -funcKnownMap $knownMap -funcPlayer $player -funcTreasures $treasures -funcMonsters $monsters
                    }
                    else {
                        Write-Output "`n"
                        Write-Warning ((
                                "Hey bright one, you don't have any flares.",
                                "You sing 'Come on baby light my fire' to yourself as you are out of flares.",
                                "You can't use flares you don't have, but maybe your smile will brighten the room.",
                                "You spend 5 minutes searching your rucksack before you realize you have no flares."
                            ) | Get-Random)
                    }
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, you're BLIND and you don't want to burn your fingers." -f $player.race)
                }
            }
            # action Lamp (shine Lamp) sequence
            If ($action -eq "L") {
                If ($player.blind -eq $false) {
                    If ($player.lamp -and $player.lampBurn -gt 0) {
                        $level = $player.location[0]
                        $row = $player.location[1]
                        $column = $player.location[2]
                        $rowMinus = $row - 1; If ($rowMinus -lt 0) { $rowMinus = ($map.levels[$level].rows.Count - 1) } 
                        $rowPlus = $row + 1; If ($rowPlus -gt ($map.levels[$level].rows.Count - 1)) { $rowPlus = 0 } 
                        $columnMinus = $column - 1; If ($columnMinus -lt 0) { $columnMinus = ($map.levels[$level].rows[$row].columns.Count - 1) } 
                        $columnPlus = $column + 1; If ($columnPlus -gt ($map.levels[$level].rows[$row].columns.Count - 1)) { $columnPlus = 0 }
                        $choice = New-Menu -Question ("`n`tShine the Lamp in which direction?") -Choices (
                            ("&East", "Shine Lamp East"),
                            ("&North", "Shine Lamp North"),
                            ("&South", "Shine Lamp South"),
                            ("&West", "Shine Lamp West")
                        )
                        $battleOver = $true
                        If ($choice[0] -clike "*East*") { 
                            $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = $map.levels[$level].rows[$row].columns[$columnPlus].value
                            If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "-" }
                            If ($knownMap.levels[$level].rows[$row].columns[$columnPlus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnPlus].value = "W" }
                        }     
                        If ($choice[0] -clike "*North*") {
                            $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = $map.levels[$level].rows[$rowMinus].columns[$column].value
                            If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "-" }
                            If ($knownMap.levels[$level].rows[$rowMinus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowMinus].columns[$column].value = "W" }
                        }
                        If ($choice[0] -clike "*South*") {
                            $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = $map.levels[$level].rows[$rowPlus].columns[$column].value
                            If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "X") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "-" }
                            If ($knownMap.levels[$level].rows[$rowPlus].columns[$column].value -eq "Z") { $knownMap.levels[$level].rows[$rowPlus].columns[$column].value = "W" }
                        }     
                        If ($choice[0] -clike "*West*") {
                            $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = $map.levels[$level].rows[$row].columns[$columnMinus].value
                            If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "X") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "-" }
                            If ($knownMap.levels[$level].rows[$row].columns[$columnMinus].value -eq "Z") { $knownMap.levels[$level].rows[$row].columns[$columnMinus].value = "W" }
                        }
                        Show-Map -funcKnownMap $knownMap -funcPlayer $player -funcTreasures $treasures -funcMonsters $monsters
                        $player.lampBurn -= 1
                    }
                    elseif (-not ($player.lamp)) {
                        Write-Output "`n"
                        Write-Warning ("Sorry, {0}, you don't have a Lamp." -f $player.race) 
                    }
                    else {
                        Write-Output "`n"
                        Write-Warning ("Sorry, {0}, your Lamp is out of oil." -f $player.race) 
                    }
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, you're BLIND and you can't see anything." -f $player.race) 
                }
            }
            # action ENSW sequences
            If ($action -eq "E") {
                $monsterIgnore = $false
                $player.East($map)
            }     
            If ($action -eq "N") {
                If (($player.location -join "") -eq "003") {
                    Write-Output "`n"
                    Write-Warning ("{0}" -f (Invoke-PlayerExit($player)))
                    Read-Host -Prompt "Press Enter to continue"
                    Clear-Host
                    $noCommand = $true
                    $action = "Q"
                }
                else {
                    $monsterIgnore = $false
                    $player.North($map) 
                }
            }     
            If ($action -eq "S") {
                $monsterIgnore = $false
                $player.South($map)
            }     
            If ($action -eq "W") {
                $monsterIgnore = $false
                $player.West($map) 
            }     
            # action Down stairs sequence
            If ($action -eq "D") {
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "D") {
                    $player.Down()
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, there are no stairs going down here." -f $player.race)
                }
            }
            # action Up stairs sequence
            If ($action -eq "U") {
                If ($map.levels[$player.location[0]].rows[$player.location[1]].columns[$player.location[2]].value -eq "U") {
                    $player.Up()
                }
                else {
                    Write-Output "`n"
                    Write-Warning ("Stupid, {0}, there are no stairs going up here." -f $player.race)
                }     
            }
            # action Teleport sequence
            If ($action -eq "T") {
                If (-not ($player.Runestaff)) {
                    Write-Output "`n"
                    Write-Warning ("Sorry, {0}, you'll need the Runestaff to teleport." -f $player.race)
                }
                else {
                    do {
                        do {
                            $tempValue = Read-Host -Prompt "`nPlease enter the destination (ex. 7,13,5 meaning Level 7, Row 13, Column 5)"
                            If ($tempValue -notmatch "^\d{1,2},\d{1,2},\d{1,2}$") {
                                Write-Output "`n"
                                Write-Warning ("Nice shot, {0}, that's not a location." -f $player.race)
                            }
                        } while ($tempValue -notmatch "^\d{1,2},\d{1,2},\d{1,2}$")
                        $i = 0; $tempValue -split "," | ForEach-Object { $tempLocation[$i] = $PSItem; $i++ }
                        Remove-Variable -Name tempValue -ErrorAction SilentlyContinue
                        $tempValue = $tempLocation
                        if (([int]::parse($tempValue[0]) - 1) -gt $map.levels.Count -or ([int]::parse($tempValue[1]) - 1) -gt $map.levels[([int]::parse($tempValue[0]) - 1)].rows.Count -or ([int]::parse($tempValue[2]) - 1) -gt $map.levels[([int]::parse($tempValue[0]) - 1)].rows[([int]::parse($tempValue[1]) - 1)].columns.Count) {
                            Write-Output "`n"
                            Write-Warning ("Try picking an existing location on the map {0}." -f $player.race)
                        }
                        else {
                            $monsterIgnore = $false
                            Write-Output "`n"
                            Write-Warning ("Teleporting you to Level {0}, Row {1}, Column {2}." -f $tempValue[0], $tempValue[1], $tempValue[2])
                            $player.location[0] = ([int]::parse($tempValue[0])) - 1
                            $player.location[1] = ([int]::parse($tempValue[1])) - 1
                            $player.location[2] = ([int]::parse($tempValue[2])) - 1
                            $action = "Teleport"
                            $noCommand = $true
                        }
                    } while ($action -eq "T")
                }
            }
            # action A for Attack (invalid in this case)
            If ($action -eq "A") {
                Write-Output "`n"
                Write-Warning ("You must really need some sleep, silly {0}, there's nothing here to attack." -f $player.race)
            }            
            # action R for Retreat (invalid in this case)
            If ($action -eq "R") {
                Write-Output "`n"
                Write-Warning ("You put your tail between your legs and shiver in the corner. Nice one, {0}!" -f $player.race)
            }            
            # action B for Bribe (invalid in this case)
            If ($action -eq "B") {
                Write-Output "`n"
                Write-Warning ("Bribe isn't valid here you stupid {0}." -f $player.race)
            }            
        }
        else {
            $noCommand = $false 
        }
    } while ($action -ne "Q")
}

# Main Starting Point (main loop)
if (-not (Test-Path -Path "./WizardsCastleTemp_$(Get-Date -Format FileDate)")) {
    if (Get-Command -Name pxsh -ErrorAction SilentlyContinue) {
        Start-Process pwsh "-WindowStyle Maximized -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    }
    else {
        Start-Process PowerShell.exe "-WindowStyle Maximized -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    }
    New-Item -ItemType File -Name "WizardsCastleTemp_$(Get-Date -Format FileDate)"
    Exit
}
if (-not (($Host.Version).Major -gt 4)) {
    Clear-Host
    ""
    Write-Warning -Message "*** PowerShell version MUST be verion 5 or greater ***"
    ""
    Pause
    Exit
}
do {
    Remove-Item -Path "./WizardsCastleTemp_$(Get-Date -Format FileDate)"
    Clear-Host
    Remove-Variable -Name action, amount, choice, column, columnMinus, columnPlus, content, extraPoints, i, knownMap, level, map, noCommand, player, playerActions, race, races, roomMessages, roomObject, roomValues, row, rowMinus, rowPlus, sex, tempValueLocal, tempValue, treasures -ErrorAction SilentlyContinue
    Get-Variable -Name "*monster*" | Remove-Variable
    Invoke-MainFunc
} while ($true)
