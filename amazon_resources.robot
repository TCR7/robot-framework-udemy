*** Settings ***
Library    SeleniumLibrary 


*** Variables ***
${URL}                    https://www.amazon.com.br
${MENU_ELETRONICOS}       (//a[contains(text(),'Eletrônicos')])[1]
${CLICK_ELETRONICOS}      (//a[contains(text(),'Eletrônicos')])[1]    
${HEADER_ELETRONICOS}     (//span[contains(text(),'Eletrônicos e Tecnologia')])[1]

*** Keywords ***
Abrir o navegador
    Open Browser    ${URL}    Chrome   
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
Digite o nome do produto "${PRODUTO}" no campo de Pesquisa
    Sleep    1
    Click Element    (//input[@id='twotabsearchtextbox'])[1]
    Input Text    (//input[@id='twotabsearchtextbox'])[1]    ${PRODUTO}
Clicar no botão de pesquisa
    Sleep    0.2
    Click Element    (//input[@id='nav-search-submit-button'])[1]
Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    (//span[contains(text(),'${PRODUTO}')])[1]

# ========================================================================================================== #
# Gherkin BDD

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o Título da página fica "Amazon.com.br | Tudo pra você, de A a Z."
Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"
Então o título da página deve ficar     ${PAGE_TITLE_URL}
    Verificar se o Título da página fica ${PAGE_TITLE_URL}
E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
E a categoria "Computadores e Informática" deve ser exibida na página
     Verificar se aparece a categoria "Computadores e Informática, No momento, você está em um menu suspenso. Para abrir esse menu suspenso, pressione Enter."

# Gherkin BDD Test Case 2

Quando pesquisar pelo produto Xbox Series S
    Digite o nome do produto "Xbox Series S" no campo de Pesquisa
    Clicar no botão de pesquisa
Então o título da página deve ficar "${PAGE_TITLE}"
    Verificar se o Título da página fica "${PAGE_TITLE}"
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

    