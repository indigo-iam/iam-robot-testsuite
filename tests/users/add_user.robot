*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add User Tests setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${TEST_USER_GIVENNAME}  Enrico
${TEST_USER_SURNAME}    Vianello
${TEST_USER_EMAIL}      enrico.vianello@cnaf.infn.it
${TEST_USER_USERNAME}   enrico.vianello@cnaf.infn.it

*** Keywords ***

Add User Tests setup
  Login as admin
  Go to Indigo dashboard
  Go to users page

*** Test Cases ***

Create And Delete User
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_SURNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_SURNAME}