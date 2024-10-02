*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}     https://dummyjson.com/

# Rotas
${Search_products}              products?limit=qtde1&skip=qtde2&select=title,price

*** Keywords ***
Obter todos os produtos paginando por ${qtde_limite} e exibindo os proximos ${qtde_skip}
    &{headers}    Create Dictionary    Content_type=application/json
    ${Search_products}=    Replace String    ${Search_products}    qtde1     ${qtde_limite}
    ${Search_products}=    Replace String    ${Search_products}    qtde2     ${qtde_skip}

    ${response}=   GET    url=${HOST}/${Search_products}       headers=&{headers}    verify=${False}
    RETURN    ${response}


*** Test Cases ***
TC01 - Validar a paginacao da pesquisa dos produtos limitando a exibicao
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter todos os produtos paginando por 40 e exibindo os proximos 20
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.status_code}
    Log      ${retorno_pesquisa.json()}
    Log      ${retorno_pesquisa.json()['skip']}
    Log      ${retorno_pesquisa.json()['limit']}

    
TC02 - Validar a pesquisa dos produtos sem limitar a exibicao
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter todos os produtos paginando por 0 e exibindo os proximos 0
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.status_code}
    Log      ${retorno_pesquisa.json()}
    Log      ${retorno_pesquisa.json()['skip']}
    Log      ${retorno_pesquisa.json()['limit']}
