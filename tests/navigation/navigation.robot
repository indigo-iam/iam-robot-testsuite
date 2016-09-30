*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Navigation Tests setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***

${TEST_USER}          Test User
${TEST_GROUP}         Production

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

Open requests page
  Go to request management page