*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers


*** Test Cases ***
Open change password modal
  Click Link  link=Forgot your password?
  Wait Until Page Contains  Please enter the email address for your IAM account.
  Click Button  name=dismiss

Submit change password request
  Click Link  link=Forgot your password?
  Wait Until Page Contains  Please enter the email address for your IAM account.
  Input text  id=email  tester@example.it
  Click Element  xpath=//input[@value='Send']
  Wait Until Page Contains  Done!
  Click Button  name=dismiss