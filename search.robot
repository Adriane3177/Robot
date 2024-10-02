*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}     https://dummyjson.com/

# Rotas
${Search_products}                 products/search?q=descricao

*** Keywords ***
Obter todos os produtos por pesquisa de ${descricao}
    &{headers}    Create Dictionary    Content_type=application/json
    ${Search_products}=    Replace String    ${Search_products}    descricao    ${descricao}
    ${response}=   GET    url=${HOST}/${Search_products}       headers=&{headers}    verify=${False}
    RETURN    ${response}

*** Test Cases ***
TC01 - Validar a pesquisa de produtos por phone
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter todos os produtos por pesquisa de phone
    Log      ${retorno_pesquisa.status_code} 
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.json()}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['total']}      ${23}
    Log      ${retorno_pesquisa.json()['total']}
