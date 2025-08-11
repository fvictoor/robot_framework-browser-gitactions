*** Settings ***
Resource    ../resources/base.robot
Documentation    Nesses cenários vamos validar a tela de Login e cadastro no Site
Test Teardown    Take Screenshot    EMBED

*** Test Cases ***
Realizar um cadastro de um usuário comum
    [Documentation]    Nesse cenário vamos estar realizando o cadastro de um usuário comum no site https://front.serverest.dev/login
    [Tags]    frontend     cadastro    positivo
    Abrir navegador                        ${BROWSER_DEFAULT}    ${URL}    ${HEADLESS_DEFAULT}
    Clicar em:                             css=form [data-testid='cadastrar']
    Preencher as informações de cadastro
    Marcar ou Desmarcar Checkbox           css=form [data-testid='checkbox']    unchecked
    Clicar em:                             css=form [data-testid='cadastrar']
    Validar mensagem de cadastro           Cadastro realizado com sucesso

Validar mensagem de erro ao tentar cadastrar um usuário sem nome
    [Documentation]    Nesse cenário vamos estar validando a mensagem de erro ao tentar cadastrar sem informar o nome dele.
    [Tags]    frontend    cadastro    negativo
    Abrir navegador                        ${BROWSER_DEFAULT}    ${URL}    ${HEADLESS_DEFAULT}
    Clicar em:                             css=form [data-testid='cadastrar']
    Preencher as informações de cadastro   NOME=${EMPTY}
    Marcar ou Desmarcar Checkbox           css=form [data-testid='checkbox']    unchecked
    Clicar em:                             css=form [data-testid='cadastrar']
    Validar mensagem de cadastro           Nome é obrigatório

Validar mensagem de erro ao tentar cadastrar um usuário sem email
    [Documentation]    Nesse cenário vamos estar validando a mensagem de erro ao tentar cadastrar sem informar o email dele.
    [Tags]    frontend    cadastro    negativo
    Abrir navegador                        ${BROWSER_DEFAULT}    ${URL}    ${HEADLESS_DEFAULT}
    Clicar em:                             css=form [data-testid='cadastrar']
    Preencher as informações de cadastro   EMAIL=${EMPTY}
    Marcar ou Desmarcar Checkbox           css=form [data-testid='checkbox']    unchecked
    Clicar em:                             css=form [data-testid='cadastrar']
    Validar mensagem de cadastro           Email é obrigatório

Validar mensagem de erro ao tentar cadastrar um usuário sem senha
    [Documentation]    Nesse cenário vamos estar validando a mensagem de erro ao tentar cadastrar um usuário sem informar a senha dele.
    [Tags]    frontend    cadastro    negativo
    Abrir navegador                        ${BROWSER_DEFAULT}    ${URL}    ${HEADLESS_DEFAULT}
    Clicar em:                             css=form [data-testid='cadastrar']
    Preencher as informações de cadastro   SENHA=${EMPTY}
    Marcar ou Desmarcar Checkbox           css=form [data-testid='checkbox']    unchecked
    Clicar em:                             css=form [data-testid='cadastrar']
    Validar mensagem de cadastro           Password é obrigatório