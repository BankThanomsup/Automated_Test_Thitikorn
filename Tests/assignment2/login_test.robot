*** Settings ***
Resource                ..//init.txt


*** Test Cases ***
Login Success
    [Documentation]    Verify successful login with valid username and password, then logout
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id:username    ${VALID_USER}
    Input Text    id:password    ${VALID_PASS}
    Click Button    //button[@type="submit"]
    Wait Until Page Contains    You logged into a secure area!
    Click Link    Logout
    Wait Until Page Contains    You logged out of the secure area!
    Close Browser

Login Failed - Password Incorrect
    [Documentation]    Verify login fails when correct username and wrong password is entered
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id:username    ${VALID_USER}
    Input Text    id:password    ${INVALID_PASS}
    Click Button    //button[@type="submit"]
    Wait Until Page Contains    Your password is invalid!
    Close Browser

Login Failed - Username Not Found
    [Documentation]    Verify login fails when non-existent username is entered
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id:username    ${INVALID_USER}
    Input Text    id:password    ${INVALID_PASS}
    Click Button    //button[@type="submit"]
    Wait Until Page Contains    Your username is invalid!
    Close Browser