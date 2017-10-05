*** Variables ***

${password_grant}            password
${client_credentials_grant}  client_credentials
${token_exchange_grant}      urn:ietf:params:oauth:grant-type:token-exchange

*** Keywords ***

Perform token request  [Arguments]  ${token_endpoint}  ${user}  ${passwd}  &{request_data}
  Log Dictionary  ${request_data}
  ${items}=  Get Dictionary Items  ${request_data}
  ${data_options}=  Set Variable  ${EMPTY}
  :FOR  ${key}  ${value}  IN  @{items} 
  \  ${data_options}=  catenate  ${data_options} -d  ${key}=${value}
  ${cmd}=  Set Variable  curl -sk -u ${user}:${passwd} ${data_options} ${token_endpoint}
  ${rc}  ${output}=  Run and Return RC And Output  ${cmd}
  Should Be Equal As Integers  ${rc}  0  ${cmd} failed with ${output}  False
  Should Not Contain  ${output}  "error"
  [Return]  ${output}

Get token with client credentials flow  [Arguments]  ${client_id}  ${client_secret}  ${scopes}
  &{data}=  Create Dictionary  
  ...  grant_type=${client_credentials_grant}
  ...  scope="${scopes}"
  ${result}=  Perform token request  ${IAM_TOKEN_ENDPOINT}  ${client_id}  ${client_secret}  &{data}
  Log  ${result}
  ${parsedResult}=  Parse Json  ${result}
  Log  ${parsedResult}
  [Return]  ${parsedResult}

Get token with resource owner flow  [Arguments]  ${client_id}  ${client_secret}  ${username}  ${password}  ${scopes}
  &{data}=  Create Dictionary  
  ...  grant_type=${password_grant}
  ...  scope="${scopes}"
  ...  username="${username}"
  ...  password="${password}"
  ${result}=  Perform token request  ${IAM_TOKEN_ENDPOINT}  ${client_id}  ${client_secret}  &{data}
  Log  ${result}
  ${parsedResult}=  Parse Json  ${result}
  Log  ${parsedResult}
  [Return]  ${parsedResult}