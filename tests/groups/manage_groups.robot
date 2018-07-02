*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add Group Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   groups:manage

*** Variables ***
${TEST_GROUP_NAME}  Betatesters
${NOT_EMPTY_GROUP}  Analysis

*** Keywords ***

Add Group Tests setup
  Login as admin
  Go to Indigo dashboard
  Go to groups page

*** Test Cases ***

Open And Close Add Root Group Dialog
  Open Add Root Group Dialog
  Close Dialog

Create And Delete Root Group
  Create Root Group  ${TEST_GROUP_NAME}
  Delete Group  ${TEST_GROUP_NAME}

Group with member cannot be removed
  Open Delete Group Dialog  ${NOT_EMPTY_GROUP}
  Click Button  Delete Group
  Wait until modal overlay disappear
  Wait Until Page Contains  Group is not empty

Add subgroup to not empty group
  Open Add Subgroup Dialog for Group  ${NOT_EMPTY_GROUP}
  Input Text  id=name  ${TEST_GROUP_NAME}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains  New group ${NOT_EMPTY_GROUP}/${TEST_GROUP_NAME} added as subgroup of ${NOT_EMPTY_GROUP}
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist
  Delete Group  ${NOT_EMPTY_GROUP}/${TEST_GROUP_NAME}