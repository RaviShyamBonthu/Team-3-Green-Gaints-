*** Settings ***
Resource          ../Global/super.robot
*** Keywords ***
Launch Browser
    [Arguments]    ${browser_name}    ${url}
    Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Open Browser    ${url}    gc
    Run Keyword If    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'    Open Browser    ${url}    Firefox

Launch Browser and Navigate to URL
    [Arguments]    ${url}    ${browser_name}
    ${session}    Run Keyword And Return Status    Get Session Id
    Run Keyword If    ${session}==True    Go To    ${url}
    ...    ELSE    Launch Browser    ${browser_name}    ${url}
    Comment    Maximize Browser Window
    Set Browser Position    ${browser_name}

Login to Cogmento Application
    [Arguments]    ${username}    ${password}
    Set Test Message    Launch Browser: ${BROWSER_NAME}
    Launch Browser and Navigate to URL    ${URL}    ${BROWSER_NAME}
    Enter Login Details    ${username}    ${password}
    SeleniumLibrary.Wait Until Element Is Visible    ${label.home.username}    ${LONG_WAIT}    User not able to login to the application
    common.Take Screenshot

Enter Login Details
    [Arguments]    ${username}    ${password}
    SeleniumLibrary.Wait Until Element Is Visible    ${textbox.signin.emiladdress}    ${LONG_WAIT}    Login page \ - is not displayed after waiting ${LONG_WAIT}
    SeleniumLibrary.Input Text    ${textbox.signin.emiladdress}    ${username}
    SeleniumLibrary.Input Text    ${textbox.signin.password}    ${password}
    SeleniumLibrary.Click Element    ${button.signin.login}

Read TestData From Excel
    [Arguments]    ${testcaseid}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${test_prerequisite_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcaseid}    ${sheet_name}
    Set Global Variable    ${test_prerequisite_data}
    [Return]    ${test_prerequisite_data}

Take Screenshot
    Capture Page Screenshot

Read Data From Excel
    [Arguments]    ${testcase_no}
    Acquire Lock    data
    ${login_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_no}    Login
    Set Global Variable    ${login_data}
    ${order_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_no}    Order
    Set Global Variable    ${order_data}
    Release Lock    data

Set Browser Position
    [Arguments]    ${browser_name}
    Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Set Window Position    0    5
    Run Keyword If    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'    Set Window Position    1005    6
    Set Window Size    959    1047

Create Screenshot Directory
    Run Keyword And Ignore Error    Create Directory    ${EXECDIR}/Screenshots
    SeleniumLibrary.Set Screenshot Directory    ${EXECDIR}/Screenshots

Get Filename For Image
    ${time}=    Get Time
    ${time}=    Remove String    ${time}    -
    ${time}=    Remove String    ${time}    :
    ${time}=    Remove String    ${time}    ${SPACE}
    ${filename}=    Set Variable    flower_${BROWSER_NAME}_${time}.png
    Return From Keyword    ${filename}

Update dynamic Xpath
    [Arguments]    ${locator}    ${text}
    ${new_locator}    Replace String    ${locator}    replaceText    ${text}
    [Return]    ${new_locator}

Navigate to Modules
    [Arguments]    ${module_name}
    Wait Until Element Is Visible    ${icon.home}    ${SHORT_WAIT}
    Mouse Over    ${icon.home}
    ${module_xpath}    Update dynamic Xpath    ${icons.text}    ${module_name}
    Wait Until Element Is Visible    ${module_xpath}
    Click Element    ${module_xpath}
    Mouse Over    ${icon.logo.cogmento}
    Reload Page
    Check Page Header    ${module_name}

Select Item from Dropdown
    [Arguments]    ${dropdown_name}    ${item_name}
    ${new_dropdown}    Update dynamic Xpath    ${dropdown.name}    ${dropdown_name}
    Wait Until Element Is Visible    ${new_dropdown}    ${MEDIUM_WAIT}
    Click Element    ${new_dropdown}
    ${new_item}    Update dynamic Xpath    ${text.module.name}    ${item_name}
    Wait Until Element Is Visible    ${new_item}    ${MEDIUM_WAIT}
    Click Element    ${new_item}

Filters
    [Arguments]    ${search_item}    ${value}
    Wait Until Keyword Succeeds    2    2s    Click Show Filter
    Select Item from Dropdown    name    ${search_item}
    Select Item from Dropdown    operator    Equals
    Wait Until Element Is Visible    ${icon.filters.search}    ${SHORT_WAIT}
    Input Text    ${textbox.filter.value}    ${value}
    Click Element    ${icon.search.icon}

Combo box
    [Arguments]    ${combo_name}    ${value}
    ${new_combo}    Update dynamic Xpath    ${dropdown.name}    ${combo_name}
    Wait Until Element Is Visible    ${new_combo}    ${SHORT_WAIT}
    Click Element    ${new_combo}
    ${new_input}    Update dynamic Xpath    ${text.search.input}    ${combo_name}
    Wait Until Element Is Visible    ${new_input}
    Input Text    ${new_input}    ${value}
    ${new_value}    Update dynamic Xpath    ${text.module.name}    ${value}
    ${new_displayed}    Run Keyword And Return Status    Wait Until Element Is Visible    ${new_value}    ${SHORT_WAIT}
    Run Keyword If    ${new_displayed}==True    Click Element    ${new_value}
    ...    ELSE    Click Element    ${text.search.add}

Logout from application
    Wait Until Element Is Visible    ${icon.settings}    ${SHORT_WAIT}
    Click Element    ${icon.settings}
    Wait Until Element Is Visible    ${icon.logout}    ${SHORT_WAIT}
    Click Element    ${icon.logout}

Check field required error message
    [Arguments]    ${expexted_error_message}
    ${actual_error_message}    Set Variable
    Wait Until Element Is Visible    ${text.emptyfield.errormessages}    ${SHORT_WAIT}
    ${erromessage_count}    Get Element Count    ${text.emptyfield.errormessages}
    FOR    ${elements}    IN RANGE    1    ${erromessage_count}+1
        ${actual.errormessage.mandatoryfield}=    Get Text    ${text.emptyfield.errormessages}
        ${actual_error_message}    Catenate    ${actual_error_message}    ${actual.errormessage.mandatoryfield}
    END
    Log    ${actual_error_message}
    Should Contain    ${expexted_error_message}    ${actual.errormessage.mandatoryfield}

Check error message
    [Arguments]    ${expected_error_message}
    Wait Until Element Is Visible    ${text.charlength.errormessage}
    ${actual_error_message}=    Get Text    ${text.charlength.errormessage}
    Should Contain    ${expected_error_message}    ${actual_error_message}

Delete Record
    [Arguments]    ${title_name}
    ${action}=    Set Variable    deleterecord
    Table Actions    ${action}    ${title_name}
    Check Confirmation Pop Up
    Perform Action On Confirmation Box    Delete

Private Access User
    [Arguments]    ${user_name1}    ${user_name2}
    comment    After clicking public button click the placeholder dropdown
    Wait Until Element Is Visible    ${dropdown.private.placeholder}
    Click Element    ${dropdown.private.placeholder}
    Comment    Select the one user from \ dropdown
    ${privatedropdown_user1}    Update dynamic Xpath    ${dropdown.private.selectuser}    ${user_name1}
    Wait Until Element Is Visible    ${privatedropdown_user1}    ${SHORT_WAIT}
    Comment    Clicking the one user from \ dropdown
    Click Element    ${privatedropdown_user1}
    Comment    Select the other user from \ dropdown
    ${privatedropdown_user2}    Update dynamic Xpath    ${dropdown.private.selectuser}    ${user_name2}
    Wait Until Element Is Visible    ${privatedropdown_user2}    ${MEDIUM_WAIT}
    Comment    Clicking the other user from dropdown
    Click Element    ${privatedropdown_user2}
    Take Screenshot

Table Actions
    [Arguments]    ${action}    ${title_name}
    ${newLoc_action}=    Set Variable If    '${action}'=='ViewRecord' or '${action}'=='viewrecord'    ${icon.table.view}    '${action}'=='EditRecord' or '${action}'=='editrecord'    ${icon.table.edit}    '${action}'=='Delete' or '${action}'=='deleterecord'    ${icon.table.delete}
    ${updatedLoc_action}    Update dynamic Xpath    ${newLoc_action}    ${title_name}
    Wait Until Element Is Visible    ${updatedLoc_action}    ${LONG_WAIT}
    Click Element    ${updatedLoc_action}
    Run Keyword If    '${action}'=='ViewRecord' or '${action}'=='viewrecord'    Check Page Header    ${title_name}
    Run Keyword If    '${action}'=='EditRecord' or '${action}'=='editrecord'    Check Page Header    ${title_name}
    Run Keyword If    '${action}'=='Delete' or '${action}'=='deleterecord'    Check Confirmation Pop Up

Check Records Displayed
    [Arguments]    ${record_name}
    ${new_record}    Update dynamic Xpath    ${text.record.name}    ${record_name}
    Wait Until Element Is Visible    ${new_record}    ${SHORT_WAIT}

Check RubbishBin Records
    [Arguments]    ${module_name}    ${record_name}
    Click Element    ${buttons.rubbishbin.icon}
    Check Page Header    Rubbish Bin
    ${new_module}    Update dynamic Xpath    ${text.rubbishbin.modules}    ${module_name}
    Click Element    ${new_module}
    Check Records Displayed    ${record_name}

Check Confirmation Pop Up
    Wait Until Element Is Visible    ${label.confirmation.msg}    ${SHORT_WAIT}    Delete confirmation box is not displayed

Check Page Header
    [Arguments]    ${module_name}
    ${newHeader_xpath}    Update dynamic Xpath    ${text.page.header}    ${module_name}
    Wait Until Element Is Visible    ${newHeader_xpath}    ${MEDIUM_WAIT}

Perform Action On Confirmation Box
    [Arguments]    ${operation}
    ${newLoc_operation}    Update dynamic Xpath    ${button.confirmation.box}    ${operation}
    Click Element    ${newLoc_operation}

Click Show Filter
    Wait Until Element Is Visible    ${button.filter.show}
    Click Button    ${button.filter.show}
    Wait Until Element Is Visible    //button[text()='Hide Filters']

Click and Wait Until
    [Arguments]    ${click_element}    ${wait_element}
    Wait Until Element Is Visible    ${click_element}    ${SHORT_WAIT}
    Click Element    ${click_element}
    Wait Until Element Is Visible    ${wait_element}
