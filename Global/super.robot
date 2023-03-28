*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../ObjectRepository/textbox.robot    # Credentials to Login into the Application
Resource          ../ObjectRepository/buttons.robot
Resource          ../ObjectRepository/header.robot
Resource          ../ObjectRepository/feature.robot    # performing actions and table actions.
Resource          ../ObjectRepository/icon.robot    # Icon buttons.
Resource          ../ObjectRepository/access.robot    # User public/private access
Resource          ../Keywords/common.robot    # All common keywords.
Resource          global_variables.robot
Resource          ../ObjectRepository/label.robot
<<<<<<< HEAD
=======
Resource          ../ObjectRepository/links.robot
Resource          ../ObjectRepository/textboxes.robot
Resource          ../Keywords/common.robot
Resource          ../ObjectRepository/icons.robot
Library           ../Library/CustomLibrary.py
Library           OperatingSystem
Resource          ../ObjectRepository/logo.robot
Resource          ../ObjectRepository/Combo_Box.robot
Resource          ../ObjectRepository/Dropdown.robot
Resource          ../ObjectRepository/Dynamic_Xpath.robot
Resource          ../ObjectRepository/Filters.robot
Resource          ../Keywords/menu.robot
Resource          ../Keywords/order.robot
Resource          ../ObjectRepository/logo.robot
Resource          ../ObjectRepository/error.messages.robot
>>>>>>> fce687c27fab5e2bc99f5c13dda9f6599d4a284a
