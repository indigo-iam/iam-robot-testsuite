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

Filter Access Tokens By Client
  Go to access tokens page
  ${token}=  Get token with client credentials flow  client-cred  secret  openid profile
  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile
  Refresh Access Tokens List
  Access Token Badge Value Should Be  ${3}
  Select Access Token Client Filter  client-cred
  Access Token Badge Value Should Be  ${3}
  Access Token Filtered Value Should Be  ${1}
  Access Token List Should Contain Token Value  ${token["access_token"]}

Filter Access Tokens By User
  Go to access tokens page
  Get token with client credentials flow  client-cred  secret  openid profile
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile
  Refresh Access Tokens List
  Access Token Badge Value Should Be  ${3}
  Select Access Token User Filter  admin
  Access Token Badge Value Should Be  ${3}
  Access Token Filtered Value Should Be  ${2}
  Access Token List Should Contain Token Value  ${token["access_token"]}

Filter Refresh Tokens By Client
  Go to refresh tokens page
  Get token with resource owner flow  token-exchange-subject  secret  test  password  openid profile offline_access
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  Refresh Refresh Tokens List
  Refresh Token Badge Value Should Be  ${2}
  Access Token Badge Value Should Be  ${4}
  Select Refresh Token Client Filter  token-exchange-actor
  Refresh Token Badge Value Should Be  ${2}
  Refresh Token Filtered Value Should Be  ${1}
  Refresh Token List Should Contain Token Value  ${token["refresh_token"]}

Filter Refresh Tokens By User
  Go to refresh tokens page
  Get token with resource owner flow  token-exchange-subject  secret  test  password  openid profile offline_access
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  Refresh Refresh Tokens List
  Access Token Badge Value Should Be  ${4}
  Refresh Token Badge Value Should Be  ${2}
  Select Refresh Token User Filter  admin
  Refresh Token Badge Value Should Be  ${2}
  Refresh Token Filtered Value Should Be  ${1}
  Refresh Token List Should Contain Token Value  ${token["refresh_token"]}