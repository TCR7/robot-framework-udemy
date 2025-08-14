*** Settings ***
Library    RequestsLibrary
Library    String
Library    ../../venv/lib/python3.12/site-packages/robot/libraries/Collections.py

*** Keywords ***

Create New User
    ${RANDOM_WORD}    Generate Random String    length=4    chars=[LETTERS]
    ${RANDOM_WORD}    Convert To Lower Case    ${RANDOM_WORD}
    Set Test Variable    ${EMAIL_TEST}    ${RANDOM_WORD}@testemail.com
    Log    ${EMAIL_TEST}

Register Created User On ServeRest
    [Arguments]    ${email}    ${status_code}
    ${body}    Create Dictionary    
    ...        nome=Fulano da Silva
    ...        email=${email}
    ...        password=1234
    ...        administrador=true
    Log    ${body}

    Create Session on ServeRest

    ${response}    POST On Session
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    ...            expected_status=${status_code}
    Log    ${response.json()}
    Set Test Variable    ${user_id}    ${response.json()["_id"]}
    Set Test Variable    ${RESPONSE}    ${response.json()}

Create Session on ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Verify If User Was Registered Correctly
    Log    ${RESPONSE}
    Dictionary Should Contain Item    ${RESPONSE}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPONSE}    _id

Repeat User Registration
    Register Created User On ServeRest    email=${EMAIL_TEST}    status_code=400

Check that the API doesnt allow repeated registration
    Dictionary Should Contain Item    ${RESPONSE}    message    Este email já está sendo usado

Check data for new user
    ${get_response}    GET On Session    alias=ServeRest    url=/usuarios/${user_id}    expected_status=200
    Set Test Variable    ${RESPONSE_DATA}    ${get_response.json()}
Check the returning data
    Log    ${RESPONSE_DATA}
    Dictionary Should Contain Item    ${RESPONSE_DATA}    nome                 Fulano da Silva
    Dictionary Should Contain Item    ${RESPONSE_DATA}    email                ${EMAIL_TEST}
    Dictionary Should Contain Item    ${RESPONSE_DATA}    password             1234
    Dictionary Should Contain Item    ${RESPONSE_DATA}    administrador        true
    Dictionary Should Contain Item    ${RESPONSE_DATA}    _id                  ${user_id}