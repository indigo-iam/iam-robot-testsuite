*** Keywords ***

Open add group dialog  [Arguments]  ${user}
  Click Button  name=btn-add-group
  Wait Until Page Contains  Add group(s) to ${user}

Close add group dialog
  Click Element  name=modal-btn-cancel
  Wait until modal overlay disappear

Open add Open ID Connect account dialog  [Arguments]  ${user}
  Click Button  name=btn-add-oidc
  Wait Until Page Contains  Add Open ID Connect account to ${user}

Close Open ID Connect account dialog
  Click Element  id=modal-btn-cancel
  Wait until modal overlay disappear

Open add SSH Key account dialog  [Arguments]  ${user}
  Click Button  name=btn-add-sshkey
  Wait Until Page Contains  Add SSH Key to ${user}

Close SSH Key account dialog
  Click Element  id=modal-btn-cancel
  Wait until modal overlay disappear

Open add SAML account dialog  [Arguments]  ${user}
  Click Button  name=btn-add-samlid
  Wait Until Page Contains  Add SAML Account to ${user}

Close add SAML account dialog
  Click Element  id=modal-btn-cancel
  Wait until modal overlay disappear

Open add x509 certificate dialog  [Arguments]  ${user}
  Click Button  name=btn-add-x509cert
  Wait Until Page Contains  Add x509 Certificate to ${user}

Close x509 certificate dialog
  Click Element  id=modal-btn-cancel
  Wait until modal overlay disappear

Input OIDC Issuer  [Arguments]  ${issuer}
  Input Text  id=add-oidc-issuer  ${issuer}

Input OIDC Subject  [Arguments]  ${subject}
  Input Text  id=add-oidc-subject  ${subject}

Remove Open ID Account  [Arguments]  ${issuer}  ${subject}
  Click Element  xpath=//*[@id='oidc_account_list']/tbody/tr/td[text()='${subject}']/following-sibling::td//button
  Wait Until Page Contains  Remove Open ID Account
  Click Button  Remove Open ID Account
  Wait until modal overlay disappear
  Wait Until Page Contains  Open ID Account ${issuer} - ${subject} has been removed successfully