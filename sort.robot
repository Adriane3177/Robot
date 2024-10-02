*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}     https://dummyjson.com/

# Rotas
${Search_products}                 products?sortBy=campo&order=asc
*** Keywords ***
Obter todos os produtos por pesquisa de ${campo} em ordem crescente
    &{headers}    Create Dictionary    Content_type=application/json
    ${Search_products}=    Replace String    ${Search_products}    campo    ${campo}
    ${response}=   GET    url=${HOST}/${Search_products}       headers=&{headers}    verify=${False}
    RETURN    ${response}

*** Test Cases ***
TC01 - Validar a pesquisa de produtos por ordem crescente do campo title
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter todos os produtos por pesquisa de title em ordem crescente
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.json()}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['total']}      ${194}
    Log      ${retorno_pesquisa.json()['total']}
TC02 - Validar a pesquisa de produtos por ordem crescente do campo category
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter todos os produtos por pesquisa de category em ordem crescente
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.json()}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['total']}      ${194}
    Log      ${retorno_pesquisa.json()['total']}
