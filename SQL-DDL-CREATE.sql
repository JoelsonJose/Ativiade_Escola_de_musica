-- SQL-DDL-CREATE

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Escola_de_Musica_do_Recife
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Escola_de_Musica_do_Recife` DEFAULT CHARACTER SET utf8 ;
USE `Escola_de_Musica_do_Recife` ;

-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`Orquestra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`Orquestra` (
  `idOrquestra` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Cidade` VARCHAR(100) NOT NULL,
  `País` VARCHAR(100) NOT NULL,
  `DataCriacao` DATE NOT NULL,
  PRIMARY KEY (`idOrquestra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`Sinfonia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`Sinfonia` (
  `idSinfonia` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(150) NOT NULL,
  `Compositor` VARCHAR(100) NOT NULL,
  `DataCriacao` DATE NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`idSinfonia`),
  INDEX `fk_Sinfonia_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Sinfonia_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Orquestra` (`idOrquestra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`Funcao` (
  `idFuncao` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`idFuncao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`Musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`Musicos` (
  `idMusicos` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(150) NOT NULL,
  `CPF` VARCHAR(14) NOT NULL UNIQUE, 
  `DataNascimento` DATE NOT NULL,
  `Nacionalidade` VARCHAR(100) NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`idMusicos`),
  INDEX `fk_Musicos_Orquestra_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Musicos_Orquestra`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Orquestra` (`idOrquestra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`Instrumentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`Instrumentos` (
  `idInstrumentos` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Tipo` ENUM('Cordas', 'Madeiras', 'Metais', 'Percussão') NOT NULL,
  `Fabricante` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idInstrumentos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`MusicosInstrumentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`MusicosInstrumentos` (
  `Musicos_idMusicos` INT NOT NULL,
  `Instrumentos_idInstrumentos` INT NOT NULL,
  `NivelProeficiencia` ENUM('Alto', 'Médio', 'Baixo') NOT NULL,
  PRIMARY KEY (`Musicos_idMusicos`, `Instrumentos_idInstrumentos`),
  INDEX `fk_Musicos_has_Instrumentos_Instrumentos1_idx` (`Instrumentos_idInstrumentos` ASC) VISIBLE,
  INDEX `fk_Musicos_has_Instrumentos_Musicos1_idx` (`Musicos_idMusicos` ASC) VISIBLE,
  CONSTRAINT `fk_Musicos_has_Instrumentos_Musicos1`
    FOREIGN KEY (`Musicos_idMusicos`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Musicos` (`idMusicos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Musicos_has_Instrumentos_Instrumentos1`
    FOREIGN KEY (`Instrumentos_idInstrumentos`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Instrumentos` (`idInstrumentos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escola_de_Musica_do_Recife`.`MusicosFuncaoSinfonia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Escola_de_Musica_do_Recife`.`MusicosFuncaoSinfonia` (
  `Sinfonia_idSinfonia` INT NOT NULL,
  `Funcao_idFuncao` INT NOT NULL,
  `Musicos_idMusicos` INT NOT NULL,
  `DataInicioFuncao` DATE NOT NULL,
  `DataFimFuncao` DATE NULL,
  PRIMARY KEY (`Sinfonia_idSinfonia`, `Funcao_idFuncao`, `Musicos_idMusicos`),
  INDEX `fk_Sinfonia_has_Funcao_Funcao1_idx` (`Funcao_idFuncao` ASC) VISIBLE,
  INDEX `fk_Sinfonia_has_Funcao_Sinfonia1_idx` (`Sinfonia_idSinfonia` ASC) VISIBLE,
  INDEX `fk_Sinfonia_has_Funcao_Musicos1_idx` (`Musicos_idMusicos` ASC) VISIBLE,
  CONSTRAINT `fk_Sinfonia_has_Funcao_Sinfonia1`
    FOREIGN KEY (`Sinfonia_idSinfonia`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Sinfonia` (`idSinfonia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sinfonia_has_Funcao_Funcao1`
    FOREIGN KEY (`Funcao_idFuncao`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Funcao` (`idFuncao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sinfonia_has_Funcao_Musicos1`
    FOREIGN KEY (`Musicos_idMusicos`)
    REFERENCES `Escola_de_Musica_do_Recife`.`Musicos` (`idMusicos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;