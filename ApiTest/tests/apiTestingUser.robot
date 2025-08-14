*** Settings ***
Resource    ../resources/apiTestingUserResources.robot

*** Variables ***

*** Test Cases ***
Scenario 01 - Register new user with success
    Create New User
    Register Created User On ServeRest    email=${EMAIL_TEST}    status_code=201
    Verify If User Was Registered Correctly
Scenario 02 - Register a user already registered
    Create New User
    Register Created User On ServeRest    email=${EMAIL_TEST}    status_code=201
    Repeat User Registration
    Check that the API doesnt allow repeated registration
Scenario 03 - Checking data for a new user
    Create New User
    Register Created User On ServeRest    email=${EMAIL_TEST}    status_code=201
    Check data for new user
    Check the returning data