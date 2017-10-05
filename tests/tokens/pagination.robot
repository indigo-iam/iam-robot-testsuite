*** Settings ***

Resource  lib/utils.robot
Suite Setup  Go to IAM
Suite Teardown  Close All Browsers
Test Setup  Tokens tests setup
Test Teardown  Tokens tests teardown

*** Variables ***

*** Keywords ***

Tokens tests setup
  Login as admin
  Clear All Tokens

Tokens tests teardown
  Clear All Tokens
  Logout from Indigo dashboard

*** Test Cases ***

Find Access Token Not In First Page
  Go to access tokens page
  :FOR    ${i}    IN RANGE    8
  \    Get token with resource owner flow  token-exchange-subject  secret  test  password  openid profile offline_access
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  Refresh Access Tokens List
  Access Token List Should Not Contain Token Value  ${token["access_token"]}
  Navigate To Access Tokens List Page  ${2}
  Access Token List Should Contain Token Value  ${token["access_token"]}

Find Refresh Token Not In First Page
  Go to refresh tokens page
  :FOR    ${i}    IN RANGE    10
  \    Get token with resource owner flow  token-exchange-subject  secret  test  password  openid profile offline_access
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  Refresh Refresh Tokens List
  Refresh Token List Should Not Contain Token Value  ${token["refresh_token"]}
  Navigate To Refresh Tokens List Page  ${2}
  Refresh Token List Should Contain Token Value  ${token["refresh_token"]}