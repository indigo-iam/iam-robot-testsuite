*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add Remove Groups Setup
Test Teardown  Add Remove Groups Teardown

Force tags   user:groups

*** Variables ***
${TEST_USER_GIVENNAME}  Enrico
${TEST_USER_SURNAME}    Vianello
${TEST_USER_EMAIL}      enrico.vianello@cnaf.infn.it
${TEST_USER_USERNAME}   enrico.vianello@cnaf.infn.it

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

Delete Group  [Arguments]  ${group}
  Wait Until Element Is Visible  id=groupslist
  Wait Until Page Contains  ${group}
  Click Button  xpath=//table[@id='groupslist']//a[text()='${group}']/../following-sibling::td//button
  Wait Until Page Contains Element   xpath=//*[@id='btn-confirm']
  Click Button  Remove user from group
  Wait until modal overlay disappear

*** Test Cases ***

Add group to user
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Open add group dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Click Element   id=add-group-input  
  Input Text  id=add-group-input  Test-001
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]   timeout=0.05
  Click Element   id=ui-select-choices-row-0-0
  Sleep   1s
  Press Key   id=add-group-input  \\27
  Wait Until Element Is Enabled  name=modal-btn-confirm   timeout=0.05
  Click Button  name=modal-btn-confirm
  Wait Until Page Contains  Test-001
  Delete Group  Test-001

Add groups to user
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Open add group dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}
  Click Element  id=add-group-input
  Input Text  id=add-group-input  Test-001
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]
  Click Element   id=ui-select-choices-row-0-0
  Input Text  id=add-group-input  Test-002
  Wait Until Element Is Visible  xpath=//ul[contains(@class, 'ui-select-choices')]
  Click Element   id=ui-select-choices-row-0-0
  Sleep   1s
  Press Key   id=add-group-input  \\27
  Wait Until Element Is Enabled  name=modal-btn-confirm   timeout=0.05
  Click Button  name=modal-btn-confirm
  Wait Until Page Contains  Test-001   timeout=2
  Wait Until Page Contains  Test-002   timeout=0.05
  Delete Group  Test-001
  Delete Group  Test-002