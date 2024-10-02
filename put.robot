*** Settings ***
Library    RequestsLibrary
Library    String
*** Variables ***
${HOST}     https://dummyjson.com/

# Rota
${Put_products}    products/id

*** Keywords ***
Alterar um produto especifico com o put  
    [Arguments]    ${id}     ${title}    ${price}    ${description}=none    ${branch}=none
    &{headers}     Create Dictionary    Content_type=application/json
    &{body}        Create Dictionary    id=${id}    title=${title}    description=${description}    price=${price}    branch=${branch}
    ${response}    PUT    url=${HOST}/${Put_products}    headers=&{headers}    json=&{body}    verify=${False}
Alterar um produto especifico com o patch
    [Arguments]    ${id}     ${title}    ${description}    ${price}    ${branch}
    &{headers}     Create Dictionary    Content_type=application/json
    &{body}        Create Dictionary    id=${id}    title=${title}    description=${description}    price=${price}    branch=${branch}
    ${response}    PATCH    url=${HOST}/${Put_products}    headers=&{headers}    json=&{body}    verify=${False}


*** Test Cases ***
TC01 - Validar alteração de produto com o put
   [Tags]    regressivo
   Alterar um produto especifico com o put    id=20   title=BMW Pencil 1   price=15.00
TC02 - Validar alteração de produto com o patch
   [Tags]    regressivo
   Alterar um produto especifico com o patch    id=20   title=BMW Pencil   description=Caneta    price=10.00    branch=BIC


