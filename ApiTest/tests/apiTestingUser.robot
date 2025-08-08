*** Settings ***
Resource    ../resources/apiTestingUserResources.robot

*** Variables ***

*** Test Cases ***
Scenario 01 - Register new user with success
    Create New User
    Register Created User On ServeRest
    # Verify If User Was Registered Correctly