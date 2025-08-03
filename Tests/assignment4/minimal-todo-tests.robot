*** Settings ***
Resource                ..//..//init.txt
Library                ..//..//Resources//Customlibraies//TouchLibrary.py

*** Test Cases ***
TC-001 Open Minimal Todo App
    [Tags]         Smoke
    Start Minimal Todo App
    Verify App Title    Minimal
    Verify Empty Todo Message
    Close Minimal Todo App

TC-002 Add Todo Item
    [Tags]         Functional
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    Buy Groceries
    Verify Todo Item Added    Buy Groceries
    Close Minimal Todo App

TC-003 Add And Delete Todo
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    Buy groceries
    Verify Todo Item Added    Buy groceries
    Delete Todo Item    Buy groceries
    Verify Todo Item Deleted    Buy groceries
    Verify Empty Todo Message
    Close Minimal Todo App

TC-004 Add Multiple Todo Items
    [Tags]    Functional
    Start Minimal Todo App
    # Add first item
    Click Add Todo Button
    Enter Todo Item    Buy groceries
    Verify Todo Item Added    Buy groceries
    # Add second item
    Click Add Todo Button
    Enter Todo Item    Do laundry
    Verify Todo Item Added    Do laundry
    # Add third item
    Click Add Todo Button
    Enter Todo Item    Pay bills
    Verify Todo Item Added    Pay bills
    # Verify all items exist
    Verify Todo Item Exists    Buy groceries
    Verify Todo Item Exists    Do laundry
    Verify Todo Item Exists    Pay bills
    Close Minimal Todo App

TC-005 Delete Multiple Todo Items
    [Tags]    Functional
    Start Minimal Todo App
    # Add items
    Click Add Todo Button
    Enter Todo Item    Task 1
    Click Add Todo Button
    Enter Todo Item    Task 2
    Click Add Todo Button
    Enter Todo Item    Task 3
    # Delete items one by one
    Delete Todo Item    Task 1
    Verify Todo Item Deleted    Task 1
    Delete Todo Item    Task 2
    Verify Todo Item Deleted    Task 2
    Delete Todo Item    Task 3
    Verify Todo Item Deleted    Task 3
    Verify Empty Todo Message
    Close Minimal Todo App

TC-006 Add And Verify Special Characters
    [Tags]    Functional
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    Test!@#$%^&*()
    Verify Todo Item Added    Test!@#$%^&*()
    Delete Todo Item    Test!@#$%^&*()
    Verify Todo Item Deleted    Test!@#$%^&*()
    Close Minimal Todo App

TC-007 Add Long Todo Text
    [Tags]    Functional
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    This is a very long todo item text that needs to be tested to ensure the application handles long text inputs correctly
    Verify Todo Item Added    This is a very long todo item text that needs to be tested to ensure the application handles long text inputs correctly
    Delete Todo Item    This is a very long todo item text that needs to be tested to ensure the application handles long text inputs correctly
    Verify Todo Item Deleted    This is a very long todo item text that needs to be tested to ensure the application handles long text inputs correctly
    Close Minimal Todo App

TC-008 Add Todo With Empty Text
    [Tags]    Negative
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    ${EMPTY}
    # ตรวจสอบว่าไม่สามารถบันทึกได้หรือมีข้อความแจ้งเตือน
    Verify Empty Todo Message
    Close Minimal Todo App

TC-009 Add Todo With Whitespace
    [Tags]    Negative
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    ${SPACE}${SPACE}${SPACE}
    # ตรวจสอบว่าสามารถบันทึกได้แต่มีช่องว่าง
    Verify Todo Item Added    ${SPACE}${SPACE}${SPACE}
    Close Minimal Todo App

TC-010 Add Todo With Unicode Characters
    [Tags]    Functional
    Start Minimal Todo App
    Click Add Todo Button
    Enter Todo Item    สวัสดี ✨ Hello こんにちは
    Verify Todo Item Added    สวัสดี ✨ Hello こんにちは
    Delete Todo Item    สวัสดี ✨ Hello こんにちは
    Verify Todo Item Deleted    สวัสดี ✨ Hello こんにちは
    Close Minimal Todo App

TC-011 Add Maximum Length Todo
    [Tags]    Functional
    Start Minimal Todo App
    ${max_length_text}=    Set Variable    ${{' '.join(['Test'] * 50)}}
    Click Add Todo Button
    Enter Todo Item    ${max_length_text}
    Verify Todo Item Added    ${max_length_text}
    Delete Todo Item    ${max_length_text}
    Verify Empty Todo Message
    Close Minimal Todo App

TC-012 Rapid Add And Delete
    [Tags]    Performance
    Start Minimal Todo App
    FOR    ${index}    IN RANGE    1    6
        Click Add Todo Button
        Enter Todo Item    Quick Task ${index}
        Verify Todo Item Added    Quick Task ${index}
    END
    FOR    ${index}    IN RANGE    1    6
        Delete Todo Item    Quick Task ${index}
        Verify Todo Item Deleted    Quick Task ${index}
    END
    Verify Empty Todo Message
    Close Minimal Todo App

TC-013 Add Duplicate Todo Items
    [Tags]    Functional
    Start Minimal Todo App
    # Add first item
    Click Add Todo Button
    Enter Todo Item    Duplicate Task
    Verify Todo Item Added    Duplicate Task
    # Add duplicate item
    Click Add Todo Button
    Enter Todo Item    Duplicate Task
    Verify Todo Item Added    Duplicate Task
    # Delete both items
    Delete Todo Item    Duplicate Task
    Delete Todo Item    Duplicate Task
    Verify Empty Todo Message
    Close Minimal Todo App
    
TC_14 - Add todo list and remind me
    [Tags]    Functional
    # BuiltIn.Skip    Skipping this test temporarily.
    Start Minimal Todo App
    Add Todo Item With Schedule    Meeting with Client    27
    Close Minimal Todo App



