*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Login as admin and go to dashboard
Test Teardown  Logout From Dashboard

*** Variables ***
${TEST_USER_GIVENNAME}     Dexter
${TEST_USER_FAMILYNAME}    Morgan
${TEST_USER_EMAIL}         dexter.morgan@miami.us
${TEST_USER_USERNAME}      dexter.morgan@miami.us

${TEST_USER_GIVENNAME_INVALID}   JJ
${TEST_USER_GIVENNAME_MOD}       John
${TEST_USER_FAMILYNAME_INVALID}  LL
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
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME_MOD}
  Input Family Name  ${TEST_USER_FAMILYNAME_MOD}
  Input Email  ${TEST_USER_EMAIL_MOD}
  Input Username  ${TEST_USER_USERNAME_MOD}
  Input Picture  ${TEST_USER_PICTURE_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME_MOD}
  Wait Until Page Contains  ${TEST_USER_USERNAME_MOD}
  Wait Until Page Contains  ${TEST_USER_EMAIL_MOD}
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME_MOD}

Edit user's name
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME_INVALID}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Given Name  ${TEST_USER_GIVENNAME_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME}
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME_MOD} ${TEST_USER_FAMILYNAME}

Edit user's family name
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Family Name  ${TEST_USER_FAMILYNAME_INVALID}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Family Name  ${TEST_USER_FAMILYNAME_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME_MOD}
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME_MOD}

Edit user's email
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
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
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}

Edit user's username
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
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
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}

Edit user's picture
  Go to users page
  Create User  ${TEST_USER_GIVENNAME}  ${TEST_USER_FAMILYNAME}  ${TEST_USER_EMAIL}  ${TEST_USER_USERNAME}
  Go to user page  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Open edit user dialog
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Picture  ${TEST_USER_PICTURE_INVALID}
  Wait Until Page Contains  This field is invalid
  Wait Until Page Contains  This field is not a valid URL
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Picture  ${TEST_USER_PICTURE_MOD}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Page Should Contain Image  ${TEST_USER_PICTURE_MOD}
  Go to users page
  Delete user  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}

*** Keywords ***

Login as admin and go to dashboard
  Login as admin
  Go to Indigo dashboard

Wait Until Element Is Disabled  [Arguments]  ${id}
  Wait For Condition  return document.getElementById("${id}").getAttribute("disabled") == 'disabled' 

Logout from dashboard
  Logout from Indigo dashboard

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