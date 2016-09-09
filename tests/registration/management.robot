*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Teardown  Logout from Indigo dashboard

*** Test Cases ***
Empty page shows info message
  Go to request management page
  Wait Until Page Contains  No pending requests found!

Empty page hide pagination bar
  Go to request management page
  Element Should Not Be Visible  xpath=//ul[@uib-pagination='']

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

Pagination
  :FOR  ${index}  IN RANGE  1  21 
  \  Register user  User${index}  Tester${index}  user.tester.${index}@example.it  usertester${index}
  Go to request management page
  Page Should Contain Element  xpath=//ul[@uib-pagination='']
  Page Should Contain Link  link=1
  Page Should Contain Link  link=2
  Pagination button should be disabled  First
  Pagination button should be disabled  Previous
  Pagination button should be enabled  Next
  Pagination button should be enabled  Last
  Page Should Contain  User1 Tester1 adds a registration request
  Click Element  link=2
  Page Should Contain  User11 Tester11 adds a registration request
  Click Element  link=Last
  Pagination button should be enabled  First
  Pagination button should be enabled  Previous
  Pagination button should be disabled  Next
  Pagination button should be disabled  Last
  
  
*** Keyword ***
Pagination button should be disabled  [Arguments]  ${text}
  ${result}=  Get Element Attribute  xpath=//li[./a[text()='${text}']]@class
  Should Contain  ${result}  disabled
  
Pagination button should be enabled  [Arguments]  ${text}
  ${result}=  Get Element Attribute  xpath=//li[./a[text()='${text}']]@class
  Should Not Contain  ${result}  disabled
