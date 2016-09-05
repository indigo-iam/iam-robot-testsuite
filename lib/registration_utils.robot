*** Keywords ***
Open registration form
  Click Link  link=Register a new account
  Wait Until Page Contains  User Registration Form
  
Close registration form
  Click Button  name=dismiss
  
Register user  [Arguments]  ${name}  ${surname}  ${email}  ${username}
  Open registration form
  Input Text  id=name  ${name}
  Input Text  id=surname  ${surname}
  Input Text  id=email  ${email}
  Input Text  id=username  ${username}
  Wait Until Element Is Enabled  name=register
  Click Element  name=register
  Wait Until Page Contains  Request submission success
  Click Link  link=Back to Login Page