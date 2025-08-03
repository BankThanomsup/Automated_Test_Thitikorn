*** Settings ***
Resource                ..//..//init.txt

*** Variables ***
${BASE_URL}       https://reqres.in/api
${USER_ID}        12
${NOT_FOUND_ID}   1234
${API_KEY}        reqres-free-v1

*** Keywords ***

*** Test Cases ***

Get user profile success
    [Documentation]    To verify get user profile API returns correct data for existing user
    Create Session     httpSession    ${BASE_URL}
    &{headers}=        Create Dictionary    x-api-key=${API_KEY}    Accept=application/json
    ${response}=       Get On Session    httpSession    /users/${USER_ID}    headers=&{headers}    expected_status=anything
    Log                Response Text=${response.text}
    Status Should Be   200    ${response}
        
    ${json}=           Evaluate    json.loads("""${response.text}""")    modules=json
    ${data}=           Set Variable    ${json['data']}
        
    Dictionary Should Contain Value    ${data}    rachel.howell@reqres.in
    Should Be Equal As Integers   ${data['id']}           ${USER_ID}
    Should Be Equal    ${data['first_name']}              Rachel
    Should Be Equal    ${data['last_name']}               Howell
    Should Be Equal    ${data['avatar']}                  https://reqres.in/img/faces/12-image.jpg

Get user profile but user not found
    [Documentation]    Verify API returns 404 and empty JSON body for non-existing user
    Create Session     httpSession    ${BASE_URL}
    &{headers}=        Create Dictionary    x-api-key=${API_KEY}    Accept=application/json
    ${response}=       Get On Session    httpSession    /users/${NOT_FOUND_ID}    headers=&{headers}    expected_status=anything
    Log                Response Text=${response.text}
    Status Should Be   404    ${response}
    Should Be Equal    ${response.text}    {}