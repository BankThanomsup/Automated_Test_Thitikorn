
*** Variables ***

# Mobile (สำหรับ Appium)
${APPIUM_SERVER}    http://127.0.0.1:4723
${DEVICE_NAME}          emulator-5554
${PLATFORM_NAME}        Android
${APP_PACKAGE}          com.avjindersinghsekhon.minimaltodo
${APP_ACTIVITY}         com.example.avjindersinghsekhon.toodle.MainActivity
${appium_config}        Resources/json/appium_config.json
${APP_PATH}             Resources/application/app-minimal.apk
${AUTOMATION_NAME}       UiAutomator2
${ADD_TODO_BUTTON}       id=${APP_PACKAGE}:id/addToDoItemFAB
${TODO_INPUT_FIELD}      xpath=//*[@resource-id="com.avjindersinghsekhon.minimaltodo:id/userToDoEditText"]
${SAVE_TODO_BUTTON}      xpath=//*[@resource-id="com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton"]
${DELETE_TODO_BUTTON}    xpath=//*[@resource-id="com.avjindersinghsekhon.minimaltodo:id/deleteToDo"]
${EMPTY_TODO_MESSAGE}    xpath=//android.widget.TextView[@text="You don't have any todos"]