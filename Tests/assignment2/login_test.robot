*** Settings ***
Resource                ..//..//init.txt
Library    OperatingSystem

*** Test Cases ***
Login Success
    [Documentation]    Verify successful login with valid username and password, then logout
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    SeleniumLibrary.Input Text    id:username    ${VALID_USER}
    SeleniumLibrary.Input Text    id:password    ${VALID_PASS}
    SeleniumLibrary.Click Button    //button[@type="submit"]
    SeleniumLibrary.Wait Until Page Contains    You logged into a secure area!
    Click Link    Logout
    SeleniumLibrary.Wait Until Page Contains    You logged out of the secure area!
    Close Browser

Login Failed - Password Incorrect
    [Documentation]    Verify login fails when correct username and wrong password is entered
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    SeleniumLibrary.Input Text    id:username    ${VALID_USER}
    SeleniumLibrary.Input Text    id:password    ${INVALID_PASS}
    SeleniumLibrary.Click Button    //button[@type="submit"]
    SeleniumLibrary.Wait Until Page Contains    Your password is invalid!
    Close Browser

Login Failed - Username Not Found
    [Documentation]    Verify login fails when non-existent username is entered
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    SeleniumLibrary.Input Text    id:username    ${INVALID_USER}
    SeleniumLibrary.Input Text    id:password    ${INVALID_PASS}
    SeleniumLibrary.Click Button    //button[@type="submit"]
    SeleniumLibrary.Wait Until Page Contains    Your username is invalid!
    Close Browser


