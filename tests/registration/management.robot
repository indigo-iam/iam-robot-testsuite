*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers


*** Test Cases ***
Approve registration request
  Register user  UserApproved  UserApproved  user.approved@example.it  userapproved
  Login as admin
  Click Link  link=Registration Requests Management
  Wait Until Page Contains  List of Pending Requests
  Wait Until Page Contains  UserApproved adds a registration request
  Click Button  name=btn_approve
  Wait Until Page Contains  Approvation success
  [Teardown]  Run Keywords  
  ...         Click Back to Home  AND
  ...         Logout
  
Reject registration request
  Register user  UserRejected  UserRejected  user.rejected@example.it  userrejected
  Login as admin
  Click Link  link=Registration Requests Management
  Wait Until Page Contains  List of Pending Requests
  Wait Until Page Contains  UserRejected adds a registration request
  Click Button  name=btn_reject
  Wait Until Page Contains  Rejection success
  [Teardown]  Run Keywords  
  ...         Click Back to Home  AND
  ...         Logout
