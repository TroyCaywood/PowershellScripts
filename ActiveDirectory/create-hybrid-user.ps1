#This script will create a new active directory user and remote mailbox in a hybrid exchange environment using a visual interface. Make sure to read through this script and add your relevant domain information etc.

#Install MSOline Module if it is not installed

if(-not (Get-Module MSonline -ListAvailable)){
    Install-Module MSonline -Scope CurrentUser -Force
    }

# Load messagebox assembly

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

#Exit Function

function ex{exit}

#Display Warning

$oReturn=[System.Windows.Forms.Messagebox]::Show("This script will create a new user in Active Directory, Email, `nand will also guide you through creating their other accounts. `n `
Please be sure you ran this script as your admin user `
`nIf you are not authorized to use this script. Please press Cancel. `nOtherwise press Ok to continue.","ATTENTION",[System.Windows.Forms.MessageBoxButtons]::OkCancel)
switch($oReturn)

{
    "Ok"
        {
        }
    "Cancel"
        {
        ex
        }
}


#User creation form

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$NewUserForm                     = New-Object system.Windows.Forms.Form
$NewUserForm.ClientSize          = '414,450'
$NewUserForm.text                = "New User"
$NewUserForm.TopMost             = $true

$FirstNameTxtBox                 = New-Object system.Windows.Forms.TextBox
$FirstNameTxtBox.multiline       = $false
$FirstNameTxtBox.width           = 181
$FirstNameTxtBox.height          = 20
$FirstNameTxtBox.location        = New-Object System.Drawing.Point(17,38)
$FirstNameTxtBox.Font            = 'Times New Roman,10'

$FirstNameLabel                  = New-Object system.Windows.Forms.Label
$FirstNameLabel.text             = "First Name *"
$FirstNameLabel.AutoSize         = $true
$FirstNameLabel.width            = 25
$FirstNameLabel.height           = 10
$FirstNameLabel.location         = New-Object System.Drawing.Point(15,17)
$FirstNameLabel.Font             = 'Times New Roman,10'

$LastNameLabel                   = New-Object system.Windows.Forms.Label
$LastNameLabel.text              = "Last Name *"
$LastNameLabel.AutoSize          = $true
$LastNameLabel.width             = 25
$LastNameLabel.height            = 10
$LastNameLabel.location          = New-Object System.Drawing.Point(216,17)
$LastNameLabel.Font              = 'Times New Roman,10'

$LastNameTxtBox                  = New-Object system.Windows.Forms.TextBox
$LastNameTxtBox.multiline        = $false
$LastNameTxtBox.width            = 181
$LastNameTxtBox.height           = 20
$LastNameTxtBox.location         = New-Object System.Drawing.Point(219,38)
$LastNameTxtBox.Font             = 'Times New Roman,10'

$DescriptionTxtBox               = New-Object system.Windows.Forms.TextBox
$DescriptionTxtBox.multiline     = $false
$DescriptionTxtBox.width         = 181
$DescriptionTxtBox.height        = 20
$DescriptionTxtBox.location      = New-Object System.Drawing.Point(17,86)
$DescriptionTxtBox.Font          = 'Times New Roman,10'

$DescriptionLabel                = New-Object system.Windows.Forms.Label
$DescriptionLabel.text           = "User Description *"
$DescriptionLabel.AutoSize       = $true
$DescriptionLabel.width          = 25
$DescriptionLabel.height         = 10
$DescriptionLabel.location       = New-Object System.Drawing.Point(15,66)
$DescriptionLabel.Font           = 'Times New Roman,10'

$FaxTxtBox                       = New-Object system.Windows.Forms.TextBox
$FaxTxtBox.multiline             = $false
$FaxTxtBox.width                 = 181
$FaxTxtBox.height                = 20
$FaxTxtBox.location              = New-Object System.Drawing.Point(218,86)
$FaxTxtBox.Font                  = 'Times New Roman,10'

$FaxLabel                        = New-Object system.Windows.Forms.Label
$FaxLabel.text                   = "Fax Number"
$FaxLabel.AutoSize               = $true
$FaxLabel.width                  = 25
$FaxLabel.height                 = 10
$FaxLabel.location               = New-Object System.Drawing.Point(217,66)
$FaxLabel.Font                   = 'Times New Roman,10'

$PhoneExtTxtBox                  = New-Object system.Windows.Forms.TextBox
$PhoneExtTxtBox.multiline        = $false
$PhoneExtTxtBox.width            = 181
$PhoneExtTxtBox.height           = 20
$PhoneExtTxtBox.location         = New-Object System.Drawing.Point(17,131)
$PhoneExtTxtBox.Font             = 'Times New Roman,10'

$DeskPhLabel                     = New-Object system.Windows.Forms.Label
$DeskPhLabel.text                = "Phone Extension"
$DeskPhLabel.AutoSize            = $true
$DeskPhLabel.width               = 25
$DeskPhLabel.height              = 10
$DeskPhLabel.location            = New-Object System.Drawing.Point(15,113)
$DeskPhLabel.Font                = 'Times New Roman,10'

$ManagerTxtBox                   = New-Object system.Windows.Forms.TextBox
$ManagerTxtBox.multiline         = $false
$ManagerTxtBox.width             = 181
$ManagerTxtBox.height            = 20
$ManagerTxtBox.location          = New-Object System.Drawing.Point(218,131)
$ManagerTxtBox.Font              = 'Times New Roman,10'

$ManagerLabel                    = New-Object system.Windows.Forms.Label
$ManagerLabel.text               = "User`'s Manager (username)*:"
$ManagerLabel.AutoSize           = $true
$ManagerLabel.width              = 25
$ManagerLabel.height             = 10
$ManagerLabel.location           = New-Object System.Drawing.Point(216,113)
$ManagerLabel.Font               = 'Times New Roman,10'

$PasswordTxtBox                  = New-Object system.Windows.Forms.TextBox
$PasswordTxtBox.multiline        = $false
$PasswordTxtBox.width            = 181
$PasswordTxtBox.height           = 20
$PasswordTxtBox.location         = New-Object System.Drawing.Point(17,171)
$PasswordTxtBox.Font             = 'Times New Roman,10'

$PasswordLabel                   = New-Object system.Windows.Forms.Label
$PasswordLabel.text              = "Temp Password*"
$PasswordLabel.AutoSize          = $true
$PasswordLabel.width             = 25
$PasswordLabel.height            = 10
$PasswordLabel.location          = New-Object System.Drawing.Point(15,154)
$PasswordLabel.Font              = 'Times New Roman,10'

$CopyFrmTxtBox                   = New-Object system.Windows.Forms.TextBox
$CopyFrmTxtBox.multiline         = $false
$CopyFrmTxtBox.width             = 181
$CopyFrmTxtBox.height            = 20
$CopyFrmTxtBox.location          = New-Object System.Drawing.Point(219,171)
$CopyFrmTxtBox.Font              = 'Times New Roman,10'

$CopyFrmLabel                    = New-Object system.Windows.Forms.Label
$CopyFrmLabel.text               = "Copy AD access from: (username)"
$CopyFrmLabel.AutoSize           = $true
$CopyFrmLabel.width              = 25
$CopyFrmLabel.height             = 10
$CopyFrmLabel.location           = New-Object System.Drawing.Point(216,154)
$CopyFrmLabel.Font               = 'Times New Roman,10'

$DepartmentCombo                 = New-Object system.Windows.Forms.ComboBox
$DepartmentCombo.width           = 181
$DepartmentCombo.height          = 20
@('Accounting', 'Administration', 'Admissions', 'Ambulatory Care', 'Cardiac Rehab', 'Community Services', 'Dietary', 'Emergency Department', 'Endoscopy', 'Family Birth Suites', 'Fund Development', 'Guest Services', 'HRSA Grant', 'Health Information', 'Heart/Stroke', 'Home Health', 'Housekeeping', 'Human Services', 'Information Systems', 'Intensive Care Unit', 'Laboratory', 'Laundry Services', 'MP Navigator', 'Materials Mgmt', 'Med/Surg', 'Nuclear Medicine', 'Nursing Administration', 'Occupational Therapy', 'Outreach Support Svcs', 'PIMG', 'Pastoral Care', 'Patient Accounts', 'Pharmacy', 'Physical Therapy', 'Plant Operations', 'Professional Svcs', 'Quality Management', 'Radiology', 'Recovery Room', 'Respiratory Services', 'Risk Management', 'SCKB&J', 'Scheduling', 'Social Services', 'Speech Therapy', 'Staff Education', 'Stafford RHC', 'Sterile Processing', 'Surgery', 'Surgicenter', 'Urgent Care') | ForEach-Object {[void] $DepartmentCombo.Items.Add($_)}
$DepartmentCombo.location        = New-Object System.Drawing.Point(17,213)
$DepartmentCombo.Font            = 'Times New Roman,10'
$DepartmentCombo.AutoCompleteMode = 'Suggest'
$DepartmentCombo.AutoCompleteSource = 'ListItems'

$DepartmentLabel                 = New-Object system.Windows.Forms.Label
$DepartmentLabel.text            = "Department*"
$DepartmentLabel.AutoSize        = $true
$DepartmentLabel.width           = 25
$DepartmentLabel.height          = 10
$DepartmentLabel.location        = New-Object System.Drawing.Point(15,197)
$DepartmentLabel.Font            = 'Times New Roman,10'

$JobTitleCombo                   = New-Object system.Windows.Forms.ComboBox
$JobTitleCombo.width             = 181
$JobTitleCombo.height            = 20
@('ARRT', 'ARRT-MRI', 'Accounts Payable Clerk', 'Administrative Assistant', 'Admissions Clerk', 'Benefits Administrator', 'Buyer', 'CNA', 'COTA', 'CPTA', 'CRNA', 'CST', 'Chaplain', 'Chemistry Supervisor', 'Clinic Office Manager', 'Clinical IT Technician', 'Clinical Staff Manager', 'Clinical Trial Coordinator', 'Coder', 'Consultant', 'Contract APRN', 'Contract CNA', 'Contract RN', 'Contract Ultrasound Tech', 'Controller', 'DO', 'DPM', 'Dietary Aide', 'Director - Clinical Information', 'Director - Home Health', 'Director - Information Systems', 'Director - PHF', 'Director - Patient Financial Services', 'Director - Pharmacy', 'Director - Quality and Information', 'Director - RCS / Lab', 'Director - Radiology', 'Director - Special Projects', 'Director - Surgical Services', 'Discharge Planner', 'Endo Tech', 'Executive Assistant', 'Floor Maintenance', 'Guest Services Assistant', 'Guest Services Coordinator', 'HIM Specialist', 'Home Health Billing', 'Housekeeper', 'IT Technician', 'LMSW', 'LPN', 'LPN-C', 'Laundry Specialist', 'Laundry Worker', 'MD', 'MLT', 'MT', 'Mail Courier', 'Maintenance Engineer', 'Manager - Ambulatory Care', 'Manager - Community Relations', 'Manager - Critical Care', 'Manager - Family Birth Suites', 'Manager - Housekeeping', 'Manager - ICU', 'Manager - Laboratory', 'Manager - Materials Mgmt', 'Manager - Med/Surg', 'Manager - Operative Services', 'Manager - Plant Operations', 'Market Place Navigator', 'Materials Mgmt Assist.', 'Medical Assist.', 'Medical Director - Laboratory', 'Medical Records Clerk', 'Medical Staff Coordinator', 'Microbiologist', 'NOW Project Director', 'Nuclear Med Tech', 'Nursing Administrative Assistant', 'OTR', 'Office Assist.', 'PA', 'PA-C', 'PT', 'Patient Access Representative', 'Patient Accounts Specialist', 'Patient Financial Counselor', 'Patient Quality & Safety Coord', 'Payroll Manager', 'PhD', 'Pharm.D.', 'Pharmacy Student', 'Pharmacy Tech', 'Phlebotomist', 'President & CEO', 'RD', 'RN', 'RN-APRN', 'RN-BSN', 'RN-C', 'RN-DNP', 'RN-DPN', 'RN-MSN', 'RPA-C', 'RRT', 'RT', 'Receptionist', 'Respiratory Therapist', 'Risk Manager', 'SPDT', 'ST (non-cert)', 'Safety Officer', 'Screener', 'Senior Respiratory Therapist', 'Speech Pathologist', 'Staff Accountant', 'Staff Education Coordinator', 'Student', 'Systems Administrator II', 'Test', 'Transcriptionist', 'Ultrasound Tech, ARDMS', 'Utilization Review Coordinator', 'VP & CFO', 'VP & CNO', 'VP & Chief Human Resources Officer', 'VP of Clinic Operations', 'Ward Clerk') | ForEach-Object {[void] $JobTitleCombo.Items.Add($_)}
$JobTitleCombo.location          = New-Object System.Drawing.Point(218,213)
$JobTitleCombo.Font              = 'Times New Roman,10'
$JobTitleCombo.AutoCompleteMode  = 'Suggest'
$JobTitleCombo.AutoCompleteSource = 'ListItems'

$JobTitleLabel                   = New-Object system.Windows.Forms.Label
$JobTitleLabel.text              = "Job Title*"
$JobTitleLabel.AutoSize          = $true
$JobTitleLabel.width             = 25
$JobTitleLabel.height            = 10
$JobTitleLabel.location          = New-Object System.Drawing.Point(216,197)
$JobTitleLabel.Font              = 'Times New Roman,10'

$OK                              = New-Object system.Windows.Forms.Button
$OK.text                         = "OK"
$OK.width                        = 60
$OK.height                       = 30
$OK.location                     = New-Object System.Drawing.Point(138,393)
$OK.Font                         = 'Times New Roman,10'
$OK.DialogResult                 = "OK"
$OK.Enabled                      = $false

$Instructions                    = New-Object system.Windows.Forms.Label
$Instructions.text               = "To begin user creation process, fill out required fields and press OK"
$Instructions.AutoSize           = $true
$Instructions.width              = 25
$Instructions.height             = 10
$Instructions.location           = New-Object System.Drawing.Point(12,350)
$Instructions.Font               = 'Times New Roman,10'

$Instruction2                    = New-Object system.Windows.Forms.Label
$Instruction2.text               = "Required fields are marked with the * character"
$Instruction2.AutoSize           = $true
$Instruction2.width              = 25
$Instruction2.height             = 10
$Instruction2.location           = New-Object System.Drawing.Point(12,367)
$Instruction2.Font               = 'Times New Roman,10'

$CancelButton                    = New-Object system.Windows.Forms.Button
$CancelButton.text               = "Cancel"
$CancelButton.width              = 60
$CancelButton.height             = 30
$CancelButton.location           = New-Object System.Drawing.Point(216,393)
$CancelButton.Font               = 'Times New Roman,10'
$CancelButton.DialogResult       = 'CANCEL'

$InitialTextBox                  = New-Object system.Windows.Forms.TextBox
$InitialTextBox.multiline        = $false
$InitialTextBox.width            = 181
$InitialTextBox.height           = 20
$InitialTextBox.location         = New-Object System.Drawing.Point(17,259)
$InitialTextBox.Font             = 'Microsoft Sans Serif,10'

$InitialLabel                    = New-Object system.Windows.Forms.Label
$InitialLabel.text               = "Middle Initial"
$InitialLabel.AutoSize           = $true
$InitialLabel.width              = 25
$InitialLabel.height             = 10
$InitialLabel.location           = New-Object System.Drawing.Point(17,241)
$InitialLabel.Font               = 'Microsoft Sans Serif,10'

$EmpIDLabel                    = New-Object system.Windows.Forms.Label
$EmpIDLabel.text               = "Employee ID"
$EmpIDLabel.AutoSize           = $true
$EmpIDLabel.width              = 25
$EmpIDLabel.height             = 10
$EmpIDLabel.location           = New-Object System.Drawing.Point(216,239)
$EmpIDLabel.Font               = 'Microsoft Sans Serif,10'

$EmpIDTextBox                  = New-Object system.Windows.Forms.TextBox
$EmpIDTextBox.multiline        = $false
$EmpIDTextBox.width            = 181
$EmpIDTextBox.height           = 20
$EmpIDTextBox.location         = New-Object System.Drawing.Point(216,259)
$EmpIDTextBox.Font             = 'Microsoft Sans Serif,10'

$MobileLabel                    = New-Object system.Windows.Forms.Label
$MobileLabel.text               = "Mobile Number:"
$MobileLabel.AutoSize           = $true
$MobileLabel.width              = 25
$MobileLabel.height             = 10
$MobileLabel.location           = New-Object System.Drawing.Point(216,285)
$MobileLabel.Font               = 'Times New Roman,10'

$MobileTextBox                  = New-Object system.Windows.Forms.TextBox
$MobileTextBox.multiline        = $false
$MobileTextBox.width            = 181
$MobileTextBox.height           = 20
$MobileTextBox.location         = New-Object System.Drawing.Point(216,305)
$MobileTextBox.Font             = 'Microsoft Sans Serif,10'


 #Function for validating blank fields. Ok button remains disabled unless all fields contain text
function validateText(){
    if($FirstNameTxtBox.Text -and $LastNameTxtBox.Text -and $PasswordTxtBox.Text -and $DescriptionTxtBox.Text -and $ManagerTxtBox.Text -and $DepartmentCombo.Text -and $JobTitleCombo.Text){
          $OK.Enabled = $true
    }
    else{
          $OK.Enabled = $false
   }
}

#Check fields against validation function

$FirstNameTxtBox.Add_TextChanged({validateText})
$LastNameTxtBox.Add_TextChanged({validateText})
$PasswordTxtBox.Add_TextChanged({validateText})
$DescriptionTxtBox.Add_TextChanged({validateText})
$ManagerTxtBox.Add_TextChanged({validateText})
$DepartmentCombo.Add_TextChanged({validateText})
$JobTitleCombo.Add_TextChanged({validateText})

$NewUserForm.controls.AddRange(@($FirstNameTxtBox,$FirstNameLabel,$LastNameLabel,$LastNameTxtBox,$DescriptionTxtBox,$DescriptionLabel,$FaxTxtBox,$FaxLabel,$PhoneExtTxtBox,$DeskPhLabel,$ManagerTxtBox,$ManagerLabel,$PasswordTxtBox,$PasswordLabel,$CopyFrmTxtBox,$CopyFrmLabel,$DepartmentCombo,$DepartmentLabel,$JobTitleCombo,$JobTitleLabel,$OK,$Instructions,$Instruction2,$Instruction3,$CancelButton,$InitialTextBox,$InitialLabel,$EmpIDLabel,$EmpIDTextBox,$MobileLabel,$MobileTextBox))



$result = $NewUserForm.ShowDialog()


#OK and Cancel

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $FirstName = $FirstNameTxtBox.Text
    $LastName  = $LastNameTxtBox.Text
    $Password = $PasswordTxtBox.Text
    $PasswordSecure = ConvertTo-SecureString $Password -AsPlainText -Force
    $Description = $DescriptionTxtBox.Text
    $IpPhone = $PhoneExtTxtBox.Text
    $FaxNumber = $FaxTxtBox.Text
    $Department = $DepartmentCombo.Text
    $JobTitle = $JobTitleCombo.Text
    $CopyAccess = $CopyFrmTxtBox.Text
    $Manager = $ManagerTxtBox.Text
    $MiddleInitial = $InitialTextBox.Text
    $EmployeeID = $EmpIDTextBox.Text
    $Mobile = $MobileTextBox.Text

}

if ($result -eq [System.Windows.Forms.DialogResult]::CANCEL)
{
    ex
}
Import-Module -Name ActiveDirectory
$SamAccountName =     
"$($FirstName.Substring(0,1))$LastName".ToLower()
$Userprincipalname = "$SamAccountName@domain.com"
$OU =  "OU=Users,DC=domain,DC=com"

#Check if username exists and prompt for new username if it does

if(Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'"){   

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Username Exists'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(150,120)
    $cancelButton.Size = New-Object System.Drawing.Size(75,23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Username already exists. Please enter an alternate username:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $SamAccountName = $textBox.Text
        $Userprincipalname = "$SamAccountName@domain.com"
    }

    if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
    {
        ex
    }
}




#Define all userparams

if ($InitialTextBox.Text.Length -gt 0)
{
    $UserParams = @{
        SamAccountName        = $SamAccountName
        AccountPassword       = $PasswordSecure
        UserPrincipalName     = $Userprincipalname
        Surname               = $LastName 
        GivenName             = $FirstName 
        EmailAddress          = "$SamAccountName@domain.com"
        DisplayName           = "$FirstName $MiddleInitial. $LastName"
        Name                  = "$FirstName $MiddleInitial. $LastName"
        Path                  = $OU
        Department            = $Department
        Description           = $Description
        title                 = $JobTitle
        company               = 'Company'
        manager               = $Manager
    }
}
else {
    $UserParams = @{
        SamAccountName        = $SamAccountName
        AccountPassword       = $PasswordSecure
        UserPrincipalName     = $Userprincipalname
        Surname               = $LastName 
        GivenName             = $FirstName 
        EmailAddress          = "$SamAccountName@domain.com"
        DisplayName           = "$FirstName $LastName"
        Name                  = "$FirstName $LastName"
        Path                  = $OU
        Department            = $Department
        Description           = $Description
        title                 = $JobTitle
        company               = 'Company'
        manager               = $Manager
    }
}

$DisplayName = "$FirstName $MiddleInitial $LastName"


# Set user attributers in AD and copy access from a user

New-ADUser @UserParams
Get-ADUser -Identity $CopyAccess -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $SamAccountName
Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $SamAccountName
Set-ADUser -Identity $SamAccountName -Replace @{ipPhone = $IpPhone}
Set-ADUser -Identity $SamAccountName -Replace @{ipPhone = $IpPhone}
Set-ADUser -Identity $SamAccountName -Replace @{facsimileTelephoneNumber = $FaxNumber}
Set-ADUser -Identity $SamAccountName -ChangePasswordAtLogon $true
Set-ADUser -Identity $SamAccountName -Enabled $true
Set-ADUser -Identity $SamAccountName -Department $Department
set-ADUser -Identity $SamAccountName -Title $JobTitle
set-ADUser -Identity $SamAccountName -Manager $Manager
set-ADUser -Identity $SamAccountName -Replace @{mail = $Userprincipalname}
Set-ADUser -Identity $SamAccountName -Initials $MiddleInitial
Set-ADUser -Identity $SamAccountName -EmployeeID $EmployeeID
Set-ADUser -Identity $SamAccountName -Replace @{mobile = $Mobile}

$RemoteAddress = "$SamAccountName@domain.mail.onmicrosoft.com"

# Display notification

$oReturn=[System.Windows.Forms.Messagebox]::Show("Now creating remote mailbox for user on exchange server. Please login as domain\administrator after clicking ok on this prompt","Login Prompt",[System.Windows.Forms.MessageBoxButtons]::OkCancel)
switch($oReturn)
        {
    "Ok"
        {
        }
    "Cancel"
    {
     ex
	}
}


# Connect to Exchange server and enable remote mailbox for user

$UserCredential = Get-Credential -Credential 'domain\administrator'
$Session = $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://exchange.domain.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Invoke-Command -Session $Session -ScriptBlock {Enable-RemoteMailbox -Identity $Using:SamAccountName -RemoteRoutingAddress $Using:RemoteAddress} 
Invoke-Command -Session $Session -ScriptBlock {Enable-RemoteMailbox -Identity $Using:SamAccountName -Archive}
Remove-PSSession $Session


# Move user to correct OU based on selected Dept (our OUs are not named the same as department names so this could be done a lot cleaner if they were)

if ($Department -eq "Accounting"){
    get-ADUser "$SamAccountName" | Move-ADObject -TargetPath 'OU=Accounting,OU=Users,DC=domain,DC=com'
    }

elseif ($Department -eq "Marketing"){
    get-ADUser "$SamAccountName" | Move-ADObject -TargetPath 'OU=Marketing,OU=Users,DC=domain,DC=com'
    }

elseif ($Department -eq "Sales"){
    get-ADUser "$SamAccountName" | Move-ADObject -TargetPath 'OU=Sales,OU=Users,DC=domain,DC=com'
    }


#Set Home Directory drive

$HomeDirPath = "\\fileserver.domain.com\users\$SamAccountName"
$HomeDrive = "Y:"


$_user = Get-ADUser -Identity $SamAccountName
Set-ADUser $SamAccountName -HomeDrive "$HomeDrive" -HomeDirectory "$HomeDirPath" -ea Stop
$_homeDirObj = New-Item -path "$HomeDirPath" -ItemType Directory -force -ea Stop
$_acl = Get-Acl $_homeDirObj

# Create an ACL for the user's HomeDir

$FileSystemRights = [System.Security.AccessControl.FileSystemRights]"FullControl"
$AccessControlType = [System.Security.AccessControl.AccessControlType]::Allow
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]"None"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($_user.SID, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)

#When you create a homeDir from within ADUC, it also writes the following ACE ("Administrators" with full control, inherited from "none")
#We're trying to recreate that process, exactly.

$Admins = Get-ADGroup -Identity "Administrators"
$AdminsAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($Admins.SID, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)

$_acl.AddAccessRule($AccessRule)
$_acl.AddAccessRule($AdminsAccessRule)


Set-Acl -Path "$HomeDirPath" -AclObject $_acl -ea Stop

#Display sleep message

$oReturn=[System.Windows.Forms.Messagebox]::Show("Please wait 60 Seconds after clicking ok for AADC to sync. Another Window will come up after 60 seconds","AADC1",[System.Windows.Forms.MessageBoxButtons]::Ok)
switch($oReturn)
       {
    "Ok"
        {
        }
    "Cancel"
    {
     ex
	}

}


# Connect to AAD-Connect server to start delta sync and wait 75 seconds before contuining on the script
$AADServer = "aadc.domain.com"
$Session = New-PSSession -computerName $AADServer
Invoke-Command -Session $Session -ScriptBlock {Start-ADSyncSyncCycle -Policytype Delta}
Remove-PSSession $Session




Start-Sleep -Seconds 60



# Login to Office 365 to set licenses (you will need to change the licensing to match your requirements. Could add more options here as well.)

$oReturn=[System.Windows.Forms.Messagebox]::Show("AADC1 is done syncing. Please login as your domain admin user to assign the office 365 license. Will the user need the full desktop license? Press Yes for E3/Enterprise Mobility and Security E3 or No for web only F3 License.","Login Prompt",[System.Windows.Forms.MessageBoxButtons]::YesNo)
switch($oReturn)
{
    "Yes"
        { #Connect to MSOnline to set user UsageLocation and assign
        #E3/EMS license
        Import-Module MSOnline
        Connect-MsolService
        $E3 = "domain:ENTERPRISEPACK"
        $EMS = "domain:EMS"
        Set-MsolUser -Userprincipalname $Userprincipalname -UsageLocation US
        Set-MsolUserLicense -UserPrincipalName $Userprincipalname -AddLicenses $E3,$EMS 
        }
        "No"
        {
        Import-Module MSOnline
        Connect-MsolService
        $F3 = "domain:SPE_F1"
        Set-MsolUser -Userprincipalname $Userprincipalname -UsageLocation US
        Set-MsolUserLicense -UserPrincipalName $Userprincipalname -AddLicenses $F3
        }
}

#Reminder to setup web app access

#Application #1


$oReturn=[System.Windows.Forms.Messagebox]::Show("Will user be using web application 1?","Web app 1",[System.Windows.Forms.MessageBoxButtons]::YesNo)
switch($oReturn)

{
    "Yes"
        {
    Start-Process -FilePath 'C:\Program Files (x86)\Google\Chrome\Application' -ArgumentList 'https://webapp1.domain.com'
    [System.Windows.Forms.Messagebox]::Show("Click OK when done setting up user","Web App 1")
        }
    "No"
        {
        }
}



#Non-captured information to be included on final email


[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$AthUsrTitle = 'Web App 1 Username'
$AthUsrMsg   = 'Enter the users Web App 1 username:'
$AthUsr = [Microsoft.VisualBasic.Interaction]::InputBox($AthUsrMsg, $AthUsrTitle)


#Completion message

$oReturn=[System.Windows.Forms.Messagebox]::Show("The user has been created successfully. Send an E-Mail to support@domain.com, HR, and the user's manager.?","E-Mail",[System.Windows.Forms.MessageBoxButtons]::OkCancel)
switch($oReturn)
{
    "Ok"
        {   #Send Email 
            Send-MailMessage -BodyAsHtml -To "$Manager@domain.com" -From “support@domain.com” -Cc "support@domain.com", "hr@domain.com", -Subject “New Employee $DisplayName $JobTitle Login Information” -Body "<b>$DisplayName $JobTitle</b> in <b>$Department</b> has `
            had all of their relevant accounts created. Their login information is as follows: <br> <br> <b><u>Computer/Email</u></b> - <br> <br> <b>Username</b>: $SamAccountName <br> <b>Email Address</b>: $SamAccountName@domain.com <br> <b>Password</b>: $Password <br> <br> `
            <b><u>Webapp 1</u></b>: <br> <b>Username</b>: $AthUsr <br> <b>Password</b>: $AthPwd <br> <br> `
            <br> <br> <b>Phone Extension</b>: $IpPhone <br> <br> `
            <b><u>Comments</u></b>: <br> $AdComments<br> <br> `
            If you have any questions or concerns, please email us at support@domain.com or contact the helpdesk at extension 1234.<br> <br>Thank you,<br> <br>Domain IT Dept." `
            -SmtpServer "mail.domain.com"
        }
        "Cancel"
        {
        }
}





#Display User information summary

$oReturn=[System.Windows.Forms.Messagebox]::Show("Press Ok to display a summary of the created user. Please make sure all information is correct. If not, please correct it manually through AD etc.","Done",[System.Windows.Forms.MessageBoxButtons]::Ok)
switch($oReturn)
{
    "Ok"
        { Get-ADUser $SamAccountName -Properties GivenName, Surname, Name, Manager, Description, Department | Out-GridView
        }
}
