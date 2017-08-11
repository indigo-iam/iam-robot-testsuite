*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Navigation Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   navigation
*** Variables ***

${TEST_USER}          Test User
${TEST_GROUP}         Production
${TEST_EMPTY_GROUP}   Test-001

*** Keywords ***

Navigation Tests setup
  Login as admin
  Go to Indigo dashboard

*** Test Cases ***
Open home page
  Go to home page

Open users page
  Go to users page

Open groups page
  Go to groups page

Open user page
  Go to user page  ${TEST_USER}

Open group page
  Go to group page  ${TEST_GROUP}
  Wait Until Page Contains Element  id=userslist
  Wait Until Page Contains Element   xpath=//*[@id='userslist']/tbody/tr/td[text()='1']
  Table Row Should Contain  userslist  1  test

Open group page with an empty group
  Go to group page  ${TEST_EMPTY_GROUP}
  Wait Until Page Contains Element  id=userslist
  Page Should Contain  No member found

Open requests page
  Go to request management page
