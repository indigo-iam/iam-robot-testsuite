*** Keywords ***
Setup
  Set Window Size  1200  800
  Set Selenium Timeout  10
  Set Selenium Speed  ${SPEED}

Go to IAM
  Open Browser  ${IAM_BASE_URL}  browser=${BROWSER}  remote_url=${REMOTE_URL}
  Setup

Go to Indigo dashboard
  Click Link  link=New Admin Dashboard

Click Back to Home
  Click Link  link=Back to Home Page
  
Click button with text  [Arguments]  ${text}
  Click Button  xpath=//button[text()='${text}']
  
Click menu navigation entry  [Arguments]  ${entry}
  Wait Until Page Contains  IAM
  Click Element  xpath=//ul[@class='sidebar-menu']/li/a/span[text()='${entry}']
  
Wait until modal overlay disappear
  Wait Until Page Does Not Contain Element  xpath=//div[@uib-modal-window='modal-window']
  Wait Until Page Does Not Contain Element  xpath=//div[@uib-modal-backdrop='modal-backdrop']
