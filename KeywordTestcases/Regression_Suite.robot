*** Settings ***
Suite Setup       Create Screenshot Directory
<<<<<<< HEAD
=======
Test Teardown
>>>>>>> fce687c27fab5e2bc99f5c13dda9f6599d4a284a
Resource          ../Global/super.robot
Resource          ../Global/global_variables.robot
Resource          ../Keywords/common.robot
Resource          ../Keywords/menu.robot
Resource          ../Keywords/order.robot
Resource          ../ObjectRepository/Combo_Box.robot
Resource          ../ObjectRepository/Dropdown.robot
Resource          ../ObjectRepository/Dynamic_Xpath.robot
Resource          ../ObjectRepository/Filters.robot
Resource          ../ObjectRepository/buttons.robot
Resource          ../ObjectRepository/icons.robot
Resource          ../ObjectRepository/images.robot
Resource          ../ObjectRepository/label.robot
Resource          ../ObjectRepository/links.robot
Resource          ../ObjectRepository/textboxes.robot
*** Test Cases ***
TC_01 Login with Valid details
    [Setup]
    Comment    Login to the Cogmento Application with valid Credentials
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window

TC_002 NavigateToTasks
    Comment    Navigate from home Page to a feature.
    Sleep    3s
    NavigateToFeature
    Take Screenshot

TC_003 ActionsConfirmation
    Mouse Down    ${header.title.toolbar}
    PerformActions    dcghchc
    Take Screenshot

TC_004 UserprivateAccess
    Mouse Over    ${button.feature.create}
    PrivateAccess    Sanjana Namburu
    Multiple Private Access    Kavya Bontha

TC_005 Table Actions
    Comment    To View the feature details.
    View Action    Task1
    Go Back
    Comment    Validate wheather page navigated to back.
    Take Screenshot
    Comment    To Edit the feature details
    Edit Action    Task2
    Go Back
    Comment    Validate wheather page navigated to back.
    Take Screenshot
    Comment    To Delete the feature details.
    Delete Action    Task3
