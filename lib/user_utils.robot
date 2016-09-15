*** Keywords ***
Delete user  [Arguments]  ${name}
  Click menu navigation entry  Users
  Wait until modal overlay disappear
  Wait Until Page Contains  Created
  Input text  xpath=//div[@class='input-group']/input  ${name}
  Wait Until Page Contains  ${name}
  Click Element  xpath=//*[@id='userslist']/tbody/tr/td/a[text()='${name}']/../following-sibling::td/button
  Wait Until Page Contains  Delete?
  Click Button  Delete User
  Wait until modal overlay disappear
  Wait Until Page Contains  deleted successfully
