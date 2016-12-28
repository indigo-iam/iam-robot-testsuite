*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  User Page Navigation Tests setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***

${TEST_USER}          Test User

*** Keywords ***

User Page Navigation Tests setup
  Login as admin
  Go to Indigo dashboard
  Go to user page  ${TEST_USER}

*** Test Cases ***

Open and close add group dialog
  Open add group dialog  ${TEST_USER}
  Close add group dialog

Open and close add OpenID Connect Account dialog
  Open add Open ID Connect account dialog  ${TEST_USER}
  Close Open ID Connect account dialog

Open and close add SAML Account dialog
  Open add SAML account dialog  ${TEST_USER}
  Close add SAML account dialog