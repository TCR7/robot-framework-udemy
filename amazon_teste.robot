*** Settings ***
Documentation    Essa suíte testa o site da Amazon.com.br
Resource         amazon_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***
Caso de Teste 01 - Acesso ao menu "Eletrônicos"
    [Documentation]  Esse teste verifica o menu Eletrônicos do site da Amazon.com.br
    ...              e verifica a categoria Computadores e Informática
    [Tags]           menus  categorias
    Acessar a home page do site Amazon.com.br
    Verificar se o Título da página fica "Amazon.com.br | Tudo pra você, de A a Z."
    Entrar no menu "Eletrônicos"
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
    Verificar se o Título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se aparece a categoria "Computadores e Informática, No momento, você está em um menu suspenso. Para abrir esse menu suspenso, pressione Enter."

Caso de Teste 02 - Pesquisa de Produto
    [Documentation]  Esse teste verifica a busca de um produto 
    [Tags]           busca_produtos  lista_busca
    Acessar a home page do site Amazon.com.br
    Digite o nome do produto "Xbox Series S" no campo de Pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"