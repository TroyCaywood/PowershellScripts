#Check if a specified user is locked out of Active Directory

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Locked Username Checker"
$Form.TopMost = $true
$Form.Width = 450
$Form.Height = 250

$userbox = New-Object system.windows.Forms.TextBox
$userbox.Width = 176
$userbox.Height = 20
$userbox.location = new-object system.drawing.point(62,49)
$userbox.Font = "Microsoft Sans Serif,10"
$userbox.text = "Enter username"
$Form.controls.Add($userbox)

$label3 = New-Object system.windows.Forms.Label
$label3.Text = "What is the username you want to check?"
$label3.AutoSize = $true
$label3.Width = 25
$label3.Height = 10
$label3.location = new-object system.drawing.point(27,19)
$label3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label3)

$checkbutton = New-Object system.windows.Forms.Button
$checkbutton.Text = "Check"
$checkbutton.Width = 75
$checkbutton.Height = 30
$checkbutton.location = new-object system.drawing.point(123,77)
$checkbutton.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($checkbutton)

$checkbutton.Add_Click(
  {#specify the username
    $User = $userbox.Text
    $Output = $label3.Text

    #print ADuser properties just so you can see them
    Get-Aduser $User -Properties PasswordExpired,PasswordLastSet

    #get all users with expired passwords and export them to a txt file called expwusers.txt
    Get-ADUser -Filter {enabled -eq $true} -Properties PasswordExpired | Where-Object {$_.PasswordExpired} | Out-File c:\scripts\expwusers.txt

    #search expired users file for specified user and export that to a new text file called expired.txt
    Select-String -Pattern "$User" -Path C:\scripts\expwusers.txt | Out-File c:\scripts\expired.txt

    #search expired.txt for specified user and print whether the password is expired or not
    If ( Select-String -SimpleMatch "$User" -Path C:\scripts\expired.txt ){
      $label3.text = "$User's password is expired. Have them change their password."
    }
    Else{
      $label3.text = "$User's password is not expired."
    }



    Remove-Item C:\scripts\expwusers.txt
    Remove-Item C:\scripts\expired.txt
  }
  )

[void]$Form.ShowDialog()
$Form.Dispose()
