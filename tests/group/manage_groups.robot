*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add Group Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   group:manage

*** Variables ***
${TEST_GROUP_NAME}  Betatesters
${NOT_EMPTY_GROUP}  Analysis

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

Group with member cannot be removed
  Find group in groups page  ${NOT_EMPTY_GROUP}
  ${uuid}=  Get group uuid  ${NOT_EMPTY_GROUP}
  Click Button  id=delete_group_${uuid}
  Wait Until Page Contains  Are you sure you want to delete group '${NOT_EMPTY_GROUP}'
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  Group is not empty
