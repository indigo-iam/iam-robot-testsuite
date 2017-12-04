*** Keywords ***
Close Groups Add Group Dialog
  Click Button  Cancel
  Wait until modal overlay disappear

Clear search in groups page
  Input text  xpath=//div[@class='input-group']/input  ${EMPTY}

Create group  [Arguments]  ${name}
  Open Groups Add Group Dialog
  Input Name In Add Group Dialog  ${name}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear

Delete group  [Arguments]  ${name}
  Find group in groups page  ${name}
  ${uuid}=  Get group uuid  ${name}
  Click Button  id=delete_group_${uuid}
  Wait Until Page Contains  Are you sure you want to delete group '${name}'
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  Group '${name}' DELETED successfully
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist

Find group in groups page  [Arguments]  ${text}
  Input text  xpath=//div[@class='input-group']/input  ${text}
  Wait Until Page Contains Element  xpath=//*[@id='groupslist']/tbody/tr/td/a[text()='${text}']

Get group uuid  [Arguments]  ${name}
  Find group in groups page  ${name}
  ${uuid}=  Get Element Attribute  xpath=//*[@id='groupslist']/tbody/tr/td/a[text()='${name}']/../../td[contains(@class,'uuid')]  id
  Log  ${uuid}
  [return]  ${uuid}

Go to group details page  [Arguments]  ${groupname}
  Find group in groups page  ${groupname}
  Click Link  link=${groupname}
  Wait until modal overlay disappear

Input Name In Add Group Dialog  [Arguments]  ${name}
  Input Text  id=name  ${name}

Open Groups Add Group Dialog
  Wait Until Page Contains Element  css=.box-footer
  Click Button  Add Group
  Wait Until Page Contains  Add new group
