# Banco de Dados: Escola de Música do Recife

Este projeto consiste na criação, modelagem e manipulação de um banco de dados relacional para gerenciar as informações da "Escola de Música do Recife". O sistema foi projetado para armazenar dados sobre orquestras, músicos, instrumentos, sinfonias e as funções que os músicos desempenham em apresentações.

## Autores

  * **Homero Flávio** - *Desenvolvedor do Banco de Dados*
  * **José Allamberg** - *Desenvolvedor do Banco de Dados*
  * **Joelson José** - *Desenvolvedor do Banco de Dados*

-----

## Modelagem do Banco de Dados

A modelagem do banco de dados foi dividida em duas etapas principais: o modelo conceitual, que representa as entidades e relacionamentos do mundo real, e o modelo lógico, que traduz o modelo conceitual em uma estrutura de tabelas e chaves para o banco de dados.

### Modelo Conceitual

O modelo conceitual foca nas principais entidades do sistema e como elas se interligam. As entidades principais são: **Orquestras**, **Musicos**, **Instrumentos**, **Sinfonias** e **FuncoesDosMusicos**.

  * Uma **Orquestra** `(1,1)` pode ter um ou vários **Musicos** `(1,n)`.
  * Um **Musico** `(1,n)` pode tocar um ou vários **Instrumentos** `(1,n)`. A relação "Tocar" possui um atributo "Nível de Proeficiência".
  * Uma **Orquestra** `(1,n)` pode executar uma ou várias **Sinfonias** `(1,n)`.
  * Um **Musico** `(1,n)` pode exercer uma ou várias **FuncoesDosMusicos** `(1,n)`. A relação "Exercer" possui o atributo "Data".

### Modelo Lógico

O modelo lógico representa a estrutura do banco de dados em tabelas, com suas respectivas colunas, tipos de dados e relacionamentos através de chaves primárias e estrangeiras.

-----

## Dicionário de Dados

| Tabela | Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| **Orquestra** | `idOrquestra` | INT | PK | Identificador único da orquestra. |
| | `Nome` | VARCHAR(100) | | Nome da orquestra. |
| | `Cidade` | VARCHAR(100) | | Cidade sede da orquestra. |
| | `País` | VARCHAR(100) | | País de origem da orquestra. |
| | `DataCriacao` | DATE | | Data de fundação da orquestra. |
| **Musicos** | `idMusicos` | INT | PK | Identificador único do músico. |
| | `Nome` | VARCHAR(150) | | Nome completo do músico. |
| | `CPF` | VARCHAR(14) | | CPF do músico (único). |
| | `DataNascimento` | DATE | | Data de nascimento do músico. |
| | `Nacionalidade` | VARCHAR(100) | | Nacionalidade do músico. |
| | `Orquestra_idOrquestra` | INT | FK | Chave estrangeira para a tabela Orquestra. |
| **Instrumentos**| `idInstrumentos` | INT | PK | Identificador único do instrumento. |
| | `Nome` | VARCHAR(100) | | Nome do instrumento. |
| | `Tipo` | ENUM | | Tipo do instrumento (Cordas, Madeiras, etc.). |
| | `Fabricante` | VARCHAR(100) | | Fabricante do instrumento. |
| **Sinfonia** | `idSinfonia` | INT | PK | Identificador único da sinfonia. |
| | `Nome` | VARCHAR(150) | | Nome da sinfonia. |
| | `Compositor` | VARCHAR(100) | | Nome do compositor da sinfonia. |
| | `DataCriacao` | DATE | | Data de criação da sinfonia. |
| | `Orquestra_idOrquestra` | INT | FK | Chave estrangeira para a tabela Orquestra. |
| **Funcao** | `idFuncao` | INT | PK | Identificador único da função. |
| | `Nome` | VARCHAR(100) | | Nome da função (ex: Maestro, Spalla). |
| | `Descricao` | VARCHAR(255) | | Descrição das atribuições da função. |
| **MusicosInstrumentos** | `Musicos_idMusicos` | INT | PK, FK| Chave estrangeira para a tabela Musicos. |
| | `Instrumentos_idInstrumentos` | INT | PK, FK| Chave estrangeira para a tabela Instrumentos. |
| | `NivelProeficiencia` | ENUM | | Nível de proficiência (Alto, Médio, Baixo). |
| **MusicosFuncaoSinfonia** | `Sinfonia_idSinfonia` | INT | PK, FK| Chave estrangeira para a tabela Sinfonia. |
| | `Funcao_idFuncao` | INT | PK, FK| Chave estrangeira para a tabela Funcao. |
| | `Musicos_idMusicos` | INT | PK, FK| Chave estrangeira para a tabela Musicos. |
| | `DataInicioFuncao` | DATE | | Data de início do músico na função. |
| | `DataFimFuncao` | DATE | | Data de término do músico na função. |

-----

## Scripts SQL

O projeto está organizado em vários scripts SQL, cada um com uma finalidade específica.

### 1\. `SQL-DDL-CREATE.sql`

Este script é responsável por criar todo o esquema do banco de dados `Escola_de_Musica_do_Recife` e suas tabelas (`Orquestra`, `Musicos`, `Sinfonia`, `Funcao`, `Instrumentos`, `MusicosInstrumentos`, `MusicosFuncaoSinfonia`). Define as chaves primárias, estrangeiras e os relacionamentos entre as tabelas.

### 2\. `SQL-DML-INSERT.sql`

Após a criação da estrutura, este script popula o banco de dados com um conjunto inicial de dados. Inclui registros de orquestras, músicos, instrumentos, funções e as relações entre eles, permitindo a realização de consultas e testes.

### 3\. `SQL-DQL-SELECT.sql`

Contém 20 consultas `SELECT` elaboradas para extrair informações relevantes do banco de dados. Essas consultas respondem a perguntas de negócio, como:

  * Quais músicos pertencem a uma determinada orquestra?
  * Quais músicos tocam instrumentos de 'Metais' na 'SpokFrevo Orquestra'?
  * Quais sinfonias foram compostas por 'Ludwig van Beethoven'?
  * Qual a média de idade dos músicos por orquestra?

### 4\. `SQL-DDL-VIEWS.sql`

Este script cria 10 views para simplificar consultas complexas e reutilizáveis. As views fornecem uma camada de abstração sobre as tabelas, facilitando o acesso a dados agregados ou relatórios específicos, como:

  * `V_relatorioCompleto`: Um relatório unificado com informações de músicos, sinfonias e orquestras.
  * `V_mediaIdadeOrquestra`: Calcula a média de idade dos músicos para cada orquestra.
  * `V_musicosTocamMaisDeUmInstrumento`: Lista os músicos que possuem habilidade em mais de um instrumento.
  * `V_quantosMusicosCadaOrquestra`: Mostra a contagem de músicos por orquestra.

### 5\. `SQL-DDL-ALTER.sql`

Demonstra como modificar a estrutura do banco de dados após sua criação. Os exemplos incluem:

  * Adicionar novas colunas (`EmailContato`, `Status`).
  * Modificar o tipo de dado de uma coluna.
  * Renomear uma tabela.
  * Remover uma coluna.

### 6\. `SQL-DML-UPDATE-DELETE.sql`

Contém exemplos de comandos de manipulação de dados para atualizar e deletar registros, como:

  * Corrigir o nome de uma orquestra.
  * Transferir um músico para outra orquestra.
  * Remover a participação de um músico em uma sinfonia.
  * Deletar músicos de uma orquestra específica.

### 7\. `SQL-DDL-DROP.sql`

Script utilitário para limpar o ambiente, removendo todas as views e tabelas criadas no banco de dados.

-----

## Como Utilizar

Para configurar e utilizar o banco de dados, siga a ordem de execução dos scripts abaixo em um cliente MySQL de sua preferência (MySQL Workbench, DBeaver, etc.).

1.  **Criar a Estrutura:**
    Execute o conteúdo do arquivo `SQL-DDL-CREATE.sql` para criar o schema e todas as tabelas.

2.  **Popular o Banco:**
    Execute o conteúdo do arquivo `SQL-DML-INSERT.sql` para inserir os dados iniciais.

3.  **Criar as Views:**
    Execute o conteúdo do arquivo `SQL-DDL-VIEWS.sql` para criar as views de consulta.

4.  **Realizar Consultas:**
    Utilize as consultas prontas no arquivo `SQL-DQL-SELECT.sql` para explorar os dados ou crie suas próprias.

5.  **Testar Modificações (Opcional):**
    Use os scripts `SQL-DDL-ALTER.sql` e `SQL-DML-UPDATE-DELETE.sql` para testar alterações na estrutura e nos dados.

6.  **Limpar o Ambiente:**
    Para remover todas as estruturas criadas, execute o script `SQL-DDL-DROP.sql`.

## Tecnologias Utilizadas

  * **SGBD:** MySQL
  * **Modelagem:** BrModelo
