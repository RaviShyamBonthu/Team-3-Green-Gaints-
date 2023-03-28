*** Variables ***
${feature.action.dropdown}    //div[@name='action']//following::i[@class="dropdown icon"]    #clicking the Actions On field.
${feature.action.delete}    //span[text()='Delete']    # select the delete item from dropdown.
${feature.action.checkmark}    //i[@class='checkmark icon']
${feature.title.checkbox}    //a[text()='replaceText']/ancestor::tr//td/div[@class='ui fitted read-only checkbox']    # Click the respective checkbox.
${feature.rows.count}    //tbody//tr    # Total number of rows.
${feature.title}    //a[text()='replaceText']    # By clicking all details will be Viewed.
