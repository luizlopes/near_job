# README

- [README](#readme)
- [Near Job](#near-job)
  - [Rodando sem Docker](#rodando-sem-docker)
  - [Rodando com Docker](#rodando-com-docker)
  - [Utilizando](#utilizando)
    - [Criando um candidato](#criando-um-candidato)
    - [Buscando ranking de candidatos à vaga](#buscando-ranking-de-candidatos-%C3%A0-vaga)
    - [Criando vagas](#criando-vagas)
    - [Criando pessoas](#criando-pessoas)
    - [Acessando a documentação da API](#acessando-a-documenta%C3%A7%C3%A3o-da-api)
  - [Tecnologias](#tecnologias)
  - [Testes e Cobertura](#testes-e-cobertura)

# Near Job
API para cadastro de pessoas, vagas e candidatos às vagas. A API também oferece um serviço para rankear por compatibilidade de nível e por proximidade os candidatos de uma determinada vaga.

## Rodando sem Docker

Baixe o projeto: 
> $ git clone git@github.com:luizlopes/near_job.git

Prepare o projeto para ser executado:
> $ bin/setup

Rode o projeto:
> $ rails server -p 9000

## Rodando com Docker

Baixe o projeto: 
> $ git clone git@github.com:luizlopes/near_job.git

Builde o projeto:
> $ docker build . -t near_job

Rode o projeto com o docker
> $ docker run -it -p 9000:9000 --rm near_job

## Utilizando

Se você subiu a aplicação com Docker ou se você executou os passos para subir sem o Docker, significa que alguns dados já estão na base para facilitar a utilização. Os cadastros de distâncias entre locais vizinhos (**links**) e o cadastro de fator para faixas de distâncias (**distance_factors**) estarão populados da seguinte maneira:

*links*

| Source  | Target | Distance |
| ------- | ------ | -------- |
| 'A'     | 'B'    | 5        |
| 'B'     | 'C'    | 7        |
| 'B'     | 'D'    | 3        |
| 'C'     | 'E'    | 4        |
| 'D'     | 'E'    | 10       |
| 'D'     | 'F'    | 8        |


*distance factors*

| Initial | Final | Factor |
| ------- | ----- | ------ |
| 0       | 5     | 100    |
| 6       | 10    | 75     |
| 11      | 15    | 50     |
| 16      | 20    | 25     |
| 21      | 999   | 0      |


Os cadastros de vagas (**jobs**) e pessoas (**people**) também possuirão os seguintes dados:

*jobs*

| Id | Company | Title        | Description       | Localization | Level |
| -- | ------- | ------------ | ----------------- | ------------ | ----- |
| 1  | 'ACME'  | 'Engenheiro' | 'Criar engenhocas'| 'A'          | 3     |
| 2  | 'INTEL' | 'Técnico'    | 'Resolver tudo'   | 'A'          | 5     |


*people*

| Id | Name        | Career        | Localization | Level |
| -- | ----------- | ------------- | ------------ | ----- |
| 1  | 'Luiz'      | 'Pedreiro'    | 'C'          | 3     |
| 2  | 'Guilherme' | 'Programador' | 'D'          | 1     |


### Criando um candidato

Para criar um candidato, faça uma chamada POST: localhost:9000/v1/candidaturas 
e o body no seguinte formato: 
{ "id_vaga": 1, "id_pessoa": 1}

### Buscando ranking de candidatos à vaga

Para buscar o ranking de candidatos a uma vaga, faça a seguinte chamada GET: localhost:9000/v1/vagas/:id_da_vaga/candidaturas/ranking * substitua o *:id_da_vaga* pelo o id da vaga que você quiser visualizar.

### Criando vagas

Para criar novas vagas, faça a seguinte chamada POST: localhost:9000/v1/vagas/ 
e o body no seguinte formato:
{ "empresa" : "Nome da empresa", "titulo" : "titulo da vaga", "descricao" : "descricao da vaga", "localizacao" : "A", "nivel": 1 }

### Criando pessoas

Para criar novas pessoas, faça a seguinte chamada POST: localhost:9000/v1/pessoas/
e o body no seguinte formato:
{ "nome" : "Dedé", "profissao" : "comediante", "localizacao" : "E", "nivel": 3 }

### Acessando a documentação da API

Para facilitar o entendimento da API, quais os recursos disponíveis e seus parametros obrigatórios, foi criada uma documentação que pode ser acessada através da URL: localhost:3000/apipie/

## Tecnologias

Esta API foi desenvolvida em Ruby 2.5.1 e Rails 5.2 e utilizou adicionalmente às gem padrões do Rails, as seguintes gems:

RSpec: para os testes
ApiPie: para gerar a documentação
SimpleCov: para cobertura de testes
Rubocop: para garantir a padronização do código

## Testes e Cobertura

Confira a cobertura de testes da API, acessando o arquivo coverage/index.html