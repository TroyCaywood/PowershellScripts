#Run this script as a scheduled task as a user with AD access. Gets a list of users that have been disabled more than one year and sends an email with CSV of those users

# Get users with status 514 (disabled user) with status set date of more than 365 days prior

$disabledUsers = Get-ADUser -Filter "ObjectClass -eq 'User' -and userAccountControl -eq '514'" -SearchBase 'OU=Disabled Accounts,DC=domain,DC=com'

$tobedeleted = foreach ($disabledUser in $disabledUsers) {

    Get-ADReplicationAttributeMetadata $disabledUser -server domaincontroller.domain.com | 
        Where-Object {$_.AttributeName -eq 'UserAccountControl'} | Select Object,LastOriginatingChangeTime |
            Where-Object {$_.LastOriginatingChangeTime -lt (Get-Date).AddDays(-365)}

}


#### Count users ####

$deleteduserscount = @($tobedeleted).Count

# Write to log file and email to support

$RootName = 'DeletedUsers '
$LogDate = Get-Date -Format "dddd MM-dd-yyyy HHmm - "
$LogWrite = @($LogDate)
$FileName = $RootName + $LogDate + $deleteduserscount + ' users.txt'
$report = Write-Output $tobedeleted | Sort-Object -Property LastOriginatingChangeTime -Descending | ConvertTo-Html -Head $style 
	
$style = "<style>BODY{font:arial 10pt;}</style>"
$style = "<style>BODY{font-family: Arial; font-size: 10pt;}"
$style = $style + "TABLE{border: 1px solid black; border-collapse: collapse;}"
$style = $style + "TH{border: 1px solid black; background: #dddddd; padding: 5px; }"
$style = $style + "TD{border: 1px solid black; padding: 5px; }"
$style = $style + "</style>"

Write-Output $tobedeleted  | Sort-Object -Property LastOriginatingChangeTime -Descending | out-file "C:\temp\DeletedUsers\$FileName"


$to = "support@domain.com"
$from = "disabledusers@domain.com"

$body = $report
$MailMessage = $MailMessage = @{ 
    To = $to
    From = $from
    Subject = "$deleteduserscount users disabled for more than one year - To be deleted - From Disabled Users Script" 
    Body = "<b>These users have been disabled for more than one year and need to be deleted from Active Directory.</b><br><br>" + "$report" 
    Smtpserver = 'main.domain.com'
    ErrorAction = "SilentlyContinue" 
}

If ($deleteduserscount -gt 0) {
     Send-MailMessage @MailMessage -BodyAsHtml
}

#Delete 100 day old log files

 Get-ChildItem “C:\Temp\DeletedUsers\*.txt” | Where LastWriteTime -LT (Get-Date).AddDays(-100) | Remove-Item
