*** Settings ***

# Importação de Bibliotecas.
Library    Browser
Library    FakerLibrary
Library    Dialogs

# Importação de Recursos.
Resource    ./KeywordsDefaut.robot
Resource    ./LoginKeywords.robot

*** Variables ***

# Definição de variáveis Padrões do Sistema.
${BROWSER_DEFAULT}    chromium
${HEADLESS_DEFAULT}   ${True}
${URL}                https://front.serverest.dev/login
${TIMEOUT_DEFAUT}     10s
${DELAY_CLICK}        1s
${DELAY_TEXT}         40ms