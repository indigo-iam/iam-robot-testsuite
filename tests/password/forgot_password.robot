*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Force Tags   password

*** Test Cases ***
Open change password modal
  Click Link  link=Forgot your password?
  Wait Until Page Contains  Please enter your IAM account email address
  Click Button  name=dismiss

Submit change password request
  Click Link  link=Forgot your password?
  Wait Until Page Contains  Please enter your IAM account email address
  Input text  id=email  tester@example.it
  Click Button  Submit
  Wait Until Page Contains  Done!
  Click Button  name=dismiss