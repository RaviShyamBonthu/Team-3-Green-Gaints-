*** Settings ***
Resource          ../Global/global_variables.robot
Resource          ../Global/super.robot
Resource          ../Keywords/common.robot
Resource          ../Keywords/menu.robot
Resource          ../Keywords/order.robot

*** Variables ***
${combobox.inputname}    //div[@name='replaceText']/input[@class="search"]
${combobox.inputadd}    //span[contains(text(), 'Add ')]
