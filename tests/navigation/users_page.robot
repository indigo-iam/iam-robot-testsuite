*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Users Page Navigation Tests setup
Test Teardown  Logout from Indigo dashboard

Force Tags   navigation:users

*** Variables ***

*** Keywords ***

Users Page Navigation Tests setup
  Login as admin
  Go to Indigo dashboard
  Go to users page

*** Test Cases ***

Open And Close Add User Dialog In Users Page
  Open Add User Dialog
  Close Add User Dialog