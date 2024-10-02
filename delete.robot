*** Settings ***
Library    RequestsLibrary
Library    String
*** Variables ***
${HOST}     https://dummyjson.com/

# Rotas
${Delete_product}                products/id

*** Keywords ***
Excluir o produto ${id}
    &{headers}    Create Dictionary    Content_type=application/json
    ${Delete_product}=    Replace String    ${Delete_product}    id    ${id}
    ${response}=   DELETE    url=${HOST}/${Delete_product}     headers=&{headers}    verify=${False}
    RETURN    ${response}
    
*** Test Cases ***
TC01 - Validar a exclusao do produto específico
    [Tags]    regressivo
    ${retorno_delete}=    Excluir o produto 20
    Should Be True    ${retorno_delete.json()["isDeleted"]}
    Log    ${retorno_delete.json()["isDeleted"]}
 