-- SQL-DDL-ALTER

-- Script 01: Adiciona a coluna EmailContato na tabela Orquestra
ALTER TABLE `Escola_de_Musica_do_Recife`.`Orquestra` 
ADD COLUMN `EmailContato` VARCHAR(100) NULL AFTER `DataCriacao`;

-- Script 02: Adiciona a coluna Status na tabela Musicos
ALTER TABLE `Escola_de_Musica_do_Recife`.`Musicos` 
ADD COLUMN `Status` ENUM('Ativo', 'Inativo', 'Férias') NOT NULL DEFAULT 'Ativo' AFTER `Orquestra_idOrquestra`;

-- Script 03: Modifica o tamanho da coluna Compositor na tabela Sinfonia
ALTER TABLE `Escola_de_Musica_do_Recife`.`Sinfonia` 
MODIFY COLUMN `Compositor` VARCHAR(200) NOT NULL;

-- Script 04: Renomeia a tabela MusicosInstrumentos para HabilidadeMusical
RENAME TABLE `Escola_de_Musica_do_Recife`.`MusicosInstrumentos` 
TO `Escola_de_Musica_do_Recife`.`HabilidadeMusical`;

-- Script 05: Remove a coluna Fabricante da tabela Instrumentos
ALTER TABLE `Escola_de_Musica_do_Recife`.`Instrumentos` 
DROP COLUMN `Fabricante`;

-- Script 06: Adiciona uma constraint UNIQUE para Nome e DataNascimento em Musicos
ALTER TABLE `Escola_de_Musica_do_Recife`.`Musicos` 
ADD UNIQUE (`Nome`, `DataNascimento`);

-- Script 07: Altera a coluna NivelProeficiencia na tabela HabilidadeMusical (antiga MusicosInstrumentos)
ALTER TABLE `Escola_de_Musica_do_Recife`.`HabilidadeMusical` 
CHANGE COLUMN `NivelProeficiencia` `NivelProficiencia` ENUM('Iniciante', 'Intermediário', 'Avançado') NOT NULL;

-- Script 08: Adiciona a coluna NacionalidadeSinfonia na tabela Sinfonia
ALTER TABLE `Escola_de_Musica_do_Recife`.`Sinfonia` 
ADD COLUMN `NacionalidadeSinfonia` VARCHAR(100) NULL AFTER `DataCriacao`;

-- Script 09: Modifica a coluna `Descricao` de VARCHAR para TEXT na tabela Funcao
ALTER TABLE `Escola_de_Musica_do_Recife`.`Funcao` 
MODIFY COLUMN `Descricao` TEXT NULL;

-- Script 10: Adiciona a coluna Idade na tabela Musicos com cálculo automático
ALTER TABLE `Escola_de_Musica_do_Recife`.`Musicos`
ADD COLUMN `Idade` INT NOT NULL AFTER `DataNascimento`