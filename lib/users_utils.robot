*** Keywords ***

Open Add User Dialog
  Click Button  xpath=//div[@class='box-footer']//button
  Wait Until Page Contains  User creation form

Close Add User Dialog
  Click Button  Cancel
  Wait until modal overlay disappear

Input Name In Add User Dialog  [Arguments]  ${name}
  Input Text  id=name  ${name}

Input Surname In Add User Dialog  [Arguments]  ${surname}
  Input Text  id=surname  ${surname}

Input Email In Add User Dialog  [Arguments]  ${email}
  Input Text  id=email  ${email}

Input Username In Add User Dialog  [Arguments]  ${username}
  Input Text  id=username  ${username}

Input Picture In Add User Dialog  [Arguments]  ${picture}
  Input Text  id=picture  ${picture}

Find user in users page  [Arguments]  ${user}
  Input text  xpath=//div[@class='input-group']/input  ${user}
  Wait Until Page Contains Element  xpath=//*[@id='userslist']/tbody/tr/td/a[text()='${user}']

Clear search in users page
  Input text  xpath=//div[@class='input-group']/input  ${EMPTY}

Input New User  [Arguments]  ${givenname}  ${surname}  ${email}  ${username}
  Input Name In Add User Dialog  ${givenname}
  Input Surname In Add User Dialog  ${surname}
  Input Email In Add User Dialog  ${email}
  Input Username In Add User Dialog  ${username}

Create User  [Arguments]  ${name}  ${surname}  ${email}  ${username}
  Open Add User Dialog
  Input New User  ${name}  ${surname}  ${email}  ${username}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear

Delete user  [Arguments]  ${name}
  Find user in users page  ${name}
  Click Element  xpath=//*[@id='userslist']/tbody/tr/td/a[text()='${name}']/../following-sibling::td/button
  Wait Until Page Contains  Are you sure you want to delete user '${name}'
  Click Button  Delete User
  Wait until modal overlay disappear
  Wait Until Page Contains  has been removed successfully
  Clear search in users page