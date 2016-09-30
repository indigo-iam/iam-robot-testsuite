*** Keywords ***

Find group in groups page  [Arguments]  ${text}
  Input text  xpath=//div[@class='input-group']/input  ${text}
  Wait Until Page Contains Element  xpath=//*[@id='groupslist']/tbody/tr/td/a[text()='${text}']