*** Keywords ***

Clear search in groups page
  Input text  xpath=//div[@class='input-group']/input  ${EMPTY}

Create root group  [Arguments]  ${name}
  Open add root group dialog
  Input Text  id=name  ${name}
  Wait until element is enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear

Create subgroup to  [Arguments]  ${parentName}  ${subgroupName}
  Open add subgroup dialog for group  ${parentName}
  Input Text  id=name  ${subgroupName}
  Click Button  Add Subgroup
  Wait until modal overlay disappear
  Wait Until Page Contains  New group ${parentName}/${subgroupName} added as subgroup of ${parentName}
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist

Delete group  [Arguments]  ${groupName}
  Open delete group dialog  ${groupName}
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  Group ${groupName} successfully deleted
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist

Find group in groups page  [Arguments]  ${text}
  Input text  xpath=//div[@class='input-group']/input  ${text}
  Sleep  251ms
  Wait until modal overlay disappear
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

Open add root group dialog
  Wait Until Page Contains Element  css=.box-footer
  Click Button  Add Root Group
  Wait Until Page Contains  Add root group

Open add subgroup dialog for group  [Arguments]  ${parentName}
  Find group in groups page  ${parentName}
  ${uuid}=  Get group uuid  ${parentName}
  Click Button  id=add_subgroup_${uuid}
  Wait Until Page Contains  Add new subgroup to ${parentName}

Open delete group dialog  [Arguments]  ${groupName}
  Find group in groups page  ${groupName}
  ${uuid}=  Get group uuid  ${groupName}
  Click Button  id=delete_group_${uuid}
  Wait Until Page Contains  Are you sure you want to delete group '${groupName}'
  Wait until element is enabled  id=modal-btn-confirm