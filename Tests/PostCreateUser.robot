*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://reqres.in/api
${CREATE_USER_URL}  /users
${NAME}             John
${JOB}              Developer

*** Test Cases ***
Create User
    [Documentation]    This test case creates a new user and validates the response.
    [Tags]    api    user
    Create Session    reqres    ${BASE_URL}    verify=False
    ${payload}=    Create User Payload
    ${response}=    POST On Session    reqres    ${CREATE_USER_URL}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    201
    Validate Created User    ${response.json()}    ${NAME}    ${JOB}

*** Keywords ***
Create User Payload
    &{payload}=    Create Dictionary    name=${NAME}    job=${JOB}
    [Return]    ${payload}

Validate Created User
    [Arguments]    ${response_json}    ${expected_name}    ${expected_job}
    Should Be Equal As Strings    ${response_json['name']}    ${expected_name}
    Should Be Equal As Strings    ${response_json['job']}    ${expected_job}
    Log    Created user validated: ${response_json}
