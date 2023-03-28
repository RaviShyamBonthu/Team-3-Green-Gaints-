*** Variables ***
${access.private.users}    //div[text()='Select users allowed access.']    # select the users in Private access.
${access.private.singleuser}    //button[text()='Private']//following::div[@class='visible menu transition']//span[text()='replaceText']    # Selecting single user.
${access.private.multiuser}    //div[@class='visible menu transition']    # Select multiple users.
