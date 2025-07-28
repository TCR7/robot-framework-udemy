*** Settings ***
Library    SeleniumLibrary
Library    lib/python3.12/site-packages/robot/libraries/Telnet.py


*** Variables ***
${URL}                    https://www.amazon.com.br
${MENU_ELETRONICOS}       (//a[contains(text(),'Eletrônicos')])[1]
${CLICK_ELETRONICOS}      (//a[contains(text(),'Eletrônicos')])[1]
#${URL_TITLE}              (//title[normalize-space()='Eletrônicos e Tecnologia | Amazon.com.br'])[1]
${HEADER_ELETRONICOS}     (//span[contains(text(),'Eletrônicos e Tecnologia')])[1]

*** Keywords ***
Abrir o navegador
    Open Browser    about:blank    chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
Fechar o navegador
    Capture Page Screenshot
    Close Browser
Acessar a home page do site Amazon.com.br
    Go To    ${URL}
    Wait Until Element Is Visible    ${MENU_ELETRONICOS}
Entrar no menu "Eletrônicos"
    Click Element    ${CLICK_ELETRONICOS}
Verificar se aparece a frase "Eletrônicos e Tecnologia"
    Wait Until Page Contains    text=Eletrônicos e Tecnologia
    Wait Until Element Is Visible    ${HEADER_ELETRONICOS}
Verificar se o Título da página fica "${URL_TITLE}"
    Title Should Be    ${URL_TITLE}
Verificar se aparece a categoria "${CATEGORY_NAME}"
    Element Should Be Visible    (//a[@aria-label='${CATEGORY_NAME}'])[1]

# ========================================================================================================= #

# Teste 2 #
Digite o nome do produto ${PRODUTO} no campo de Pesquisa
    Sleep    1
    Click Element    (//input[@id='twotabsearchtextbox'])[1]
    Input Text    (//input[@id='twotabsearchtextbox'])[1]    ${PRODUTO}
Clicar no botão de pesquisa
    Sleep    1
    Click Element    (//input[@id='nav-search-submit-button'])[1]
Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    (//span[contains(text(),'${PRODUTO}')])[1]