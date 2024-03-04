function DeclineUpdateByUpdateId
{
    param (
        [parameter(Mandatory = $true)] $UpdateId
    )
    $update = $wsus.GetUpdate([guid]"$UpdateId")
    $update.Decline()
    Write-Host $update.Title "was declined."
}

[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()

$FilteredUpdates = @()
$updates = $wsus.SearchUpdates('Security And Quality Rollup')

$updates | Foreach-Object { 
    
    $record="" | Select Title, UpdateId, IsApproved, IsDeclined
    $record.Title=$_.Title
    $record.UpdateId=$_.Id.UpdateId
    $record.IsApproved=$_.IsApproved
    $record.IsDeclined=$_.IsDeclined
    
    $FilteredUpdates+=$record
    
}

$FilteredUpdates | Foreach-Object { 
    If ($_.IsDeclined -eq $false){
        DeclineUpdateByUpdateId $_.UpdateId;
    }
}
