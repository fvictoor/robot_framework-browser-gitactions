*** Settings ***
Resource    ../resources/base.robot
Documentation    Nesse arquivo vamos armazenar apenas Keyqords genéricas onde não estão atreladas a nenhuma tela em especifico do sistema, essas keywords podem ser ultilizadas em qualquer teste que necessite de uma ação genérica, como abrir o navegador, clicar em um botão, escrever em um campo, etc.
*** Keywords ***
Abrir navegador
    [Documentation]    Nessa Keyword, criamos um browser onde ele é definido na sua chamada e abrimos a pagina com a URL desejada, temos a variável HEADLES que pode 
    ...                ser True ou False, onde isso possibilita ver o navegador ou deixar ele em segundo plano.
    [Arguments]    ${BROWSER}    ${URL}        ${HEADLESS}
    New Browser    ${BROWSER}    ${HEADLESS}
    New Page       ${URL}
    Wait For Elements State    xpath=//h1[normalize-space()='Login']    
    ...                        state=visible     
    ...                        timeout=${TIMEOUT_DEFAUT}    
    ...                        message=Falha ao carregar a página: o elemento "{selector}" não atingiu o estado "{state}" dentro do tempo limite de {timeout}.

Clicar em:
    [Documentation]   Aguarda até que o elemento identificado esteja visível na tela e, em seguida, realiza o clique com um pequeno atraso.
    [Arguments]    ${SELECTOR}
    Wait For Elements State    ${SELECTOR}
    ...                        state=visible
    ...                        timeout=${TIMEOUT_DEFAUT}
    ...                        message=Falha ao carregar a página: o elemento "{selector}" não atingiu o estado "{state}" dentro do tempo limite de {timeout}.
    Click With Options         ${SELECTOR}
    ...                        delay=${DELAY_CLICK}

Escrever em:
    [Documentation]   Aguarda até que o elemento identificado esteja visível na tela e, em seguida, realiza a escrita do texto com um pequeno atraso.
    [Arguments]    ${SELECTOR}    ${TEXTO}
    Wait For Elements State    ${SELECTOR}
    ...                        state=visible
    ...                        timeout=${TIMEOUT_DEFAUT}
    ...                        message=Falha ao carregar a página: o elemento "{selector}" não atingiu o estado "{state}" dentro do tempo limite de {timeout}.
    Type Text        ${SELECTOR}    ${TEXTO}
    ...                        delay=${DELAY_TEXT}

Marcar ou Desmarcar Checkbox
    [Documentation]     Verifica o estado atual do checkbox localizado por `${seletor}` e executa a ação somente se necessário, evitando interações redundantes.
    ...   `             ${estado_desejado}`: Deve ser 'checked' ou 'unchecked'
    [Arguments]    ${seletor}    ${estado_desejado}
    
    IF    '${estado_desejado}' not in ['checked', 'unchecked']
        Fail    Estado desejado inválido: "${estado_desejado}". Use "checked" ou "unchecked".
    END

    ${estado_atual}=    Get Checkbox State    ${seletor}

    IF    '${estado_desejado}' == 'checked'
        IF    '${estado_atual}' == 'False'
            Check Checkbox    ${seletor}
            Log    Ação: O checkbox '${seletor}' foi MARCADO.
        ELSE
            Log    Nenhuma ação necessária: o checkbox '${seletor}' já está MARCADO.
        END
    ELSE IF    '${estado_desejado}' == 'unchecked'
        IF    '${estado_atual}' == 'True'
            Uncheck Checkbox    ${seletor}
            Log    Ação: O checkbox '${seletor}' foi DESMARCADO.
        ELSE
            Log    Nenhuma ação necessária: o checkbox '${seletor}' já está DESMARCADO.
        END
    END
