*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api
${USER_ID}     2
${EXPECTED_NAME}    Janet
${EXPECTED_EMAIL}   janet.weaver@reqres.in

*** Test Cases ***
Get Single User
    [Documentation]    This test case retrieves a single user by ID and validates the response data.
    [Tags]    api    user
    Create Session    reqres    ${BASE_URL}
    ${response}=    Get Request    reqres    /users/${USER_ID}
    Should Be Equal As Strings    ${response.status_code}    200
    Validate User Data    ${response}

*** Keywords ***
Validate User Data
    [Arguments]    ${response}
    ${user_data}=    Get From Dictionary    ${response.json()}    data

    Should Be Equal As Numbers    ${user_data['id']}    ${USER_ID}
    Log    User id validated: ${user_data['id']}

    Should Be Equal As Strings    ${user_data['first_name']}    ${EXPECTED_NAME}
    Log    User id validated: ${user_data['first_name']}

    Should Be Equal As Strings    ${user_data['email']}    ${EXPECTED_EMAIL}
    Log    User data validated: ${user_data['email']}
