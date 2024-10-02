*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}     https://dummyjson.com/

# Rotas
${Get_all_products}                    products
${Get_a_single_product}                products/id
${Get_all_products_categories}         products/categories
${Get_products_category_list}          products/category-list
${Get_products_by_a_category}          products/category/descricao

*** Keywords ***
Obter todos os produtos
    &{headers}    Create Dictionary    Content_type=application/json
    ${response}    GET   url=${HOST}/${Get_all_products}    headers=&{headers}    verify=${False}    expected_status=200
Obter o produtos ${id}
    &{headers}    Create Dictionary    Content_type=application/json
    ${Get_a_single_product}=    Replace String    ${Get_a_single_product}    id    ${id}
    ${response}    GET    url=${HOST}/${Get_a_single_product}     headers=&{headers}    verify=${False}    expected_status=200
Obter todas as categorias
    &{headers}    Create Dictionary    Content_type=application/json
    ${response}    GET    url=${HOST}/${Get_all_products_categories}      headers=&{headers}    verify=${False}    expected_status=200
Obter lista de categorias de produtos
    &{headers}    Create Dictionary    Content_type=application/json
    ${response}    GET    url=${HOST}/${Get_products_category_list}       headers=&{headers}    verify=${False}    expected_status=200

Obter categoria por ${descricao}
    &{headers}    Create Dictionary    Content_type=application/json
    ${Get_products_by_a_category}=    Replace String    ${Get_products_by_a_category}     descricao    ${descricao}
    ${response}=   GET    url=${HOST}/${Get_products_by_a_category}       headers=&{headers}    verify=${False}
    RETURN    ${response}

*** Test Cases ***
TC01 - Validar a busca de todos os produtos
    [Tags]    regressivo
    Obter todos os produtos

TC02 - Validar a busca do produto específico
    [Tags]    regressivo
    Obter o produtos 20
 
TC03 - Validar a busca de todas as categorias
    [Tags]    regressivo
    Obter todas as categorias

TC04 - Validar a busca de uma lista de categorias de produtos
    [Tags]    regressivo
    Obter lista de categorias de produtos
 
TC05 - Validar a busca de uma categoria do produto
    [Tags]    regressivo
    ${retorno_pesquisa}=    Obter categoria por smartphones
    Log      ${retorno_pesquisa.status_code} 
    Should Be Equal As Strings    ${retorno_pesquisa.status_code}    ${200}
    Log      ${retorno_pesquisa.json()}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['products'][0]['title']}      iPhone 5s
    Log      ${retorno_pesquisa.json()['products'][0]['title']}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['products'][0]['price']}      199.99
    Log      ${retorno_pesquisa.json()['products'][0]['price']}
    Should Be Equal As Strings    ${retorno_pesquisa.json()['products'][0]['category']}   smartphones
    Log      ${retorno_pesquisa.json()['products'][0]['category']}


 
