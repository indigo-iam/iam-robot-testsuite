*** Keywords ***
Setup
  Set Window Size  1200  1000
  Set Selenium Timeout  ${TIMEOUT}
  Set Selenium Implicit Wait  ${IMPLICIT_WAIT}
  Set Selenium Speed  ${SPEED}
  
Generate capabilities configuration
  ${DESIRED_CAPABILITIES}=  Create Dictionary  acceptSslCerts=True

Setup Browser  [Arguments]  ${url}=${IAM_BASE_URL}
  Close All Browsers
  Generate capabilities configuration
  Open Browser  ${url}  browser=${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${DESIRED_CAPABILITIES}
  Delete All Cookies
  Setup
  
Go to IAM
  Generate capabilities configuration
  Open Browser  ${IAM_BASE_URL}  browser=${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${DESIRED_CAPABILITIES}
  Setup

Go to IAM test client
  Setup Browser  ${IAM_TEST_CLIENT_URL}
  Go To   ${IAM_TEST_CLIENT_URL}
  ${url}=  Get Location
  Log  ${url}

Go to Indigo dashboard
  No Operation

View Profile Information
  Click Link  link=View Profile Information
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
  Wait Until Page Contains Element  id=userprofilepage

Go to group page  [Arguments]  ${name}
  Go to groups page
  Find group in groups page  ${name}
  Click Element  xpath=//*[@id='groupslist']/tbody/tr/td/a[text()='${name}']
  Wait until modal overlay disappear
  Wait Until Page Contains  Members

Go to tokens page
  Go to access tokens page

Go to access tokens page
  Click menu navigation entry  Tokens
  Wait Until Page Contains Element  id=refresh_atoken_list

Go to refresh tokens page
  Go to access tokens page
  Click Element  tabRefreshTokens
  Wait Until Page Contains Element  id=refresh_rtoken_list

Wait Until Element Is Disabled  [Arguments]  ${id}
  Wait For Condition  return document.getElementById("${id}").getAttribute("disabled") == 'disabled' 

Focus And Click Element   [Arguments]   ${locator}
  Focus   ${locator}
  Click Element   ${locator}

Scroll to the bottom of the page
  Execute Javascript   window.scrollTo(0, 2000)
