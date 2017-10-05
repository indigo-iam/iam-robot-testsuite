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

Revoke Access Token
  ${token}=  Get token with client credentials flow  client-cred  secret  openid profile
  Go to access tokens page
  Access Token Badge Value Should Be  ${1}
  Total Token Badge Value Should Be  ${1}
  Access Token List Should Contain Token Value  ${token["access_token"]}
  Click Revoke Button Of Token  ${token["access_token"]}
  Revoke Access Token Dialog Confirm Revoke
  Access Token List Should Not Contain Token Value  ${token["access_token"]}
  Access Token Badge Value Should Be  ${0}
  Total Token Badge Value Should Be  ${0}

Revoke Refresh Token
  ${token}=  Get token with resource owner flow  token-exchange-actor  secret  admin  password  openid profile offline_access
  Go to refresh tokens page
  Refresh Token Badge Value Should Be  ${1}
  Access Token Badge Value Should Be  ${2}
  Total Token Badge Value Should Be  ${3}
  Refresh Token List Should Contain Token Value  ${token["refresh_token"]}
  Click Revoke Button Of Token  ${token["refresh_token"]}
  Revoke Refresh Token Dialog Confirm Revoke
  Refresh Token Badge Value Should Be  ${0}
  Access Token Badge Value Should Be  ${2}
  Total Token Badge Value Should Be  ${2}