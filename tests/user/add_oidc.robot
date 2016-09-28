*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Add OIDC Test setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${TEST_USER}          Test User
${TEST_OIDC_ISSUER}   Test OIDC issuer
${TEST_OIDC_SUBJECT}  Test OIDC subject

*** Keywords ***

Add OIDC Test setup
  Login as admin
  Go to Indigo dashboard
  Go to user page  ${TEST_USER}

*** Test Cases ***

#Add group to user
#  Open add group dialog  ${TEST_USER}
#  Click Element  xpath=//div[contains(@class, 'ui-select-container')]/descendant::input
#  Click Element  name=modal-btn-cancel
#  Wait until modal overlay disappear

Add and remove Open ID Connect account to user
  Open add Open ID Connect account dialog  ${TEST_USER}
  Input OIDC Issuer  Test OIDC issuer
  Input OIDC Subject  Test OIDC subject
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains  ${TEST_OIDC_ISSUER}
  Wait Until Page Contains  ${TEST_OIDC_SUBJECT}
  Remove Open ID Account  ${TEST_OIDC_ISSUER}  ${TEST_OIDC_SUBJECT}

*** Keywords ***

Input OIDC Issuer  [Arguments]  ${issuer}
  Input Text  id=add-oidc-issuer  ${issuer}

Input OIDC Subject  [Arguments]  ${subject}
  Input Text  id=add-oidc-subject  ${subject}
