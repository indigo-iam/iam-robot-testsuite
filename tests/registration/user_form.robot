*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Force Tags   registration:user

*** Variables ***
${invalid_name}      xx
${invalid_surname}   xx
${invalid_email}     xx
${invalid_username}  xx
${invalid_notes}     ${SPACE}

*** Test Cases ***
Open the modal window
  Open registration form
  [Teardown]  Close registration form

Register button is disabled with empty form
  Open registration form
  Element Should Be Disabled  id=register-submit-btn
  [Teardown]  Close registration form

Register button is disabled with invalid form
  Open registration form
  Input Text  id=name      ${invalid_name}
  Input Text  id=surname   ${invalid_surname}
  Input Text  id=email     ${invalid_email}
  Input Text  id=username  ${invalid_username}
  Input Text  id=notes     ${invalid_notes}
  Element Should Be Disabled  id=register-submit-btn
  [Teardown]  Close registration form

Submit a new registration request
  Open registration form
  Input Text  id=name      Robot
  Input Text  id=surname   Tester
  Input Text  id=email     robot.tester@example.org
  Input Text  id=username  robot
  Input Text  id=notes     Very short notes for the admin
  Wait Until Element Is Enabled  id=register-submit-btn
  Scroll to the bottom of the page
  Click Element  id=register-submit-btn
  Wait Until Page Contains  Request submitted successfully
  Click Link  link=Back to Login Page
  Login as admin
  Go to Indigo dashboard
  Go to users page
  Delete user  Robot Tester
  Logout from Indigo dashboard

Reset button is disabled with empty form
  Open registration form
  Element Should Be Disabled  id=register-reset-btn
  [Teardown]  Close registration form

Reset form
  Open registration form
  Input Text  id=name      Robot
  Input Text  id=surname   Tester
  Input Text  id=email     robot.tester@example.org
  Input Text  id=username  robot
  Input Text  id=notes     Very short notes for the admin
  Element Should Be Enabled  id=register-reset-btn
  Scroll to the bottom of the page
  Click Button  id=register-reset-btn
  Element Text Should Be  id=name      ${EMPTY}
  Element Text Should Be  id=surname   ${EMPTY}
  Element Text Should Be  id=email     ${EMPTY}
  Element Text Should Be  id=username  ${EMPTY}
  Element Text Should Be  id=notes     ${EMPTY}
  [Teardown]  Close registration form

Notes field is mandatory
  Open registration form
  Input Text  id=name      Robot
  Input Text  id=surname   Tester
  Input Text  id=email     robot.tester@example.org
  Input Text  id=username  robot
  Element Should Be Disabled  id=register-submit-btn
  [Teardown]  Close registration form
  
Blank notes are not allowed
  Open registration form
  Input Text  id=name      Robot
  Input Text  id=surname   Tester
  Input Text  id=email     robot.tester@example.org
  Input Text  id=username  robot
  Input Text  id=notes     ${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}
  Element Should Be Disabled  id=register-submit-btn
  [Teardown]  Close registration form
