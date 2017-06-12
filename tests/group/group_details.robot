*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Setup for group details tests
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${PARENT_GROUP}        Test-001
  
*** Test Cases ***
Group details page contains subgroups table
  Page Should Contain Element  id=subgroupslist
  Page Should Contain Element  xpath=//*/h3[text()='Subgroups']
  Page Should Contain Button  Add Subgroup

Group details page contains members table
  Page Should Contain Element  id=userslist
  Page Should Contain Element  xpath=//*/h3[text()='Members']

Empty group has emtpy details tables
  Page Should Contain  No subgroup found.
  Page Should Contain  No member found.

Subgroup creation form is invalid with name too long
  ${name}=  Set Variable  group_with_name_longer_than_fifty_characters_is_not_allowed
  Click Button  Add Subgroup
  Input Name In Add Group Dialog  ${name}
  Element Should Be Disabled  id=modal-btn-confirm
  Page Should Contain Element  css=span.help-block
  Page Should Contain  Max 50 characters
  Close Groups Add Group Dialog
  
*** Keywords ***
Setup for group details tests
  Login as admin
  Go to Indigo dashboard
  Go to groups page
  Go to group details page  ${PARENT_GROUP}
 