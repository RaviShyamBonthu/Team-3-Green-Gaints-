*** Variables ***
${icon.access.private}    //button[@class='ui small fluid negative toggle button' and text()='Private']    # Private access icon.
${icon.actions.view}    //a[text()='replaceText']/following::td[contains(@class,'options-buttons-container')][1]/a/button/i[@class="unhide icon"]    # To view the details of respective feature.
${icon.actions.edit}    //a[text()='replaceText']/following::td[contains(@class,'options-buttons-container')][3]/a/button/i[@class="edit icon"]    # To edit the details of respective feature.
${icon.actions.delete}    //a[text()='replaceText']//following::td[contains(@class,'options-buttons-container')][1]//i[contains(@class,'trash icon')]    # To delete the details of respective feature.
