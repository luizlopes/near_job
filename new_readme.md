![Ruby](https://github.com/luizlopes/near_job/workflows/Ruby/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/luizlopes/near_job/badge.svg?branch=master)](https://coveralls.io/github/luizlopes/near_job?branch=master)

# README

- [README](#readme)
- [Near Job](#near-job)
  - [Woorking Docker](#rodando-sem-docker)
  - [Rodando com Docker](#rodando-com-docker)
  - [Utilizando](#utilizando)
    - [Criando um candidato](#criando-um-candidato)
    - [Buscando ranking de candidatos à vaga](#buscando-ranking-de-candidatos-%C3%A0-vaga)
    - [Criando vagas](#criando-vagas)
    - [Criando pessoas](#criando-pessoas)
    - [Acessando a documentação da API](#acessando-a-documenta%C3%A7%C3%A3o-da-api)
  - [Tecnologias](#tecnologias)
  - [Funcionamento](#funcionamento)
  - [Testes e Cobertura](#testes-e-cobertura)

# Near Job
API for people registration, job vacancies and job applicants with score. The API also offers a service for ranking job applications by level, location and professional background matching (new).

## Running
### Working without Docker

Clone project:
> $ git clone git@github.com:luizlopes/near_job.git

Setup:
> $ bin/setup

Run:
> $ rails server -p 9000

### Working with Docker

Clone project:
> $ git clone git@github.com:luizlopes/near_job.git

Build docker image:
> $ docker compose buid

Run:
> $ docker compose up app

## The data

The API data starts with

### links (neighbors distances)

| Source  | Target | Distance |
| ------- | ------ | -------- |
| 'A'     | 'B'    | 5        |
| 'B'     | 'C'    | 7        |
| 'B'     | 'D'    | 3        |
| 'C'     | 'E'    | 4        |
| 'D'     | 'E'    | 10       |
| 'D'     | 'F'    | 8        |


### distance factors (the factor is used for score calculation)

| Initial | Final | Factor |
| ------- | ----- | ------ |
| 0       | 5     | 100    |
| 6       | 10    | 75     |
| 11      | 15    | 50     |
| 16      | 20    | 25     |
| 21      | 999   | 0      |


### jobs (job vacancies)

| Id | Company | Title        | Description       | Localization | Level |
| -- | ------- | ------------ | ----------------- | ------------ | ----- |
| 1  | 'ACME'  | 'Engenheiro' | 'Criar engenhocas'| 'A'          | 3     |
| 2  | 'INTEL' | 'Técnico'    | 'Resolver tudo'   | 'A'          | 5     |


### people (people)

| Id | Name        | Career        | Localization | Level |
| -- | ----------- | ------------- | ------------ | ----- |
| 1  | 'Luiz'      | 'Pedreiro'    | 'C'          | 3     |
| 2  | 'Guilherme' | 'Programador' | 'D'          | 1     |


## Using

### Applying to a job vacancy

```
POST localhost:9000/v1/candidaturas
{ "id_vaga": 1, "id_pessoa": 1}
```

### Ranking job applicants 

```
GET localhost:9000/v1/vagas/:job-vacancy-id/candidaturas/ranking
```

### Adding job vacancies

```
POST localhost:9000/v1/vagas/
{ "empresa" : "Nome da empresa", "titulo" : "titulo da vaga", "descricao" : "descricao da vaga", "localizacao" : "A", "nivel": 1 }
```

### Adding people pessoas

```
POST localhost:9000/v1/pessoas/
{ "nome" : "Dedé", "profissao" : "comediante", "localizacao" : "E", "nivel": 3 }
````

## API doc

localhost:3000/apipie/

## API stack

Esta API foi desenvolvida em Ruby 2.5.1 e Rails 5.2 e utilizou adicionalmente às gem padrões do Rails, as seguintes gems:

This API was developed with Ruby 2.5.1 and Rails 5.2.5, and the gems:

* RSpec
* ApiPie
* SimpleCov
* Rubocop

## How it works

  *#TODO*

## TODOs
  *#TODO*

## Testes e Cobertura

You can see the tests coverage on the top of this README
