*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Teardown  Logout from Indigo dashboard

*** Test Cases ***
Empty page shows info message
  Go to request management page
  Wait Until Page Contains  No pending requests found!

Approve registration request
  Register user  UserApproved  UserApproved  user.approved@example.it  userapproved
  Go to request management page
  Wait Until Page Contains  UserApproved adds a registration request
  Click Button  name=btn_approve
  Wait Until Page Contains  approved successfully
  
Reject registration request
  Register user  UserRejected  UserRejected  user.rejected@example.it  userrejected
  Go to request management page
  Wait Until Page Contains  UserRejected adds a registration request
  Click Button  name=btn_reject
  Wait Until Page Contains  Reject?
  Click button with text  Reject Request
  Wait Until Page Contains  rejected successfully
  Wait until modal overlay disappear
  
Cancel reject decision
  Register user  UserNotRejected  UserNotRejected  user.not.rejected@example.it  usernotrejected
  Go to request management page
  Wait Until Page Contains  UserNotRejected adds a registration request
  Click Button  name=btn_reject
  Wait Until Page Contains  Reject?
  Click button with text  Cancel
  Wait Until Page Contains  UserNotRejected adds a registration request
  Wait until modal overlay disappear

  