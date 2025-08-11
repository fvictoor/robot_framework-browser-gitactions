# 🚀 Automação com Robot Framework + Browser Library

Este projeto demonstra uma esteira de automação de testes ponta a ponta, utilizando **Robot Framework** para testar uma aplicação web de login. O grande diferencial é a integração de relatórios visuais e notificações automáticas, que facilitam a análise dos resultados.

O objetivo é resolver um desafio comum em automação: a dificuldade de visualizar e compartilhar os resultados dos testes de forma clara e rápida. Com as ferramentas deste projeto, geramos um **dashboard interativo**, enviamos notificações via **webhook** e disparamos um **relatório por e-mail**, tudo de forma automatizada e com tecnologias de baixo custo.

---

## ✨ Principais Funcionalidades

* **Automação de Testes Web:** Scripts robustos com Robot Framework e Browser Library.
* **Geração de Dados Falsos:** Utilização da Faker Library para criar dados de teste dinâmicos.
* **Execução Paralela:** Testes mais rápidos com o uso do Pabot para execuções em múltiplas threads.
* **Notificações via Webhook:** Envio de status da execução para canais como Discord ou Slack.
* **Dashboard Interativo:** Geração de um relatório HTML consolidado e visualmente agradável.
* **Relatórios por E-mail:** Envio automático do dashboard para as partes interessadas.
* **Integração com CI/CD:** Preparado para rodar em esteiras de integração contínua como o GitHub Actions.

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Descrição | Documentação |
| :--- | :--- | :--- |
| **Robot Framework** | Framework principal para automação de testes. | [Acessar](https://robotframework.org/?tab=1#getting-started) |
| **Browser Library** | Biblioteca para automação de testes web. | [Acessar](https://marketsquare.github.io/robotframework-browser/Browser.html) |
| **Pabot** | Ferramenta para execução paralela de testes. | [Acessar](https://github.com/mkorpela/pabot) |
| **Faker Library** | Biblioteca para geração de dados dinâmicos. | [Acessar](https://guykisel.github.io/robotframework-faker/) |
| **Jinja2** | Motor de templates para a criação do dashboard. | [Acessar](https://github.com/pallets/jinja) |
| **Pandas** | Biblioteca para manipulação e análise de dados. | [Acessar](https://github.com/pandas-dev/pandas) |
| **Requests** | Biblioteca para realizar requisições HTTP (API). | [Acessar](https://github.com/psf/requests) |
| **python-dotenv** | Gerenciamento de variáveis de ambiente. | [Acessar](https://github.com/theskumar/python-dotenv) |

---

## 🏁 Primeiros Passos

Siga os passos abaixo para configurar e executar o projeto em seu ambiente local.

### 1. Pré-requisitos

Certifique-se de que você tem os seguintes softwares instalados:

* [Python 3.x](https://www.python.org/downloads/)
* [Node.js (versão LTS)](https://nodejs.org/en/download/)

### 2. Instalação das Dependências

Com os pré-requisitos atendidos, instale as bibliotecas Python necessárias com um único comando:

```bash
pip install -U robotframework robotframework-browser robotframework-faker robotframework-pabot requests pandas Jinja2 python-dotenv
```

### 3. Inicialização da Browser Library

Após a instalação, a Browser Library precisa ser inicializada. Este comando fará o download dos binários dos navegadores necessários.

```bash
rfbrowser init
```

---

## ⚙️ Configuração

Antes de executar os testes, é necessário configurar as variáveis de ambiente para as notificações.

### Webhook para Notificações

Para que o status da execução seja enviado, configure a URL do seu webhook no arquivo `.env`.

* **Arquivo:** `libs/report_robotframework_webhook/report/.env`
* **Conteúdo:** 
``` ini
# URL do Webhook
WEBHOOK_URL="SUA URL DO WEBHOOK"

# Tags que o script deve procurar, separadas por vírgula
TAGS="cadastro,positivo,negativo"
```
### Envio de E-mail

Para enviar o dashboard por e-mail, configure as credenciais de uma conta de e-mail (recomenda-se o uso de uma conta dedicada para automação).

* **Arquivo:** `libs/robot_report_email/robot_report_email/.env`
* **Conteúdo:**

```ini
# Configuração do remetente
EMAIL_REMETENTE="seu_email@dominio.com"
EMAIL_SENHA="sua_senha_de_app"
SMTP_SERVIDOR="smtp.gmail.com"
SMTP_PORTA="587"

# Lista de destinatários (separados por vírgula)
EMAIL_DESTINATARIOS="destinatario1@dominio.com,destinatario2@dominio.com"
```

> ⚠️ **Importante:** Para contas do Gmail, é necessário gerar uma **[Senha de App](https://support.google.com/accounts/answer/185833?hl=pt)** para usar no campo `EMAIL_SENHA`.

---

## ▶️ Executando a Suite de Testes

O fluxo de execução foi projetado para ser simples e eficiente.

### Passo 1: Execução Principal dos Testes

Execute todos os testes em paralelo. Os resultados serão salvos no diretório `./log`.

```bash
pabot --testlevelsplit --processes 4 --outputdir ./log --include cadastro .\tests\
```

### Passo 2: Re-execução dos Testes que Falharam (Opcional)

Caso queira re-executar apenas os cenários que falharam na primeira execução, utilize o comando abaixo. Os resultados serão salvos em `./log/rerun`.

```bash
pabot --testlevelsplit --processes 4 --outputdir ./log/rerun --rerunfailed ./log/output.xml .\tests\
```

### Passo 3: Geração do Dashboard

Consolide os resultados da execução principal (e da re-execução, se houver) em um único dashboard.

```bash
python ./libs/robot_report_dashboard/robot_report_dashboard/main.py .\log\output.xml .\log\rerun\output.xml --tags "critico,smoke" --output_dir ".\log" --filename "dashboard_tests.html"
```

* `--tags`: Define quais tags terão destaque no relatório.
* `--output_dir`: Pasta onde o dashboard será salvo.
* `--filename`: Nome do arquivo HTML do dashboard.

### Passo 4: Envio do Relatório por E-mail

Por fim, dispare o e-mail com o dashboard gerado em anexo.

```bash
python .\libs\robot_report_email\robot_report_email\disparador_email.py ./log/dashboard_tests.html
