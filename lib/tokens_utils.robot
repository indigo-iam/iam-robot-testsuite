*** Keywords ***
Get Admin Access Token
  ${tokenResponse}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  [Return]  ${tokenResponse["access_token"]}

Delete All Tokens
  ${token}=  Get Admin Access Token
  Create Http Context  host=${IAM_HTTP_HOST}  scheme=${IAM_HTTP_SCHEME}
  Set Request Header   Authorization   Bearer ${token}
  Next Request Should Have Status Code   204
  DELETE   /iam/api/refresh-tokens
  Set Request Header   Authorization   Bearer ${token}
  Next Request Should Have Status Code   204
  DELETE   /iam/api/access-tokens

Get Total Tokens Badge Value
  Page Should Contain Element  xpath=//small[@id="tokensBadge"]
  ${valueStr}=  Get Text  xpath=//small[@id="tokensBadge"]
  Run Keyword If  '${valueStr}' == '${EMPTY}'  Return From Keyword  ${0}
  ${valueInt}=  Convert To Integer  ${valueStr}
  Log  ${valueInt}
  [Return]  ${valueInt}

Get Access Tokens Badge Value
  Page Should Contain Element  xpath=//span[@id="atBadge"]
  ${valueStr}=  Get Text  xpath=//span[@id="atBadge"]
  ${valueInt}=  Convert To Integer  ${valueStr}
  Log  ${valueInt}
  [Return]  ${valueInt}

Get Access Tokens Filtered Value
  Page Should Contain Element  xpath=//span[@id="atoken_filtered"]
  ${valueStr}=  Get Text  xpath=//span[@id="atoken_filtered"]
  ${valueInt}=  Convert To Integer  ${valueStr}
  Log  ${valueInt}
  [Return]  ${valueInt}

Get Refresh Tokens Badge Value
  Page Should Contain Element  xpath=//span[@id="rtBadge"]
  ${valueStr}=  Get Text  xpath=//span[@id="rtBadge"]
  ${valueInt}=  Convert To Integer  ${valueStr}
  Log  ${valueInt}
  [Return]  ${valueInt}

Get Refresh Tokens Filtered Value
  Page Should Contain Element  xpath=//span[@id="rtoken_filtered"]
  ${valueStr}=  Get Text  xpath=//span[@id="rtoken_filtered"]
  ${valueInt}=  Convert To Integer  ${valueStr}
  Log  ${valueInt}
  [Return]  ${valueInt}

Access Token Badge Value Should Be  [Arguments]  ${num}
  ${numTokens}=  Get Access Tokens Badge Value
  Should Be Equal  ${numTokens}  ${num}

Refresh Token Badge Value Should Be  [Arguments]  ${num}
  ${numTokens}=  Get Refresh Tokens Badge Value
  Should Be Equal  ${numTokens}  ${num}

Total Token Badge Value Should Be  [Arguments]  ${num}
  ${numTokens}=  Get Total Tokens Badge Value
  Should Be Equal  ${numTokens}  ${num}

Access Token Filtered Value Should Be  [Arguments]  ${num}
  ${numTokens}=  Get Access Tokens Filtered Value
  Should Be Equal  ${numTokens}  ${num}

Refresh Token Filtered Value Should Be  [Arguments]  ${num}
  ${numTokens}=  Get Refresh Tokens Filtered Value
  Should Be Equal  ${numTokens}  ${num}

Refresh Access Tokens List
  Click Button  id=refresh_atoken_list

Refresh Refresh Tokens List
  Click Button  id=refresh_rtoken_list

Access Token List Should Contain Token Value  [Arguments]  ${token_value}
  Page Should Contain Element  xpath=//table[@id="access_token_list"]
  Page Should Contain Element  xpath=//input[@value="${token_value}"]

Access Token List Should Not Contain Token Value  [Arguments]  ${token_value}
  Page Should Not Contain Element  xpath=//input[@value="${token_value}"]
  Page Should Not Contain Element  xpath=//button[@id="revoke_${token_value}"]

Refresh Token List Should Contain Token Value  [Arguments]  ${token_value}
  Page Should Contain Element  xpath=//table[@id="refresh_token_list"]
  Page Should Contain Element  xpath=//input[@value="${token_value}"]

Refresh Token List Should Not Contain Token Value  [Arguments]  ${token_value}
  Page Should Not Contain Element  xpath=//input[@value="${token_value}"]
  Page Should Not Contain Element  xpath=//button[@id="revoke_${token_value}"]

Click Revoke Button Of Token  [Arguments]  ${token_value}
  Page Should Contain Element  xpath=//button[@id="revoke_${token_value}"]
  Click Element  xpath=//button[@id="revoke_${token_value}"]
  Wait For Revoke Modal Dialog

Wait For Revoke Modal Dialog
  Wait Until Page Contains Element  xpath=//div[contains(@class, 'modal-dialog')]

Click First Revoke Button
  Click Element  xpath=//button[starts-with(@id, "revoke_")][1]
  Wait For Revoke Modal Dialog

Revoke Access Token Dialog Confirm Revoke
  Click Button  Revoke Access Token
  Wait until modal overlay disappear

Revoke Refresh Token Dialog Confirm Revoke
  Click Button  Revoke Refresh Token
  Wait until modal overlay disappear

Select Filter  [Arguments]  ${idBtn}  ${idInput}  ${filterText}
  Click Element   id=${idBtn}
  Input Text  id=${idInput}  ${filterText}
  Wait Until Element Is Visible  xpath=//span[contains(@class, 'ui-select-choices-row-inner')]   timeout=0.05
  Click Element   xpath=//div[contains(@class, 'ui-select-choices-row') and contains(@class, 'active')]/span
  Sleep   1s

Select Access Token Client Filter  [Arguments]  ${filterText}
  Select Filter  atok_client_search_btn  atok_client_search  ${filterText}

Select Access Token User Filter  [Arguments]  ${filterText}
  Select Filter  atok_user_search_btn  atok_user_search  ${filterText}

Select Refresh Token Client Filter  [Arguments]  ${filterText}
  Select Filter  rtok_client_search_btn  rtok_client_search  ${filterText}

Select Refresh Token User Filter  [Arguments]  ${filterText}
  Select Filter  rtok_user_search_btn  rtok_user_search  ${filterText}

Navigate To Access Tokens List Page  [Arguments]  ${pageNumber}
  Click Link  xpath=//ul[@id='atoken_pagination_top']//a[text()=${pageNumber}]

Navigate To Refresh Tokens List Page  [Arguments]  ${pageNumber}
  Click Link  xpath=//ul[@id='rtoken_pagination_top']//a[text()=${pageNumber}]

Tokens tests setup
  Login as admin
  Delete All Tokens

Tokens tests teardown
  Delete All Tokens
  Logout from Indigo dashboard