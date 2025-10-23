-- SQL-DDL-DROP

USE `Escola_de_Musica_do_Recife`;

-- -----------------------------------------------------
-- Etapa 1: Drop de todas as Views
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_mediaidadeorquestra`;
DROP VIEW IF EXISTS `v_musicosapartir2024`;
DROP VIEW IF EXISTS `v_musicoscordasorquestrasantes2000`;
DROP VIEW IF EXISTS `v_musicosnenhumaexecucaosinfonia`;
DROP VIEW IF EXISTS `v_musicospossuemproeficienciainstrumento`;
DROP VIEW IF EXISTS `v_musicostocammaisdeuminstrumento`;
DROP VIEW IF EXISTS `v_quantasvezessinfoniaexecutada`;
DROP VIEW IF EXISTS `v_quantosmusicoscadaorquestra`;
DROP VIEW IF EXISTS `v_relatoriocompleto`;
DROP VIEW IF EXISTS `v_sinfoniasmaestroalgumaexecucao`;

-- -----------------------------------------------------
-- Etapa 2: Drop de todas as Tabelas
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicosFuncaoSinfonia`;
DROP TABLE IF EXISTS `MusicosInstrumentos`;
DROP TABLE IF EXISTS `HabilidadeMusical`; -- Adicionado para caso tenha renomeado
DROP TABLE IF EXISTS `Instrumentos`;
DROP TABLE IF EXISTS `Funcao`;
DROP TABLE IF EXISTS `Sinfonia`;
DROP TABLE IF EXISTS `Musicos`;
DROP TABLE IF EXISTS `Orquestra`;
