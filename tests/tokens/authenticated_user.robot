*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Non Admin Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   tokens:authenticated-user

*** Variables ***
${TEST_USER_USERNAME}   test
${TEST_USER_PASSWORD}   password

*** Keywords ***

Non Admin Tests setup
  Login as user  ${TEST_USER_USERNAME}  ${TEST_USER_PASSWORD}

*** Test Cases ***

Authenticated users dont see tokens page
  Element Should Not Be Visible  xpath=//span[.="Active Tokens"]