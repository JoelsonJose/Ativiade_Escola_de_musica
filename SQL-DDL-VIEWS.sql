-- SQL-DDL-VIEWS

USE `Escola_de_Musica_do_Recife`;

-- View 01: Relatório Completo

CREATE OR REPLACE VIEW V_relatorioCompleto AS
SELECT
    mus.Nome "Nome do Músico",
    sin.Nome "Nome da Sinfonia",
    fun.Nome "Função do Músico",
    date_format(mfs.DataInicioFuncao, '%d/%m/%Y') "Data de inicio na função",
    orq.Nome "Nome da Orquestra"
FROM
    MusicosFuncaoSinfonia mfs
INNER JOIN Musicos mus ON mfs.Musicos_idMusicos = mus.idMusicos
INNER JOIN Sinfonia sin ON mfs.Sinfonia_idSinfonia = sin.idSinfonia
INNER JOIN Funcao fun ON mfs.Funcao_idFuncao = fun.idFuncao
INNER JOIN Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
ORDER BY
    mus.Nome;


-- View 02: Relatório da média de idade por orquestra

CREATE OR REPLACE VIEW V_mediaIdadeOrquestra AS
SELECT
    orq.Nome "Nome da Orquestra",
    CONCAT(FLOOR(AVG(TIMESTAMPDIFF(YEAR, mus.DataNascimento, CURDATE())))," Anos") "Media de idade dos Músicos"
FROM
    Orquestra orq
INNER JOIN
    Musicos mus ON orq.idOrquestra = mus.Orquestra_idOrquestra
GROUP BY
    orq.Nome;
    

-- View 03: Relatório dos músicos que iniciaram apartir de 2024

CREATE OR REPLACE VIEW V_musicosapartir2024 AS
SELECT
    mus.Nome "Nome do Músico",
    sin.Nome "Nome da Sinfonia",
    fun.Nome "Função do Músico",
    mfs.DataInicioFuncao "Data de início"
FROM
    Musicos mus
INNER JOIN MusicosFuncaoSinfonia mfs ON mus.idMusicos = mfs.Musicos_idMusicos
INNER JOIN Sinfonia sin ON mfs.Sinfonia_idSinfonia = sin.idSinfonia
INNER JOIN Funcao fun ON mfs.Funcao_idFuncao = fun.idFuncao
WHERE
    mfs.DataInicioFuncao >= '2024-01-01';


-- View 04: Relatório de Músicos que tocam instrumento de cordas e pertencem a uma orquestra fundada antes do ano 2000

CREATE OR REPLACE VIEW V_musicosCordasOrquestrasAntes2000 AS
SELECT
    mus.Nome "Nome do Músico",
    ins.tipo "Tido de instrumento tocado",
    orq.Nome "Nome da Orquestra",
    orq.DataCriacao "Data de Criação da Orquestra"
FROM
    Musicos mus
INNER JOIN Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos
INNER JOIN Instrumentos ins ON mi.Instrumentos_idInstrumentos = ins.idInstrumentos
WHERE
    ins.Tipo = 'Cordas' AND YEAR(orq.DataCriacao) < 2000;


-- View 05: Relatório de quantas vezes cada sinfonia foi executada

CREATE OR REPLACE VIEW V_quantasVezesSinfoniaExecutada AS
SELECT
	sin.idsinfonia "ID da Sinfonia",
    sin.Nome "Nome da Sinfonia",
    COUNT(mfs.Sinfonia_idSinfonia) "Quantidade de vezes que foi executada"
FROM
    Sinfonia sin
INNER JOIN
    MusicosFuncaoSinfonia mfs ON sin.idSinfonia = mfs.Sinfonia_idSinfonia
GROUP BY
    sin.idsinfonia
ORDER BY
    COUNT(mfs.Sinfonia_idSinfonia) DESC;


-- View 06: Relatório de quais músicos nunca participaram de nenhuma execução de sinfonia

CREATE OR REPLACE VIEW V_musicosNenhumaExecucaoSinfonia AS
SELECT
    mus.Nome "Nome do Músico"
FROM
    Musicos mus
LEFT JOIN
    MusicosFuncaoSinfonia mfs ON mus.idMusicos = mfs.Musicos_idMusicos
WHERE
    mfs.Musicos_idMusicos IS NULL;


-- View 07: Relatório de todas as sinfonias que já tiveram um 'Maestro' em alguma de suas execuções.

CREATE OR REPLACE VIEW V_sinfoniasMaestroAlgumaExecucao AS
SELECT 
    sin.Nome "Nome da Sinfonia",
    mus.nome "Nome do Maestro"
FROM
    Sinfonia sin
INNER JOIN
    MusicosFuncaoSinfonia mfs ON mfs.Sinfonia_idSinfonia = sin.idSinfonia
INNER JOIN
    Funcao fun ON fun.idFuncao = mfs.Funcao_idFuncao
INNER JOIN
	Musicos mus ON mus.idMusicos = mfs.Musicos_idMusicos
WHERE
    fun.Nome = 'Maestro'
GROUP BY
	sin.nome, mus.nome;


-- View 08: Relatório de quais músicos sabem tocar mais de um instrumento

CREATE OR REPLACE VIEW V_musicosTocamMaisDeUmInstrumento AS
SELECT
    mus.Nome 'Nome do Músico',
    COUNT(mi.Instrumentos_idInstrumentos) 'Quantidade de Instrumentos proeficientes'
FROM
    Musicos mus
INNER JOIN
    MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos
GROUP BY
    mus.Nome
HAVING
    COUNT(mi.Instrumentos_idInstrumentos) > 1;


-- View 09: Relatório de quais músicos possuem nível de proeficiência 'Alto' em qual instrumento

CREATE OR REPLACE VIEW V_musicosPossuemProeficienciaInstrumento AS
SELECT
    mus.Nome 'Nome do Músico',
    ins.Nome 'Instrumento'
FROM
    Musicos mus
INNER JOIN
    MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos
INNER JOIN
    Instrumentos ins ON mi.Instrumentos_idInstrumentos = ins.idInstrumentos
WHERE
    mi.NivelProeficiencia = 'Alto';

-- -----------------------------------------------------
-- View 10: Relatório de quantos músicos cada orquestra possui
-- -----------------------------------------------------
CREATE OR REPLACE VIEW V_quantosMusicosCadaOrquestra AS
SELECT
    orq.Nome 'Nome da Orquestra',
    COUNT(mus.idMusicos) AS 'Quantidade de Músicos'
FROM
    Orquestra orq
INNER JOIN
    Musicos mus ON orq.idOrquestra = mus.Orquestra_idOrquestra
GROUP BY
    orq.Nome;
