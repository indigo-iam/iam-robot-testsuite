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

  
*** Keywords ***
Setup for group details tests
  Login as admin
  Go to Indigo dashboard
  Go to groups page
  Go to group details page  ${PARENT_GROUP}
 