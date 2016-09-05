*** Keywords ***
Input username  [Arguments]  ${username}
  Input Text  id=username  ${username}

Input password  [Arguments]  ${password}
  Input Text  id=password  ${password}

Login as admin
  Input username  ${ADMIN_USER}
  Input password  ${ADMIN_PASSWORD}
  Click Element  xpath=//input[@value='Login']
  Wait Until Page Contains  Welcome!

Logout
  Click Element  id=userButton
  Click Element  xpath=//a[@class='logoutLink']
  Wait Until Page Contains  INDIGO IAM server-Log In
  