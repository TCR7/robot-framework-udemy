*** Settings ***
Library    RequestsLibrary
Library    String

*** Keywords ***

Create New User
    ${RANDOM_WORD}    Generate Random String    length=4    chars=[LETTERS]
    ${RANDOM_WORD}    Convert To Lower Case    ${RANDOM_WORD}
    Set Test Variable    ${EMAIL_TEST}    ${RANDOM_WORD}@testemail.com
    Log    ${EMAIL_TEST}

Register Created User On ServeRest
    ${body}    Create Dictionary    
    ...        nome=Fulano da Silva
    ...        email=${EMAIL_TEST}
    ...        password=1234
    ...        administrador=${TRUE}
    Log    ${body}
    Create Session on ServeRest
    ${response}    POST On Session
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    Log    ${response.json()}

Create Session on ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}
