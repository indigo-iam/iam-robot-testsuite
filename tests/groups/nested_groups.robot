*** Settings ***
Resource  lib/utils.robot

Suite Setup  Go to IAM
Suite Teardown  Close All Browsers

Test Setup  Setup for nested group tests
Test Teardown  Teardown for nested groups tests

Force Tags   group:nested

*** Variables ***
${ROOT_GROUP}    r1
${ROOT_GROUP_2}  r2
${L1_GROUP}      l1
${L2_GROUP}      l2

  
*** Test Cases ***

Create full tree
  Create root group  ${ROOT_GROUP}
  Create subgroup to  ${ROOT_GROUP}  ${L1_GROUP}
  Create subgroup to  ${ROOT_GROUP}/${L1_GROUP}  ${L2_GROUP}
  Find group in groups page  ${ROOT_GROUP}
  Find group in groups page  ${ROOT_GROUP}/${L1_GROUP}
  Find group in groups page  ${ROOT_GROUP}/${L1_GROUP}/${L2_GROUP}
  ${id}=  Set Variable  subgroupslist
  ${row}=  Set Variable  2
  Go to group details page  ${ROOT_GROUP}/${L1_GROUP}/${L2_GROUP}
  Page Should Contain  No member found.
  Page Should Contain  No subgroup found.
  Go to groups page
  Go to group details page  ${ROOT_GROUP}/${L1_GROUP}
  Table Cell Should Contain  ${id}  ${row}  1  1
  Table Cell Should Contain  ${id}  ${row}  2  ${L2_GROUP}
  Table Cell Should Contain  ${id}  ${row}  3  Remove
  Page Should Contain  No member found.
  Go to groups page
  Go to group details page  ${ROOT_GROUP}
  Table Cell Should Contain  ${id}  ${row}  1  1
  Table Cell Should Contain  ${id}  ${row}  2  ${L1_GROUP}
  Table Cell Should Contain  ${id}  ${row}  3  Remove
  Page Should Contain  No member found.
  Go to groups page
  Delete group  ${ROOT_GROUP}/${L1_GROUP}/${L2_GROUP}
  Delete group  ${ROOT_GROUP}/${L1_GROUP}
  Delete group  ${ROOT_GROUP}

Create subgroups with same name
  Create root group  ${ROOT_GROUP}
  Create subgroup to  ${ROOT_GROUP}  ${L1_GROUP}
  Open add subgroup dialog for group  ${ROOT_GROUP}
  Input Text  id=name  ${L1_GROUP}
  Click Button  Add Subgroup
  Wait Until Page Contains  Duplicated group '${ROOT_GROUP}/${L1_GROUP}'
  Close Dialog
  Wait until modal overlay disappear
  Clear search in groups page
  Wait Until Page Contains Element  id=groupslist
  Delete group  ${ROOT_GROUP}/${L1_GROUP}
  Delete group  ${ROOT_GROUP}

Create subgroups with same name but different parent
  Create root group  ${ROOT_GROUP}
  Create root group  ${ROOT_GROUP_2}
  Create subgroup to  ${ROOT_GROUP}  ${L1_GROUP}
  Create subgroup to  ${ROOT_GROUP_2}  ${L1_GROUP}
  Find group in groups page  ${ROOT_GROUP}/${L1_GROUP}
  Find group in groups page  ${ROOT_GROUP_2}/${L1_GROUP}
  Delete group  ${ROOT_GROUP}/${L1_GROUP}
  Delete group  ${ROOT_GROUP_2}/${L1_GROUP}
  Delete group  ${ROOT_GROUP}
  Delete group  ${ROOT_GROUP_2}  

*** Keywords ***
Setup for nested group tests
  Login as admin
  Go to Indigo dashboard
  Go to groups page
  
Teardown for nested groups tests
  Logout from Indigo dashboard
 