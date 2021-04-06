<#
    .Synopsis
        Handles methods related to the game Window in Wizard's Castle

    .DESCRIPTION
        Get-WindowSize, Get-WindowWidth, Get-WindowHeight

    .EXAMPLE
	$wHeight = Get-WindowHeight

    .EXAMPLE
	$wSize = Get-WindowSize

    .INPUTS
        * None *

    .OUTPUTS
        Window Dimensions

    .NOTES
        PowerShell (C) 2020 by Daniel Kill
#>
function Get-WindowSize() {
    $Host.UI.RawUI.WindowSize
}

function Get-WindowWidth() {
    (Get-WindowSize).Width
}

function Get-WindowHeight() {
    (Get-WindowSize).Height
}

Export-ModuleMember -Function Get-WindowSize, Get-WindowWidth,Get-WindowHeight
