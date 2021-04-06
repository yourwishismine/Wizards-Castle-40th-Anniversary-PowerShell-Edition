<#
    .Synopsis
        Invoke Character class

    .DESCRIPTION
        Creates Character class objects for Player, Monsters and Vendors

    .EXAMPLE
        New-Character -Race "Elf" -Sex "Male" -Dexterity 10 -Intelligence 12 -Strength 6

    .EXAMPLE
        New-Character -Race "Dragon" -Dexterity 6 -Intelligence 10 -Strength 18

    .INPUTS
        [String]$race, [String]$sex, [Int16]$dexterity, [Int16]$intelligence,  [Int16]$Strength

    .OUTPUTS
        * None *

    .NOTES
        PowerShell (C) 2020 by Daniel Kill

    .FUNCTIONALITY
        Creates Character Objects for Wizard's Castle
#>
Function New-Character {
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Race,
        [String]$Sex,
        [Parameter(Mandatory = $true)]
        [Int16]$Dexterity,
        [Parameter(Mandatory = $true)]
        [Int16]$Intelligence,
        [Parameter(Mandatory = $true)]
        [Int16]$Strength
    )
    [Character]::New([String]$race, [String]$Sex, [Int16]$dexterity, [int16]$intelligence, [Int16]$strength)
}

Class Character {
    [String]$race = ""
    [String]$sex = ""
    [Int16]$dexterity = 0
    [Int16]$intelligence = 0
    [Int16]$strength = 0
    [Int16]$maxAttrib = 18
    [String]$armor = ""
    [String]$weapon = ""
    [Int16]$flares = 0
    [Int32]$gold = 60
    [Int32]$turns = 0
    [bool]$blind = $false
    [bool]$bookStuck = $false
    [bool]$forgetfulness = $false
    [bool]$lamp = $false
    [Int16]$lampBurn = 0
    [bool]$leech = $false
    [bool]$lethargy = $false
    [bool]$mad = $true
    [bool]$OrbOfZot = $false
    [bool]$Runestaff = $false
    [bool]$Webbed = $false
    [System.Collections.ObjectModel.Collection[String]]$treasures = @()
    [Int16[]]$location = @(0, 0, 3)

    Character ([String]$race, [String]$sex, [Int16]$dexterity, [Int16]$intelligence, [Int16]$strength) {
        $this.race = $race
        $this.sex = $sex
        $this.dexterity = $dexterity
        $this.intelligence = $intelligence
        $this.strength = $strength
    }

    Character ([String]$race, [Int16]$dexterity, [int16]$intelligence, [Int16]$strength) {
        $this.race = $race
        $this.dexterity = $dexterity
        $this.intelligence = $intelligence
        $this.strength = $strength
    }

    IncDexterity([Int16]$change) {
        $this.dexterity += $change
        if ($this.dexterity -gt $this.maxAttrib) {
            $this.dexterity = $this.maxAttrib
        }
    }

    IncIntelligence([Int16]$change) {
        $this.intelligence += $change
        if ($this.intelligence -gt $this.maxAttrib) {
            $this.intelligence = $this.maxAttrib
        }
    }

    IncStrength([Int16]$change) {
        $this.strength += $change
        if ($this.strength -gt $this.maxAttrib) {
            $this.strength = $this.maxAttrib
        }
    }

    DecDexterity([Int16]$change) {
        $this.dexterity -= $change
    }

    DecIntelligence([Int16]$change) {
        $this.intelligence -= $change
    }

    DecStrength([Int16]$change) {
        $this.strength -= $change
    }

    East($funcMap) {    
        If ($this.location[2] -eq ($funcMap.levels[$this.location[0]].rows[$this.location[1]].columns.Count - 1)) {
            $this.location[2] = 0
        }
        else {
            $this.location[2] += 1
        }
    }

    North($funcMap) {
        If ($this.location[1] -eq 0) {
            $this.location[1] = ($funcMap.levels[$this.location[0]].rows.Count - 1)
        }
        else {
            $this.location[1] -= 1
        }
    }

    South($funcMap) {
        If ($this.location[1] -eq ($funcMap.levels[$this.location[0]].rows.Count - 1)) {
            $this.location[1] = 0
        }
        else {
            $this.location[1] += 1
        }
    }

    West($funcMap) {
        If ($this.location[2] -eq 0) {
            $this.location[2] = ($funcMap.levels[$this.location[0]].rows[$this.location[1]].columns.Count - 1)
        }
        else {
            $this.location[2] -= 1
        }
    }

    Down() {
        $this.location[0] += 1
    }

    Up() {
        $this.location[0] -= 1
    }

    Sink() {
        $this.location[0] += 1
    }

    Warp($funcMap) {
        $level = Get-Random -Maximum $funcMap.levels.Count
        $row = Get-Random -Maximum $funcMap.levels[$level].rows.Count
        $column = Get-Random -Maximum $funcMap.levels[$level].rows[$row].columns.Count
        $this.location = @($level, $row, $column)
    }
}

Export-ModuleMember -Function New-Character