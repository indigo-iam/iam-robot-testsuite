*** Keywords ***
Input username  [Arguments]  ${username}
  Input Text  id=username  ${username}

Input password  [Arguments]  ${password}
  Input Text  id=password  ${password}

Login as admin
  Wait Until Page Contains Element  id=username
  Input username  ${ADMIN_USER}
  Wait Until Page Contains Element  id=password
  Input password  ${ADMIN_PASSWORD}
  Click Element  xpath=//input[@value='Login']
  Wait Until Page Contains  Welcome!

Logout from Mitre dashboard
  Click Element  id=userButton
  Click Element  xpath=//a[@class='logoutLink']
  Wait Until Page Contains  INDIGO IAM server-Log In
 
Logout from Indigo dashboard
  Click Element  xpath=//li[@class='dropdown user user-menu']/a[@class='dropdown-toggle']/img[@class='user-image']
  Wait Until Page Contains  Sign out
  Click Link  link=Sign out
  Wait Until Page Contains  INDIGO IAM server-Log In