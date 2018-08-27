*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Login as test user
Test Teardown  Logout From Dashboard

Force Tags   home:edit-user-info

*** Variables ***
${TEST_USERNAME}                  test_100
${TEST_PASSWORD}                  password
${TEST_USER_GIVENNAME}            Test-100
${TEST_USER_FAMILYNAME}           User
${TEST_USER_EMAIL}                test-100@test.org
${TEST_NEWGIVENNAME_INVALID}      Jo
${TEST_NEWGIVENNAME}              John
${TEST_NEWFAMILYNAME_INVALID}     Ke
${TEST_NEWFAMILYNAME}             Kennedy
${TEST_NEWEMAIL_INVALID}          john.kennedy@
${TEST_NEWEMAIL_ANOTHERUSER}      test@iam.test
${TEST_NEWEMAIL}                  john.kennedy@gov.us
${TEST_NEWPICTURE_INVALID}        not_a_URL
${TEST_NEWPICTURE}                https://www.isecur1ty.org/wp-content/uploads/2014/12/pen2.png

*** Test Cases ***

Edit Given Name
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_NEWGIVENNAME_INVALID}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Given Name  ${TEST_NEWGIVENNAME}
  Click Update Button
  Wait Until Page Contains  ${TEST_NEWGIVENNAME}
  Open edit user dialog  ${TEST_NEWGIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME}

Edit Family Name
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Family Name  ${TEST_NEWFAMILYNAME_INVALID}
  Wait Until Page Contains  Minimum length required is 3
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Family Name  ${TEST_NEWFAMILYNAME}
  Click Update Button
  Wait Until Page Contains  ${TEST_NEWFAMILYNAME}
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_NEWFAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Family Name  ${TEST_USER_FAMILYNAME}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_FAMILYNAME}

Edit Email
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_NEWEMAIL_INVALID}
  Wait Until Page Contains  This is not a valid email
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_NEWEMAIL_ANOTHERUSER}
  Wait Until Page Contains  Email already taken by another user
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_NEWEMAIL}
  Click Update Button
  Wait Until Page Contains  ${TEST_NEWEMAIL}
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Email  ${TEST_USER_EMAIL}
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_EMAIL}

Edit Picture
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Picture  ${TEST_NEWPICTURE_INVALID}
  Wait Image Check Failure  This field is invalid
  Wait Image Check Failure  This field is not a valid URL
  Element Should Be Disabled  id=modal-btn-confirm
  Click Button  Reset Form
  Input Picture  ${TEST_NEWPICTURE}
  Click Update Button
  Page Should Contain Image  ${TEST_NEWPICTURE}

Edit All Info
  Open edit user dialog  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_NEWGIVENNAME}
  Input Family Name  ${TEST_NEWFAMILYNAME}
  Input Email  ${TEST_NEWEMAIL}
  Input Picture  ${TEST_NEWPICTURE}
  Click Update Button
  Wait Until Page Contains  ${TEST_NEWGIVENNAME} ${TEST_NEWFAMILYNAME}
  Wait Until Page Contains  ${TEST_NEWEMAIL}
  Wait Until Page Contains  ${TEST_NEWPICTURE}
  Open edit user dialog  ${TEST_NEWGIVENNAME} ${TEST_NEWFAMILYNAME}
  Wait Until Element Is Disabled  modal-btn-confirm
  Input Given Name  ${TEST_USER_GIVENNAME}
  Input Family Name  ${TEST_USER_FAMILYNAME}
  Input Email  ${TEST_USER_EMAIL}
  Input Picture  ${EMPTY}
  Wait Image Check Success
  Click Update Button
  Wait Until Page Contains  ${TEST_USER_GIVENNAME} ${TEST_USER_FAMILYNAME}
  Wait Until Page Contains  ${TEST_USER_EMAIL}

*** Keywords ***

Login as test user
  Login as user  ${TEST_USERNAME}  ${TEST_PASSWORD}

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