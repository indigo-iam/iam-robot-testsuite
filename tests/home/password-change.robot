*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
Test Teardown  Logout from Indigo dashboard

*** Variables ***
${TEST_USERNAME}          test
${TEST_PASSWORD}          password
${TEST_NEWPASSWORD}       newpassword

*** Test Cases ***

Change password logout and login
  View Profile Information
  Change user password  ${TEST_PASSWORD}  ${TEST_NEWPASSWORD}
  Logout from Indigo dashboard
  Login as user  ${TEST_USERNAME}  ${TEST_NEWPASSWORD}
  View Profile Information
  Change user password  ${TEST_NEWPASSWORD}  ${TEST_PASSWORD}

*** Keywords ***

Change user password  [Arguments]  ${oldPassword}  ${newPassword}
  Open change password dialog
  Input Current Password  ${oldPassword}
  Input New Password  ${newPassword}
  Input Confirmed Password  ${newPassword}
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear