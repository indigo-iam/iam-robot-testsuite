*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Teardown  Logout from Indigo dashboard

*** Test Cases ***

Approve registration request
  Register user  UserApproved  UserApproved  user.approved@example.it  userapproved
  Login as admin
  Go to Indigo dashboard
  Go to request management page
  Requests table contains row with user  UserApproved UserApproved
  Click Button  name=btn_approve
  Wait Until Page Contains  request APPROVED successfully
  Go to users page
  Delete user  UserApproved UserApproved
  
Reject registration request
  Register user  UserRejected  UserRejected  user.rejected@example.it  userrejected
  Login as admin
  Go to Indigo dashboard
  Go to request management page
  Requests table contains row with user  UserRejected UserRejected
  Click Button  name=btn_reject
  Wait Until Page Contains  Reject «UserRejected UserRejected» registration request
  Click button with text  Reject Registration Request
  Wait Until Page Contains  request REJECTED successfully
  Wait until modal overlay disappear
  Go to users page
  Delete user  UserRejected UserRejected

Cancel reject decision
  Register user  UserNotRejected  UserNotRejected  user.not.rejected@example.it  usernotrejected
  Login as admin
  Go to Indigo dashboard
  Go to request management page
  Requests table contains row with user  UserNotRejected UserNotRejected
  Click Button  name=btn_reject
  Wait Until Page Contains  Reject «UserNotRejected UserNotRejected» registration request
  Click button with text  Cancel
  Wait until modal overlay disappear
  Requests table contains row with user  UserNotRejected UserNotRejected
  Go to users page
  Delete user  UserNotRejected UserNotRejected

Pagination
  :FOR  ${index}  IN RANGE  01  21 
  \  Register user  User${index}  Tester${index}  user.tester.${index}@example.it  usertester${index}
  Login as admin
  Go to Indigo dashboard
  Go to request management page
  Page Should Contain Element  xpath=//ul[@uib-pagination='']
  Page Should Contain Link  link=1
  Page Should Contain Link  link=2
  Pagination button should be disabled  First
  Pagination button should be disabled  Previous
  Pagination button should be enabled  Next
  Pagination button should be enabled  Last
  Requests table contains row with user  User20 Tester20
  Click Element  link=2
  Requests table contains row with user  User10 Tester10
  Click Element  link=Last
  Pagination button should be enabled  First
  Pagination button should be enabled  Previous
  Pagination button should be disabled  Next
  Pagination button should be disabled  Last
  Go to users page
  :FOR  ${index}  IN RANGE  01  21
  \  Delete user  User${index} Tester${index}

*** Keyword ***

Pagination button should be disabled  [Arguments]  ${text}
  ${result}=  Get Element Attribute  xpath=//li[./a[text()='${text}']]@class
  Should Contain  ${result}  disabled
  
Pagination button should be enabled  [Arguments]  ${text}
  ${result}=  Get Element Attribute  xpath=//li[./a[text()='${text}']]@class
  Should Not Contain  ${result}  disabled
  
Requests table contains row with user  [Arguments]  ${user}
  Wait Until Page Contains Element  xpath=//table[@id='requestslist']/tbody/tr/td/a/strong[text()[normalize-space()='${user}']]
