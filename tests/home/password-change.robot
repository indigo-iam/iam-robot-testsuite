*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Force Tags   home:password-change

*** Variables ***
${TEST_USERNAME}          test
${TEST_PASSWORD}          password
${TEST_NEWPASSWORD}       newpassword

*** Test Cases ***

Change password logout and login
  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
  Open change password dialog
  Compile form  ${TEST_PASSWORD}  ${TEST_NEWPASSWORD}  ${TEST_NEWPASSWORD}
  Check no invalid errors
  Submit form
  Wait until modal overlay disappear
  Logout from Indigo dashboard
  Login as user  ${TEST_USERNAME}  ${TEST_NEWPASSWORD}
  Open change password dialog
  Compile form  ${TEST_NEWPASSWORD}  ${TEST_PASSWORD}  ${TEST_PASSWORD}
  Check no invalid errors
  Submit form
  Wait until modal overlay disappear
  Logout from Indigo dashboard

Wrong password provided
  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
  Open change password dialog
  Compile form  wrongPassword  ${TEST_NEWPASSWORD}  ${TEST_NEWPASSWORD}
  Check no invalid errors
  Submit form
  Wait Until Page Contains  Wrong password provided
  Dismiss form
  Logout from Indigo dashboard

Minimum length required for new password
  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
  Open change password dialog
  Compile form  ${TEST_PASSWORD}  XXX  XXX
  Check minlength is required
  Reset Form
  Dismiss form
  Logout from Indigo dashboard

Confirm password not match
  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}
  Open change password dialog
  Compile form  ${TEST_PASSWORD}  ${TEST_NEWPASSWORD}  ${TEST_NEWPASSWORD}XXX
  Check confirm password matching is required
  Reset Form
  Dismiss form
  Logout from Indigo dashboard

*** Keywords ***

Check no invalid errors
  Wait Until Element Is Enabled  id=modal-btn-confirm

Check minlength is required
  Wait Until Page Contains  Minimum length required is

Check confirm password matching is required
  Wait Until Page Contains  Must match the previous entry

Reset Form
  Click Element  id=modal-btn-reset
  Wait Until Element Is Disabled  modal-btn-confirm

Submit form
  Click Element  id=modal-btn-confirm

Dismiss form
  Click Element  id=modal-btn-cancel
  Wait until modal overlay disappear

Compile form  [Arguments]  ${oldPassword}  ${newPassword}  ${confirmedPassword}
  Input Current Password  ${oldPassword}
  Input New Password  ${newPassword}
  Input Confirmed Password  ${confirmedPassword}