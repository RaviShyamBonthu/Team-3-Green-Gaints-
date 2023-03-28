*** Settings ***
Resource          ../Global/global_variables.robot
Resource          ../Global/super.robot
Resource          ../Keywords/common.robot
Resource          ../Keywords/menu.robot
Resource          ../Keywords/order.robot

*** Variables ***
${filters.show}    //button[text()='Show Filters']
${filters.hide}    //button[text()='Hide Filters']
${filters.searchicon}    //i[@class="search small icon"]
