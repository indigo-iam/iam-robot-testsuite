*** Settings ***
Resource  lib/utils.robot

Force Tags   test-client

*** Variables ***

${password_grant}            password
${client_credentials_grant}  client_credentials
${token_exchange_grant}      urn:ietf:params:oauth:grant-type:token-exchange

*** Keywords ***
Go to IAM test client
  Go to IAM
  Go to  ${IAM_TEST_CLIENT_URL}
  
Approve IAM test client
  ${count}=  Get Matching Xpath Count  //form[@name='confirmationForm']
  Run Keyword If  ${count}==1  Click element  name=authorize
  
Login into IAM  [Arguments]  ${username}=${ADMIN_USER}  ${password}=${ADMIN_PASSWORD}
  Wait Until Page Contains Element  id=username
  Input username  ${username}
  Wait Until Page Contains Element  id=password
  Input password  ${password}
  Click Element  xpath=//input[@value='Login']

Perform request  [Arguments]  ${token_endpoint}  ${user}  ${passwd}  &{request_data}
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

*** Test Cases ***

Login with test client
  Go to IAM test client
  Wait Until Page Contains Element  link=Log in with INDIGO IAM
  Click link  link=Log in with INDIGO IAM
  Wait Until Page Contains Element  id=username
  Wait Until Page Contains Element  id=password
  Login into IAM  ${ADMIN_USER}  ${ADMIN_PASSWORD}
  Approve IAM test client
  Wait Until Page Contains  You're now logged in as: Admin User
  Click Button  xpath=//button[text()='Logout']
  [Teardown]  Close All Browsers


Get token with client credentials flow
  [Tags]  token
  &{data}=  Create Dictionary  
  ...  grant_type=${client_credentials_grant}
  ...  scope="openid profile offline_access"
  ${result}=  Perform token request  ${IAM_TOKEN_ENDPOINT}  ${CLIENT_ID}  ${CLIENT_SECRET}  &{data}


Get token with resource owner flow
  [Tags]  token
  &{data}=  Create Dictionary  
  ...  grant_type=${password_grant}
  ...  username=${ADMIN_USER}
  ...  password=${ADMIN_PASSWORD}
  ...  scope="openid profile offline_access"
  ${result}=  Perform token request  ${IAM_TOKEN_ENDPOINT}  ${CLIENT_ID}  ${CLIENT_SECRET}  &{data}
  

Get token with token exchange flow
  [Tags]  token
  &{data}=  Create Dictionary  
  ...  grant_type=${password_grant}
  ...  username=${ADMIN_USER}
  ...  password=${ADMIN_PASSWORD}
  ...  scope="openid profile offline_access"
  ${result}=  Perform token request  ${IAM_TOKEN_ENDPOINT}  ${CLIENT_ID}  ${CLIENT_SECRET}  &{data}
  ${access_token}=  Get Json Value  ${result}  /access_token
  &{data}=  Create Dictionary  
  ...  grant_type=${token_exchange_grant}
  ...  audience=http://foo.bar.example
  ...  subject_token=${access_token}
  ...  scope="openid profile offline_access"
  ${result}=  Perform request  ${IAM_TOKEN_ENDPOINT}  ${TOKEN_EXCHANGE_CLIENT_ID}  ${TOKEN_EXCHANGE_CLIENT_SECRET}  &{data}