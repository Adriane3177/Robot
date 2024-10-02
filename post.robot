*** Settings ***
Library    RequestsLibrary
Library    String
*** Variables ***
${HOST}     https://dummyjson.com/

# Rota
${Post_add_products}    products/add

*** Keywords ***
Inserir um novo produto   
    [Arguments]     ${title}    ${description}    ${price}    ${branch}
    &{headers}     Create Dictionary    Content_type=application/json
    &{body}        Create Dictionary    title=${title}    description=${description}    price=${price}    branch=${branch}
    ${response}    POST    url=${HOST}/${Post_add_products}    headers=&{headers}    json=&{body}    verify=${False}

*** Test Cases ***
TC01 - Validar a inclusão de produto
   [Tags]    regressivo
   Inserir um novo produto    title=BMW Pencil    description=Caneta    price=10.00    branch=BIC

