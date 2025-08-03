*** Settings ***
Resource                ..//..//init.txt

*** Keywords ***
Start Minimal Todo App
    [Documentation]    เปิดแอป Minimal Todo บน Emulator
    Open Application        ${APPIUM_SERVER}
    ...    platformName=Android
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:app=${APP_PATH}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    autoGrantPermissions=true


Close Minimal Todo App
    [Documentation]    ปิดแอป Minimal Todo
    Close Application

Click Add Todo Button
    [Documentation]    คลิกปุ่มเพิ่มรายการ (Add Todo Button)
    AppiumLibrary.Wait Until Element Is Visible    ${ADD_TODO_BUTTON}    timeout=10s
    AppiumLibrary.Click Element    ${ADD_TODO_BUTTON}

Enter Todo Item
    [Arguments]    ${todo_item}
    [Documentation]    ป้อนข้อความในรายการใหม่
    AppiumLibrary.Wait Until Element Is Visible    ${TODO_INPUT_FIELD}    timeout=10s
    AppiumLibrary.Input Text    ${TODO_INPUT_FIELD}    ${todo_item}
    AppiumLibrary.Wait Until Element Is Visible    ${SAVE_TODO_BUTTON}    timeout=10s
    AppiumLibrary.Click Element    ${SAVE_TODO_BUTTON}

Enter Todo Item and wait
    [Arguments]    ${todo_item}
    [Documentation]    ป้อนข้อความในรายการใหม่
    AppiumLibrary.Wait Until Element Is Visible    ${TODO_INPUT_FIELD}    timeout=10s
    AppiumLibrary.Input Text    ${TODO_INPUT_FIELD}    ${todo_item}
    AppiumLibrary.Wait Until Element Is Visible    ${SAVE_TODO_BUTTON}    timeout=10s

Swipe Todo Item Left
    [Arguments]    ${todo_item}
    [Documentation]    ปัดรายการไปทางซ้ายเพื่อลบ
    ${todo_xpath}=    Set Variable    xpath=//android.widget.TextView[@text="${todo_item}"]
    AppiumLibrary.Wait Until Element Is Visible    ${todo_xpath}    timeout=10s
    ${element}=    AppiumLibrary.Get Webelement    ${todo_xpath}
    ${element_location}=    AppiumLibrary.Get Element Location    ${todo_xpath}
    ${element_size}=    AppiumLibrary.Get Element Size    ${todo_xpath}
    ${start_x}=    Evaluate    ${element_location['x']} + ${element_size['width']} * 0.8
    ${end_x}=    Evaluate    ${element_location['x']} + ${element_size['width']} * 0.1
    ${y}=    Evaluate    ${element_location['y']} + ${element_size['height']} * 0.5
    AppiumLibrary.Swipe    start_x=${start_x}    start_y=${y}    end_x=${end_x}    end_y=${y}    duration=500ms
    Sleep    2s

Verify Todo Item Added
    [Arguments]    ${todo_item}
    [Documentation]    ตรวจสอบว่ารายการใหม่ถูกเพิ่มเรียบร้อยแล้ว
    ${todo_xpath}=    Set Variable    xpath=//android.widget.TextView[@text="${todo_item}"]
    AppiumLibrary.Wait Until Element Is Visible    ${todo_xpath}    timeout=10s
    AppiumLibrary.Element Should Be Visible    ${todo_xpath}

Delete Todo Item
    [Arguments]    ${todo_item}
    [Documentation]    ลบรายการที่ระบุโดยการปัดซ้าย (ลบเฉพาะ element ที่เลือก)
    ${elements}=    AppiumLibrary.Get WebElements    xpath=//android.widget.TextView[@text="${todo_item}"]
    ${initial_count}=    Get Length    ${elements}
    Swipe Todo Item Left    ${todo_item}

Verify Todo Item Deleted
    [Arguments]    ${todo_item}
    [Documentation]    ตรวจสอบว่ารายการถูกลบเรียบร้อยแล้ว
    ${todo_xpath}=    Set Variable    xpath=//android.widget.TextView[@text="${todo_item}"]
    AppiumLibrary.Wait Until Page Does Not Contain Element    ${todo_xpath}    timeout=10s

Verify Empty Todo Message
    [Documentation]    ตรวจสอบข้อความ "You don't have any todos"
    AppiumLibrary.Wait Until Element Is Visible    ${EMPTY_TODO_MESSAGE}    timeout=10s
    AppiumLibrary.Element Should Be Visible    ${EMPTY_TODO_MESSAGE}

Verify App Title
    [Arguments]    ${title}
    [Documentation]    ตรวจสอบชื่อแอปบน Toolbar
    ${title_xpath}=    Set Variable    xpath=//android.widget.TextView[@text="${title}"]
    AppiumLibrary.Wait Until Element Is Visible    ${title_xpath}    timeout=10s
    AppiumLibrary.Element Should Be Visible    ${title_xpath}

Verify Todo Item Exists
    [Arguments]    ${todo_item}
    [Documentation]    ตรวจสอบว่ารายการยังคงอยู่ในแอป
    ${todo_xpath}=    Set Variable    xpath=//android.widget.TextView[@text="${todo_item}"]
    AppiumLibrary.Wait Until Element Is Visible    ${todo_xpath}    timeout=10s
    AppiumLibrary.Element Should Be Visible    ${todo_xpath}

Wait For Element
    [Arguments]    ${locator}    ${timeout}=10s
    [Documentation]    รอจนกว่า Element จะปรากฏ
    AppiumLibrary.Wait Until Element Is Visible    ${locator}    timeout=${timeout}

Wait Until Element Does Not Exist
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Keyword Succeeds    ${timeout}    1s    Element Should Not Be Visible    ${locator}

Enable Remind Me
    [Documentation]    เปิดตัวเลือก Remind Me
    AppiumLibrary.Wait Until Element Is Visible    //android.widget.Switch[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat"]
    AppiumLibrary.Click Element    //android.widget.Switch[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat"]

Select Todo Date
    [Arguments]    ${date}
    [Documentation]    เลือกวันที่ในปฏิทิน
    Scroll To Date    ${date}
    Sleep    3s
    AppiumLibrary.Wait Until Element Is Visible    //android.view.View[@content-desc="${date} August 2025"]
    AppiumLibrary.Click Element    //android.view.View[@content-desc="${date} August 2025"]
    Click Ok Button For Date

Tap On Coordinates
    [Arguments]       ${x}    ${y}
    Tap With W3C Action        ${x}    ${y}




Select Todo Time
    [Documentation]    เลือกเวลาในฟอร์แมตชั่วโมง นาที และช่วงเวลา AM/PM
    AppiumLibrary.Wait Until Element Is Visible    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]
    AppiumLibrary.Click Element    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]
    # ${driver}=    Get Library Instance    AppiumLibrary
    # เลือกชั่วโมง
    Tap With Positions    [[661, 891]]
    
    # เลือกนาที
    Tap With Positions    [[661, 891]]
    Click Ok Button For Time

Cancel Todo Time
    [Documentation]    ยกเลิกการตั้งเวลา
    AppiumLibrary.Wait Until Element Is Visible    //android.widget.Button[@resource-id="com.avjindersinghsekhon.minimaltodo:id/cancel"]
    AppiumLibrary.Click Element    //android.widget.Button[@resource-id="com.avjindersinghsekhon.minimaltodo:id/cancel"]

Click Ok Button For Date
    [Documentation]    คลิกปุ่ม OK หลังจากเลือกวันที่
    AppiumLibrary.Click Element    xpath=//android.widget.Button[@resource-id="com.avjindersinghsekhon.minimaltodo:id/ok"]  # กด OK

Click Ok Button For Time
    [Documentation]    กดปุ่ม OK หลังจากเลือกเวลาใน Time Picker
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.Button[@text="OK"]    timeout=15s
    AppiumLibrary.Click Element    xpath=//android.widget.Button[@text="OK"]
    AppiumLibrary.Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@text="OK"]    timeout=10s

Scroll To Date
    [Arguments]    ${date}
    [Documentation]    เลื่อนปฏิทินไปยังวันที่ที่ระบุ
    AppiumLibrary.Click Element    xpath=//android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText"]
    Sleep   3s  

    # ${json}=    Set Variable    {"strategy": "accessibility id", "selector": "${date} December 2024"}
    # Execute Script    {"script": "mobile: scroll", "args": ${json}}

Verify Date
    [Arguments]    ${expected_date}
    [Documentation]    ตรวจสอบวันที่ที่แสดงในฟอร์ม
    ${actual_date}=    AppiumLibrary.Get Text    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText"]
    BuiltIn.Should Be Equal    ${actual_date}    ${expected_date}


Add Todo Item With Schedule
    [Arguments]    ${todo_item}    ${date}    
    [Documentation]    เพิ่ม Todo Item พร้อมตั้งค่า
    Click Add Todo Button
    Enter Todo Item and wait    ${todo_item}
    Enable Remind Me
    Select Todo Date    ${date}
    Select Todo Time    
    Verify Date       27 Aug, 2025
    AppiumLibrary.Wait Until Element Is Visible    ${SAVE_TODO_BUTTON}    timeout=10s
    AppiumLibrary.Click Element    ${SAVE_TODO_BUTTON}
    Verify Todo Item Added    ${todo_item}