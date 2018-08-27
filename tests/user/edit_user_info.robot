*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Init and go to test user home
Test Teardown  Logout From Dashboard

Force tags   user:user-info

*** Variables ***
${TEST_USER_GIVENNAME}     Dexter
${TEST_USER_FAMILYNAME}    Morgan
${TEST_USER_EMAIL}         dexter.morgan@miami.us
${TEST_USER_USERNAME}      dexter.morgan@miami.us

${TEST_USER_GIVENNAME_MINERROR}  JJ
${TEST_USER_GIVENNAME_MAXERROR}  abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz
${TEST_USER_GIVENNAME_INVALID}   <name>
${TEST_USER_GIVENNAME_MOD}       John

${TEST_USER_FAMILYNAME_MINERROR}  JJ
${TEST_USER_FAMILYNAME_MAXERROR}  abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz
${TEST_USER_FAMILYNAME_INVALID}   <name>
${TEST_USER_FAMILYNAME_MOD}      Lennon

${TEST_USER_EMAIL_INVALID}       thisisnotamail
${TEST_USER_EMAIL_INUSE}         test@iam.test
${TEST_USER_EMAIL_MOD}           john.lennon@liverpool.uk

${TEST_USER_USERNAME_INVALID}    JJ
${TEST_USER_USERNAME_INUSE}      test
${TEST_USER_USERNAME_MOD}        john.lennon

${TEST_USER_PICTURE_INVALID}     thisisnotanurl
${TEST_USER_PICTURE_MOD}         https://www.isecur1ty.org/wp-content/uploads/2014/12/pen2.png

*** Test Cases ***

Edit all user's info
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME_MOD}
  Input Family Name  ${TEST_USER_FAMILYNAME_MOD}
  Input Email  ${TEST_USER_EMAIL_MOD}
  Input Username  ${TEST_USER_USERNAME_MOD}
  Input Picture  ${TEST_USER_PICTURE_MOD}
  Wait Image Check Success
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME_MOD}
  Wait Until Page Contains  ${TEST_USER_USERNAME_MOD}
  Wait Until Page Contains  ${TEST_USER_EMAIL_MOD}
  Remove test user  ${TEST_USER_GIVENNAME_MOD}  ${TEST_USER_FAMILYNAME_MOD}

Edit user's name
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME_MINERROR}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Given Name  ${TEST_USER_GIVENNAME_MAXERROR}
  Wait Until Page Contains  Maximum length is 64
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Given Name  ${TEST_USER_GIVENNAME_INVALID}
  Wait Until Page Contains  Invalid characters
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Given Name  ${TEST_USER_GIVENNAME_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME}
  Remove test user  ${TEST_USER_GIVENNAME_MOD}  ${TEST_USER_FAMILYNAME}

Edit user's family name
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Family Name  ${TEST_USER_FAMILYNAME_MINERROR}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Family Name  ${TEST_USER_FAMILYNAME_MAXERROR}
  Wait Until Page Contains  Maximum length is 64
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Family Name  ${TEST_USER_FAMILYNAME_INVALID}
  Wait Until Page Contains  Invalid characters
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Family Name  ${TEST_USER_FAMILYNAME_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME_MOD}
  Remove test user  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME_MOD}

Edit user's email
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_USER_EMAIL_INVALID}
  Wait Until Page Contains  This is not a valid email
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_USER_EMAIL_INUSE}
  Wait Until Page Contains  Email already taken by another user
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_USER_EMAIL_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_EMAIL_MOD}
  Remove test user

Edit user's username
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Username  ${TEST_USER_USERNAME_INVALID}
  Wait Until Page Contains  Minimum length required is 3
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Username  ${TEST_USER_USERNAME_INUSE}
  Wait Until Page Contains  Username already in use
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Username  ${TEST_USER_USERNAME_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_USERNAME_MOD}
  Remove test user

Edit user's picture
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Picture  ${TEST_USER_PICTURE_INVALID}
  Wait Image Check Failure  This field is not a valid image
  Element Should Be Disabled  id=modal-btn-confirm
  Page Should Not Contain  id=picture_preview
  Click Button  Reset Form
  Input Picture  ${TEST_USER_PICTURE_MOD}
  Wait Image Check Success
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Page Should Contain Image  ${TEST_USER_PICTURE_MOD}
  Remove test user

*** Keywords ***

Init and go to test user home
  Login as admin
  Go to Indigo dashboard
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}

Remove test user  [Arguments]  ${givenName}=${TEST_USER_GIVENNAME}  ${familyName}=${TEST_USER_FAMILYNAME}
  Go to users page
  Delete user  ${givenName} ${familyName}

Wait Until Element Is Disabled  [Arguments]  ${id}
  Wait For Condition  return document.getElementById("${id}").getAttribute("disabled") == 'disabled' 

Logout from dashboard
  Logout from Indigo dashboard

Wait Image Check Failure  [Arguments]  ${errorMessage}
  Wait Until Page Contains  ${errorMessage}

Wait Image Check Success
  Wait Until Page Contains Element  xpath=//*[@id='picture_preview']
  Page Should Contain Image  xpath=//*[@id='picture_preview']

Input Given Name  [Arguments]  ${givenname}
  Input Text  id=name  ${givenname}

Input Family Name  [Arguments]  ${familyname}
  Input Text  id=surname  ${familyname}

Input Picture  [Arguments]  ${pictureURL}
  Input Text  id=picture  ${pictureURL}

Input Email  [Arguments]  ${email}
  Input Text  id=email  ${email}

Input Username  [Arguments]  ${username}
  Input Text  id=username  ${username}

Click Update Button
  Wait Until ELement Is Enabled  id=modal-btn-confirm
  Click Element  id=modal-btn-confirm
  Wait until modal overlay disappear