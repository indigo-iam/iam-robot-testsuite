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

${TEST_X509_LABEL}    Test personal certificate
${TEST_X509_CERT}     LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURuakNDQW9hZ0F3SUJBZ0lCQ1RBTkJna3Foa2lHOXcwQkFRVUZBREF0TVFzd0NRWURWUVFHRXdKSlZERU0KTUFvR0ExVUVDZ3dEU1VkSk1SQXdEZ1lEVlFRRERBZFVaWE4wSUVOQk1CNFhEVEV5TURreU5qRTFNemt6TkZvWApEVEl5TURreU5ERTFNemt6TkZvd0t6RUxNQWtHQTFVRUJoTUNTVlF4RERBS0JnTlZCQW9UQTBsSFNURU9NQXdHCkExVUVBeE1GZEdWemREQXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFES3h0cncKaG9aMjdTeHhJU2psUnFXbUJXQjZVK04veFcya1MxdVVmclFSYXY2YXVWdG10RVc0NUo0NFZUaTNXVzZZMTEzUgpCd21TNm9XKzNsenlCQlpWUHFuaFY5L1ZrVHhMcDgzZ0dWVnZIQVRnR2dramVUeElzT0UrVGtQS0FvWkovUUZjCkNmUGgzV2RaM0FOSTE0V1lrQU05VlhzU2JoMm9rQ3NXR2E0bzZwenQzUHQxektreU80UFcwY0JrbGV0REltSksKMnZ1ZnVEVk5tN0l6L3kzLzhwWThwM01vaXdiRi9QZFNiYTdYUUF4QldVSk1vYWxlaDh4eThIU1JPbjd0RjJhbAp4b0RMSDRRV2hwNlVEbjJydk9Xc2VCcVVNUFhGanNVaTEvcmt3MW9IQWpNcm9UazVsTDE1R0kwTEdkNWRUVm9wCmtLWEZiVFRZeFNrUHoxTUxBZ01CQUFHamdjb3dnY2N3REFZRFZSMFRBUUgvQkFJd0FEQWRCZ05WSFE0RUZnUVUKZkxkQjUrak85THlXTjIvVkNOWWdNYTBqdkhFd0RnWURWUjBQQVFIL0JBUURBZ1hnTUQ0R0ExVWRKUVEzTURVRwpDQ3NHQVFVRkJ3TUJCZ2dyQmdFRkJRY0RBZ1lLS3dZQkJBR0NOd29EQXdZSllJWklBWWI0UWdRQkJnZ3JCZ0VGCkJRY0RCREFmQmdOVkhTTUVHREFXZ0JTUmR6WjdMclJwOHlmcXQvWUlpMG9qb2hGSnhqQW5CZ05WSFJFRUlEQWUKZ1J4aGJtUnlaV0V1WTJWalkyRnVkR2xBWTI1aFppNXBibVp1TG1sME1BMEdDU3FHU0liM0RRRUJCUVVBQTRJQgpBUUFOWXRXWGV0aGVTZVZwQ2ZuSWQ5VGtLeUtUQXA4UmFoTlpsNFhGcldXbjJTOVdlN0FDSy9HN3UxRGViSll4CmQ4UE9vOENsc2NvWHlUTzJCekhIWkx4YXVFS0l6VXY3ZzJHZWhJK1Nja2ZaZGpGeVJYakQwK3dNR3d6WDdNRHUKU0wzQ0cyYVdzWXBrQm5qNkJNbHIwUDNrWkVNcVY1dDIrMlRqMCthWHBwQlBWd3pKd1JobnJTSmlPNVdJWkFaZgo0OVloTW42MXNRSXJlcHZocktFVVI0WFZvckgyQmo4ZWsxL2lMbGdjbUZNQk9kcytQcmVoU1JSOEduMElqbEVnCkM2OEVZNktQRStGS3lTdVM3VXI3bFRBak5kZGRmZEFnS1Y2aEp5U1Q2L2R4OHltSWtiOG54Q1BueENjVDJJMk4KdkR4Y1BNYy93bW5NYStzbU5hbDBzSjZtCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K

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
  Focus  name=btn-add-samlid
  Open add SAML account dialog  ${TEST_USER}
  Input SAML Idp  ${TEST_SAML_IDPID}
  Input SAML UserId  ${TEST_SAML_USERID}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains  ${TEST_SAML_IDPID}
  Wait Until Page Contains  ${TEST_SAML_USERID}
  Focus  name=btn-add-samlid
  Remove SAML Account  ${TEST_SAML_IDPID}  ${TEST_SAML_USERID}

Add and remove x509 certificate to user
  Focus  name=btn-add-x509cert
  Open add x509 certificate dialog  ${TEST_USER}
  Input x509 label  ${TEST_X509_LABEL}
  Input x509 certificate  ${TEST_X509_CERT}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear
  Wait Until Page Contains Element  xpath=//table[@id='x509_list']/tbody/tr/td[text()='${TEST_X509_LABEL}']
  Focus  name=btn-add-x509cert
  Remove x509 certificate  ${TEST_X509_LABEL}

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

Input X509 label  [Arguments]  ${label}
  Input Text  xpath=//input[@ng-model='addX509CertCtrl.label']  ${label}

Input X509 certificate  [Arguments]  ${certificate}
  Input Text  xpath=//textarea[@ng-model='addX509CertCtrl.value']  ${certificate}
