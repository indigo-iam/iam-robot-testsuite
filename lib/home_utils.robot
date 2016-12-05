*** Keywords ***

Open change password dialog  [Arguments]
  Click Button  name=change-password-btn
  Wait Until Page Contains  Confirm Password

Close change password dialog
  Click Element  name=dismiss
  Wait until modal overlay disappear

Input Current Password  [Arguments]  ${password}
  Input Text  name=currentPassword  ${password}

Input New Password  [Arguments]  ${password}
  Input Text  name=password  ${password}

Input Confirmed Password  [Arguments]  ${password}
  Input Text  name=confirmPassword  ${password}
