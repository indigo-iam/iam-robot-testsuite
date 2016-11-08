*** Keywords ***
Setup
  Set Window Size  1200  800
  Set Selenium Timeout  ${TIMEOUT}
  Set Selenium Implicit Wait  ${IMPLICIT_WAIT}
  Set Selenium Speed  ${SPEED}
  
Generate capabilities configuration
  ${DESIRED_CAPABILITIES}=  Create Dictionary  acceptSslCerts=True

Go to IAM
  Generate capabilities configuration
  Open Browser  ${IAM_BASE_URL}  browser=${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${DESIRED_CAPABILITIES}
  Setup

Go to Indigo dashboard
  Click Link  link=New Admin Dashboard
  Wait until modal overlay disappear

Click Back to Home
  Click Link  link=Back to Home Page
  
Click button with text  [Arguments]  ${text}
  Click Button  xpath=//button[text()='${text}']

Wait until modal overlay disappear
  Wait Until Page Does Not Contain Element  xpath=//div[@uib-modal-window='modal-window']
  Wait Until Page Does Not Contain Element  xpath=//div[@uib-modal-backdrop='modal-backdrop']

Click menu navigation entry  [Arguments]  ${entry}
  Wait Until Page Contains Element  xpath=//ul[@class='sidebar-menu']/li/a/span[text()='${entry}']
  Wait until modal overlay disappear
  Click Element  xpath=//ul[@class='sidebar-menu']/li/a/span[text()='${entry}']

Go to home page
  Click menu navigation entry  Home
  Wait until modal overlay disappear
  Wait Until Page Contains Element  userprofilepage

Go to users page
  Click menu navigation entry  Users
  Wait until modal overlay disappear
  Wait Until Page Contains  Created

Go to groups page
  Click menu navigation entry  Groups
  Wait until modal overlay disappear
  Wait Until Page Contains  Actions

Go to request management page
  Click menu navigation entry  Requests
  Wait until modal overlay disappear
  Wait Until Page Contains Element  requests-page

Go to user page  [Arguments]  ${name}
  Go to users page
  Find user in users page  ${name}
  Click Element  xpath=//*[@id='userslist']/tbody/tr/td/a[text()='${name}']
  Wait until modal overlay disappear
  Wait Until Page Contains  ${name} - Profile Page

Go to group page  [Arguments]  ${name}
  Go to groups page
  Find group in groups page  ${name}
  Click Element  xpath=//*[@id='groupslist']/tbody/tr/td/a[text()='${name}']
  Wait until modal overlay disappear
  Wait Until Page Contains Element  id=userslist
  Wait Until Page Contains Element   xpath=//*[@id='userslist']/tbody/tr/td[text()='1']
  Table Row Should Contain  userslist  1  test
