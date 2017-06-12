*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Manage credentials setup
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${TEST_USER}          Test User

${TEST_OIDC_ISSUER}   Test OIDC issuer
${TEST_OIDC_SUBJECT}  Test OIDC subject

${TEST_SAML_IDPID}    Test SAML Identity Provider
${TEST_SAML_USERID}   Test SAML User Id
${TEST_SAML_ATTRID}   employeeNumber

*** Test Cases ***

Add and remove Open ID Connect account to user
  Open add Open ID Connect account dialog  ${TEST_USER}
  Input OIDC Issuer  ${TEST_OIDC_ISSUER}
  Input OIDC Subject  ${TEST_OIDC_SUBJECT}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains  ${TEST_OIDC_ISSUER}
  Wait Until Page Contains  ${TEST_OIDC_SUBJECT}
  Remove Open ID Account  ${TEST_OIDC_ISSUER}  ${TEST_OIDC_SUBJECT}

Add and remove SAML account to user
  Open add SAML account dialog  ${TEST_USER}
  Input SAML Idp  ${TEST_SAML_IDPID}
  Select From List By Label  id=attributeId  ${TEST_SAML_ATTRID}
  Input SAML UserId  ${TEST_SAML_USERID}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains  ${TEST_SAML_IDPID}
  Wait Until Page Contains  ${TEST_SAML_USERID}
  Focus  name=btn-add-samlid
  Remove SAML Account  ${TEST_SAML_IDPID}  ${TEST_SAML_USERID}

*** Keywords ***

Manage credentials setup
  Login as admin
  Go to Indigo dashboard
  Go to user page  ${TEST_USER}

Input OIDC Issuer  [Arguments]  ${issuer}
  Input Text  id=add-oidc-issuer  ${issuer}

Input OIDC Subject  [Arguments]  ${subject}
  Input Text  id=add-oidc-subject  ${subject}

Input SAML Idp  [Arguments]  ${idp}
  Input Text  id=idp  ${idp}

Input SAML UserId  [Arguments]  ${userId}
  Input Text  id=userid  ${userId}
