*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add Remove Groups Setup
Test Teardown  Add Remove Groups Teardown

*** Variables ***
${TEST_USER_GIVENNAME}  Enrico
${TEST_USER_SURNAME}    Vianello
${TEST_USER_EMAIL}      enrico.vianello@cnaf.infn.it
${TEST_USER_USERNAME}   enrico.vianello@cnaf.infn.it

*** Test Cases ***

Add group to user
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Open add group dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Click Element  xpath=//input
  Input Group  Test-001
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]
  Click Element  xpath=//*[contains(@class, 'ui-select-highlight')]
  Wait Until Element Is Enabled  name=modal-btn-confirm
  Click Button  name=modal-btn-confirm
  Wait Until Page Contains  Test-001
  Delete Group  Test-001

Add groups to user
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Open add group dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Click Element  xpath=//input
  Input Group  Test-001
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]
  Click Element  xpath=//*[contains(@class, 'ui-select-highlight')]
  Input Group  ${EMPTY}
  Input Group  Test-002
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]
  Click Element  xpath=//*[contains(@class, 'ui-select-highlight')]
  Click Button  name=modal-btn-confirm
  Wait Until Page Contains  Test-001
  Wait Until Page Contains  Test-002
  Delete Group  Test-001
  Delete Group  Test-002


*** Keywords ***

Add Remove Groups Setup
  Login as admin
  Go to Indigo dashboard
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_SURNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}

Add Remove Groups Teardown
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Logout from Indigo dashboard

Input Group  [Arguments]  ${group}
  Input Text  xpath=//input  ${group}

Delete Group  [Arguments]  ${group}
  Wait Until Element Is Visible  id=groupslist
  Wait Until Page Contains  ${group}
  Click Button  xpath=//table[@id='groupslist']//a[text()='${group}']/../following-sibling::td//button
  Wait Until Page Contains Element   xpath=//*[@id='btn-confirm']
  Click Button  Remove user from group
  Wait until modal overlay disappear