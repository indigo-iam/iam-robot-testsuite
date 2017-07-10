*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers
Force Tags   home:account-linking

*** Variables  ***
${TEST_USERNAME}    test
${TEST_PASSWORD}    password
${CERT_SUBJECT}     CN=test0,O=IGI,C=IT
${CERT_ISSUER}      CN=Test CA,O=IGI,C=IT

*** Test Cases ***

Test certificate linking
    Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
    Click Button   name=btn-link-cert
    Wait Until Page Contains   Link an X.509 certificate to your IAM account   timeout=0.05
    Click Button   id=btn-link
    Wait until modal overlay disappear
    Wait Until Page Contains   Certificate '${CERT_SUBJECT}' linked succesfully
    Click Button   id=unlink-cert-0
    Wait Until Page Contains   Unlink X.509 certificate from your IAM account   timeout=0.05
    Click Button   id=btn-unlink
    Wait until modal overlay disappear
    Wait Until Page Contains   Certificate '${CERT_SUBJECT}' unlinked succesfully
    Logout from Indigo dashboard