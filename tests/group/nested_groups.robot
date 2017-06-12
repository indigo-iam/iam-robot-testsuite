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
${MEMBER_TYPE}         Group

  
*** Test Cases ***
Create group with parent
  Open Groups Add Group Dialog
  Create group with parent  ${SUB_GROUP}  ${PARENT_GROUP}
  Find group in groups page  ${PARENT_GROUP}/${SUB_GROUP}
  
Create new subgroup
  Create Subgroup  ${SUB_GROUP}  ${PARENT_GROUP}
  Table Should Contain  userslist  ${SUB_GROUP}
  
Create second level subgroup
  Open Groups Add Group Dialog
  Create group with parent  ${SUB_GROUP}  ${PARENT_GROUP}
  Open Groups Add Group Dialog
  Create group with parent  ${SECOND_LEVEL_GROUP}  ${SUB_GROUP}
  Find group in groups page  ${PARENT_GROUP}/${SUB_GROUP}/${SECOND_LEVEL_GROUP}
  Delete subgroup  ${PARENT_GROUP}/${SUB_GROUP}/${SECOND_LEVEL_GROUP}
  
Group members don't have remove button
  Create Subgroup  ${SUB_GROUP}  ${PARENT_GROUP}
  ${row}=  Set Variable  2
  Table Cell Should Contain  userslist  ${row}  1  1
  Table Cell Should Contain  userslist  ${row}  2  ${SUB_GROUP}
  Table Cell Should Contain  userslist  ${row}  3  ${MEMBER_TYPE}
  Table Cell Should Contain  userslist  ${row}  4  ${EMPTY}
  
  
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
 