*** Keywords ***
Open registration form
  Wait Until Page Contains Element  link=Register a new account
  Click Link  link=Register a new account
  Wait Until Page Contains  This is the indigo-dc registration page
  
Close registration form
  Go back
  
Register user  [Arguments]  ${name}  ${surname}  ${email}  ${username}
  Open registration form
  Input Text  id=name  ${name}
  Input Text  id=surname  ${surname}
  Input Text  id=email  ${email}
  Input Text  id=username  ${username}
  Wait Until Element Is Enabled  name=register
  Click Element  name=register
  Wait Until Page Contains  Request submitted successfully
  Click Link  link=Back to Login Page