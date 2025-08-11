*** Settings ***
Resource         ../resources/base.robot
Documentation    Nesse arquivo vamos armazenar apenas Keyqords envolvendo o processo de Login e Cadastro de usuário no sistema.
*** Keywords ***

Preencher as informações de cadastro
    [Documentation]    Aguarda o carregamento do formulário de cadastro e preenche os campos com dados gerados dinamicamente utilizando a biblioteca FakerLibrary.
    ...                Também registra no log os dados utilizados no preenchimento para rastreabilidade.
    [Arguments]    ${NOME}=aleatórios    ${EMAIL}=aleatórios    ${SENHA}=aleatórios
    Wait For Elements State    xpath=//h2[normalize-space()='Cadastro']
    ...                        state=visible     
    ...                        timeout=10s    
    ...                        message=Falha ao carregar a página: o elemento "{selector}" não atingiu o estado "{state}" dentro do tempo limite de {timeout}.
    # Gerar dados aleatórios se não fornecidos
    ${NOME}=     Run Keyword If    '${NOME}'=='aleatórios'    FakerLibrary.Name
    ...          ELSE IF           '${NOME}'=='${EMPTY}'      Set Variable    ${EMPTY}
    ${EMAIL}=    Run Keyword If    '${EMAIL}'=='aleatórios'   FakerLibrary.Email
    ...          ELSE IF           '${EMAIL}'=='${EMPTY}'     Set Variable    ${EMPTY}
    ${SENHA}=    Run Keyword If    '${SENHA}'=='aleatórios'   FakerLibrary.Password
    ...          ELSE IF           '${SENHA}'=='${EMPTY}'     Set Variable    ${EMPTY}

    Log Many    Informações do Usuário Cadastrados
    ...         Nome: ${NOME}
    ...         E-mail: ${EMAIL}
    ...         Senha: ${SENHA}
    
    Escrever em:    css=form [data-testid='nome']        ${NOME}
    Escrever em:    css=form [data-testid='email']       ${EMAIL}
    Escrever em:    css=form [data-testid='password']    ${SENHA}

Validar mensagem de cadastro
    [Arguments]    ${TEXT}
    Wait For Elements State    css=div.alert-dismissible      
    ...                        state=visible       
    ...                        timeout=10s 

    ${TEXTO_EXIBIDO}    Get Text    css=div.alert-dismissible
    Should Contain    ${TEXTO_EXIBIDO}    ${TEXT}    msg=Texto diferente da validação