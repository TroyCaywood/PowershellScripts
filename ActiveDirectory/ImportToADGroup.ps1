#Imports a list of users from a CSV to a specific group in AD

Import-Module ActiveDirectory 

 #Replace “c:\scripts\ImpDefaultUsers.csv” with CSV location, replace “CN=New Users,CN=Users,DC=domain,DC=com"  with the distinguished name of the group, replace ’User-Name’ with the title of the column in CSV that contains the usernames

Import-Csv -Path “c:\scripts\ImportUsers.csv” | ForEach-Object {Add-ADGroupMember -Identity “CN=New Users,CN=Users,DC=domain,DC=com” -Members $_.’User-Name’ }
