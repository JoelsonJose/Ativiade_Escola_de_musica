-- SQL-DQL-SELECT

USE `Escola_de_Musica_do_Recife`;

-- 1. Qual o nome da orquestra de cada músico cadastrado?
SELECT
	orq.Nome 'Nome da Orquestra',
    mus.Nome 'Nome do Músico'
FROM
    Musicos mus
INNER JOIN
    Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra;

-- 2. Quais músicos pertencem à 'Orquestra Sinfônica do Recife'?
SELECT
	orq.Nome 'Nome da Orquestra',
    mus.Nome 'Nome do Músico'
FROM
    Musicos mus
INNER JOIN
    Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
WHERE
    orq.Nome = 'Orquestra Sinfônica do Recife';


-- 3. Quais orquestras não possuem nenhum músico cadastrado?
SELECT
    orq.Nome 'Nome da Orquestra',
    COALESCE(mus.Nome,'0') 'Quantidade de Músico'
FROM
    Orquestra orq
LEFT JOIN
    Musicos mus ON orq.idOrquestra = mus.Orquestra_idOrquestra
WHERE
    mus.idMusicos IS NULL;

-- 4. Quantos músicos cada orquestra possui?
SELECT
    orq.Nome 'Nome da Orquestra',
    COUNT(mus.idMusicos) AS 'Quantidade de Músicos'
FROM
    Orquestra orq
INNER JOIN
    Musicos mus ON orq.idOrquestra = mus.Orquestra_idOrquestra
GROUP BY
    orq.Nome;

-- 5. Quais os nomes e instrumentos dos músicos que possuem nível de proficiência 'Alto'?
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

-- 6. Quais instrumentos o músico 'João da Silva' sabe tocar?
SELECT
    mus.Nome 'Nome do Músico',
    ins.Nome 'Instrumento',
    ins.Tipo 'Tipo de Intrumento'
FROM
    Musicos mus
INNER JOIN
    MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos 
INNER JOIN
    Instrumentos ins ON mi.Instrumentos_idInstrumentos = ins.idInstrumentos
WHERE
    mus.Nome = 'João da Silva';

-- 7. Quais músicos da 'SpokFrevo Orquestra' tocam instrumentos do tipo 'Metais'?
SELECT
	orq.nome 'Nome da Orquestra',
    mus.Nome 'Nome do Músico',
    ins.Nome 'Instrumento',
    ins.tipo 'Tipo de Instrumento'
FROM
    Musicos mus
INNER JOIN 
	MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos
INNER JOIN 
	Instrumentos ins ON mi.Instrumentos_idInstrumentos = ins.idInstrumentos
INNER JOIN 
    Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
WHERE
    ins.Tipo = 'Metais' AND orq.Nome = 'SpokFrevo Orquestra';

-- 8. Quais músicos sabem tocar mais de um instrumento?
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

-- 9. Quais músicos brasileiros (nacionalidade 'Brasileira') tocam instrumentos fabricados pela 'Yamaha'?
SELECT
    mus.Nome "Nome do Músico",
    mus.Nacionalidade "Nacionalidade",
    ins.fabricante "Fabricante que Usa"
FROM
    Musicos mus
INNER JOIN
	musicosInstrumentos mi on mi.musicos_idmusicos = mus.idmusicos
INNER JOIN
	instrumentos ins on ins.idinstrumentos = mi.instrumentos_idinstrumentos
WHERE
	mus.Nacionalidade = 'Brasileira' and ins.fabricante = 'Yamaha';

-- 10. Liste as sinfonias do compositor 'Ludwig van Beethoven' e a qual orquestra elas estão associadas no catálogo.
SELECT
    sin.Nome "Nome da Sinfonia",
    orq.Nome "Orquestra Associada",
    sin.compositor "Nome do Compositor"
FROM
    Sinfonia sin
INNER JOIN
    Orquestra orq ON orq.idorquestra = sin.orquestra_idorquestra
WHERE
    sin.Compositor = 'Ludwig van Beethoven';

-- 11. Quais músicos participaram da execução da 'Sinfonia N.º 9 em Ré menor "Coral"'?
SELECT
    mus.Nome "Nome do Músico",
    sin.nome "Nome da Sinfonia"
FROM
    Musicos mus
INNER JOIN
    MusicosFuncaoSinfonia mfs ON mus.idMusicos = mfs.Musicos_idMusicos
INNER JOIN
    Sinfonia sin ON mfs.Sinfonia_idSinfonia = sin.idSinfonia
WHERE
    sin.Nome = 'Sinfonia N.º 9 em Ré menor "Coral"';

-- 12. Qual foi a função de 'Klaus Schmidt' na sinfonia 'Sinfonia N.º 5 em Dó menor'?
SELECT
	mus.nome "Nome do Músico",
    fun.Nome "Nome da Função",
    sin.Nome "Nome Da Sinfonia"
FROM
    Musicos mus
INNER JOIN
	MusicosFuncaoSinfonia mfs ON mfs.musicos_idmusicos = mus.idMusicos
INNER JOIN
    Funcao fun ON fun.idfuncao = mfs.funcao_idfuncao
INNER JOIN
	Sinfonia sin ON sin.idsinfonia = mfs.sinfonia_idsinfonia
WHERE
    mus.nome = 'Klaus Schmidt' and sin.nome = 'Sinfonia N.º 5 em Dó menor';

-- 13. Liste, sem repetição, todas as sinfonias que já tiveram um 'Maestro' em alguma de suas execuções.
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

-- 14. Quais músicos nunca participaram de nenhuma execução de sinfonia registrada?
SELECT
    mus.Nome "Nome do Músico"
FROM
    Musicos mus
LEFT JOIN
    MusicosFuncaoSinfonia mfs ON mus.idMusicos = mfs.Musicos_idMusicos
WHERE
    mfs.Musicos_idMusicos IS NULL;

-- 15. Quantas vezes cada sinfonia foi executada, de acordo com os registros?
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

-- 16. Quais músicos são 'Violinistas' e a qual orquestra eles pertencem?
SELECT
    mus.Nome "Nome do Músico",
    fun.nome "Função do Músico",
    orq.Nome "Nome da Orquestra"
FROM
    Musicos mus
INNER JOIN
    Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN
	Musicosfuncaosinfonia mfs on mfs.musicos_idmusicos = mus.idmusicos
INNER JOIN
	Funcao fun on fun.idfuncao = mfs.funcao_idfuncao
WHERE
	fun.nome = 'Violinista';

-- 17. Liste todos os músicos que iniciaram em uma função a partir de 2024, mostrando o nome do músico, da sinfonia e da função.
SELECT
    mus.Nome "Nome do Músico",
    sin.Nome "Nome da Sinfonia",
    fun.Nome "Função do Músico",
    date_format(mfs.DataInicioFuncao, '%d/%m/%Y') "Data de início" 
FROM
    Musicos mus
INNER JOIN MusicosFuncaoSinfonia mfs ON mus.idMusicos = mfs.Musicos_idMusicos
INNER JOIN Sinfonia sin ON mfs.Sinfonia_idSinfonia = sin.idSinfonia
INNER JOIN Funcao fun ON mfs.Funcao_idFuncao = fun.idFuncao
WHERE
    mfs.DataInicioFuncao >= '2024-01-01';

-- 18. Quais músicos tocam instrumentos de 'Cordas' e pertencem a uma orquestra fundada antes do ano 2000?
SELECT
    mus.Nome "Nome do Músico",
    ins.tipo "Tido de instrumento tocado",
    orq.Nome "Nome da Orquestra",
    date_format(orq.DataCriacao, '%d/%m/%Y') "Data de Criação da Orquestra"
FROM
    Musicos mus
INNER JOIN Orquestra orq ON mus.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN MusicosInstrumentos mi ON mus.idMusicos = mi.Musicos_idMusicos
INNER JOIN Instrumentos ins ON mi.Instrumentos_idInstrumentos = ins.idInstrumentos
WHERE
    ins.Tipo = 'Cordas' AND YEAR(orq.DataCriacao) < 2000;

-- 19. Mostre o nome da orquestra e a média de idade dos seus músicos (baseado na data de nascimento).
SELECT
    orq.Nome "Nome da Orquestra",
    CONCAT(FLOOR(AVG(TIMESTAMPDIFF(YEAR, mus.DataNascimento, CURDATE())))," Anos") "Media de idade dos Músicos"
FROM
    Orquestra orq
INNER JOIN
    Musicos mus ON orq.idOrquestra = mus.Orquestra_idOrquestra
GROUP BY
    orq.Nome;

-- 20. Crie um relatório completo mostrando o nome do músico, o nome da sinfonia, a função desempenhada, a data de início na função e o nome da orquestra do músico.
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