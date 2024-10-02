*** Settings ***
Library    RequestsLibrary

** Test Cases **
Verificar configuração de ambiente
    ${response}    GET   https://dummyjson.com/products    verify=${False}