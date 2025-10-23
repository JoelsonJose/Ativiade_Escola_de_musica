-- SQL-DML-UPDATE-DELETE

-- Corrigindo o nome de uma orquestra
UPDATE Orquestra
SET Nome = 'Filarmônica de Nova York'
WHERE idOrquestra = 10;

-- Transferindo um músico para outra orquestra
UPDATE Musicos
SET Orquestra_idOrquestra = 1
WHERE idMusicos = 5;

-- Atualizando o nível de habilidade de um músico em um instrumento
UPDATE musicosinstrumentos
SET NivelProeficiencia = 'Alto'
WHERE Musicos_idMusicos = 3 AND Instrumentos_idInstrumentos = 3;

-- Detalhando uma função 
UPDATE Funcao
SET Descricao = 'Primeiro-violino de uma orquestra, responsável por afinar a orquestra e liderar os naipes de cordas.'
WHERE idFuncao = 2;

-- Atualizando a data de fim de um músico em uma função
UPDATE MusicosFuncaoSinfonia
SET DataFimFuncao = '2025-10-18'
WHERE Musicos_idMusicos = 7 AND Sinfonia_idSinfonia = 1;

-- Padronizando a nacionalidade 'Americana' para 'Norte-americana'
UPDATE Musicos
SET Nacionalidade = 'Norte-americana'
WHERE Nacionalidade = 'Americana';

-- Fazendo ajuste na sede de uma orquestra
UPDATE Orquestra
SET Cidade = 'Recife'
WHERE idOrquestra = 3;

-- Fazendo ajuste na data de criação de uma sinfonia
UPDATE Sinfonia
SET DataCriacao = '1888-11-20'
WHERE idSinfonia = 7;

-- Corrigindo o CPF de músico
UPDATE Musicos
SET CPF = '111.222.333-99'
WHERE idMusicos = 6;

-- Fazendo um ajuste histórico de 10 anos na criação de todas as sinfonias 
UPDATE Sinfonia
SET DataCriacao	 = DATE_ADD(DataCriacao, INTERVAL 10 YEAR)
WHERE YEAR(DataCriacao) >= 1900 AND YEAR(DataCriacao) <= 2000;

-- A uma orquestra entrou de férias 
-- Esse código só vai funcionar se o ALTER (script 2) para adicionar Status na tabela músico já foi implementado
UPDATE Musicos 
SET Status = 'Inativo' 
WHERE Orquestra_idOrquestra = 22;

-- Removendo um músico
DELETE FROM Musicos
WHERE idMusicos = 13;

-- Removendo uma especialidade de instrumento de um músico
DELETE FROM MusicosInstrumentos
WHERE Musicos_idMusicos = 2 AND Instrumentos_idInstrumentos = 1;

-- Removendo uma Sinfonia 
DELETE FROM Sinfonia
WHERE idSinfonia = 16;

-- Removendo a participação de um músico por engano
DELETE FROM MusicosFuncaoSinfonia
WHERE Sinfonia_idSinfonia= 1 AND Musicos_idMusicos= 7;

-- Removendo todos os músicos de uma orquestra
DELETE FROM Musicos
WHERE Orquestra_idOrquestra = 13;

-- Removendo a uma orquestra
DELETE FROM Orquestra
WHERE idOrquestra = 13;

-- Removendo todos os nível de habilidade Baixo
DELETE FROM MusicosInstrumentos
WHERE NivelProeficiencia = 'Baixo';

-- Removendo um instrumento
DELETE FROM Instrumentos
WHERE idInstrumentos = 20;

-- Removendo participações que acabaram antes de 2023
DELETE FROM MusicosFuncaoSinfonia
WHERE DataFimFuncao < '2023-01-01';

-- Removendo todo o histórico de um músico 
DELETE FROM MusicosFuncaoSinfonia
WHERE Musicos_idMusicos = 10;

-- Removnedo todas as sinfonias de um compositor específico.
DELETE FROM Sinfonia
WHERE Compositor = 'Igor Stravinsky';