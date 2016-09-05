*** Keywords ***
Go to IAM
  Open Browser  ${IAM_BASE_URL}  browser=${BROWSER}
  Set Window Size  1200  800
  Set Selenium Timeout  10
  
Click Back to Home
  Click Link  link=Back to Home Page