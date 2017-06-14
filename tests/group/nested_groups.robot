*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Setup for nested group tests
Test Teardown  Teardown for nested group tests

*** Variables ***
${PARENT_GROUP}        Test-001
${SUB_GROUP}           test-test
${SECOND_LEVEL_GROUP}  test-test-test

  
*** Test Cases ***
Create group with parent
  Open Groups Add Group Dialog
  Create group with parent  ${SUB_GROUP}  ${PARENT_GROUP}
  Find group in groups page  ${PARENT_GROUP}/${SUB_GROUP}
  
Create new subgroup
  Create Subgroup  ${SUB_GROUP}  ${PARENT_GROUP}
  ${row}=  Set Variable  2
  ${id}=  Set Variable  subgroupslist
  Table Cell Should Contain  ${id}  ${row}  1  1
  Table Cell Should Contain  ${id}  ${row}  2  ${SUB_GROUP}
  Table Cell Should Contain  ${id}  ${row}  3  Remove
  
Create second level subgroup
  Open Groups Add Group Dialog
  Create group with parent  ${SUB_GROUP}  ${PARENT_GROUP}
  Open Groups Add Group Dialog
  Create group with parent  ${SECOND_LEVEL_GROUP}  ${SUB_GROUP}
  Find group in groups page  ${PARENT_GROUP}/${SUB_GROUP}/${SECOND_LEVEL_GROUP}
  Delete subgroup  ${PARENT_GROUP}/${SUB_GROUP}/${SECOND_LEVEL_GROUP}
  
Remove subgroup from group page
  Create Subgroup  ${SUB_GROUP}  ${PARENT_GROUP}
  ${row}=  Set Variable  2
  ${id}=  Set Variable  subgroupslist
  Table Cell Should Contain  ${id}  ${row}  2  ${SUB_GROUP}
  Table Cell Should Contain  ${id}  ${row}  3  Remove
  Click Button  xpath=//*[@id='${id}']/tbody/tr[1]/td[3]/button
  Wait Until Page Contains  Are you sure you want to delete group '${SUB_GROUP}'
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  Group ${SUB_GROUP} DELETED successfully
  [Teardown]  Logout from Indigo dashboard
  
*** Keywords ***
Setup for nested group tests
  Login as admin
  Go to Indigo dashboard
  Go to groups page
  
Teardown for nested group tests
  Go to groups page
  Delete subgroup  ${PARENT_GROUP}/${SUB_GROUP}
  Logout from Indigo dashboard

Delete subgroup  [Arguments]  ${name}
  Find group in groups page  ${name}
  ${uuid}=  Get group uuid  ${name}
  Click Button  id=delete_group_${uuid}
  Wait Until Page Contains  Are you sure you want to delete group
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  DELETED successfully
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist

Create group with parent  [Arguments]  ${groupname}  ${parent}
  Input Name In Add Group Dialog  ${groupname}
  Select From List By Label  id=parent  ${parent}
  Wait Until Element Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear

Create subgroup  [Arguments]  ${groupname}  ${parent}
  Find group in groups page  ${parent}
  Click Link  link=${parent}
  Wait until modal overlay disappear
  Click Button  Add Subgroup
  Input Name In Add Group Dialog  ${groupname}
  Wait Until Element Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
 