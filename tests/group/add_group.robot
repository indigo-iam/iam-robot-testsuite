*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add Group Tests setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${TEST_GROUP_NAME}  Betatesters

*** Keywords ***

Add Group Tests setup
  Login as admin
  Go to Indigo dashboard
  Go to groups page

*** Test Cases ***

Open And Close Add Group Dialog
  Open Groups Add Group Dialog
  Close Groups Add Group Dialog

Create And Delete Group
  Create Group  ${TEST_GROUP_NAME}
  Delete Group  ${TEST_GROUP_NAME}