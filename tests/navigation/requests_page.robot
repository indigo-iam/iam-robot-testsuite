*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Navigation Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   navigation:requests

*** Keywords ***

Navigation Tests setup
  Login as admin
  Go to Indigo dashboard

*** Test Cases ***

Empty page shows info message
  Go to request management page
  Wait Until Page Contains  No pending requests found.

Empty page hide pagination bar
  Go to request management page
  Element Should Not Be Visible  xpath=//ul[@uib-pagination='']