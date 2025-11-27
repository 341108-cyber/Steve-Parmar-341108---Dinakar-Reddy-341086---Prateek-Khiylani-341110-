-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cognizant
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cognizant` ;

-- -----------------------------------------------------
-- Schema cognizant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cognizant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cognizant` ;

-- -----------------------------------------------------
-- Table `cognizant`.`business_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`business_unit` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`business_unit` (
  `BU_ID` INT NOT NULL,
  `BU_Name` VARCHAR(50) NOT NULL,
  `Head_AssociateID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BU_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`employee` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`employee` (
  `AssociateID` INT NOT NULL,
  `FullName` VARCHAR(100) NOT NULL,
  `Designation` VARCHAR(50) NULL DEFAULT NULL,
  `BaseLocation` VARCHAR(50) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `CurrentStatus` VARCHAR(20) NULL DEFAULT 'On Bench',
  `BU_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`AssociateID`),
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE,
  INDEX `BU_ID` (`BU_ID` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`BU_ID`)
    REFERENCES `cognizant`.`business_unit` (`BU_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`asset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`asset` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`asset` (
  `AssetTag` VARCHAR(20) NOT NULL,
  `Model` VARCHAR(50) NULL DEFAULT NULL,
  `SerialNum` VARCHAR(50) NULL DEFAULT NULL,
  `AssignedTo_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`AssetTag`),
  UNIQUE INDEX `SerialNum` (`SerialNum` ASC) VISIBLE,
  UNIQUE INDEX `AssignedTo_ID` (`AssignedTo_ID` ASC) VISIBLE,
  CONSTRAINT `asset_ibfk_1`
    FOREIGN KEY (`AssignedTo_ID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`client` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`client` (
  `ClientID` INT NOT NULL,
  `ClientName` VARCHAR(100) NOT NULL,
  `Region` VARCHAR(20) NULL DEFAULT NULL,
  `ContractStatus` VARCHAR(20) NULL DEFAULT 'Active',
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`project` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`project` (
  `ProjectID` INT NOT NULL,
  `ProjectName` VARCHAR(100) NOT NULL,
  `ClientID` INT NULL DEFAULT NULL,
  `BU_ID` INT NULL DEFAULT NULL,
  `ProjectType` VARCHAR(20) NULL DEFAULT NULL,
  `StartDate` DATE NULL DEFAULT NULL,
  `EndDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`ProjectID`),
  INDEX `ClientID` (`ClientID` ASC) VISIBLE,
  INDEX `BU_ID` (`BU_ID` ASC) VISIBLE,
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`ClientID`)
    REFERENCES `cognizant`.`client` (`ClientID`),
  CONSTRAINT `project_ibfk_2`
    FOREIGN KEY (`BU_ID`)
    REFERENCES `cognizant`.`business_unit` (`BU_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`project_allocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`project_allocation` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`project_allocation` (
  `AllocID` INT NOT NULL,
  `AssociateID` INT NULL DEFAULT NULL,
  `ProjectID` INT NULL DEFAULT NULL,
  `AllocationDate` DATE NULL DEFAULT NULL,
  `ReleaseDate` DATE NULL DEFAULT NULL,
  `BillingRate_Hourly` DECIMAL(10,2) NULL DEFAULT NULL,
  `AllocationType` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`AllocID`),
  INDEX `AssociateID` (`AssociateID` ASC) VISIBLE,
  INDEX `ProjectID` (`ProjectID` ASC) VISIBLE,
  CONSTRAINT `project_allocation_ibfk_1`
    FOREIGN KEY (`AssociateID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`),
  CONSTRAINT `project_allocation_ibfk_2`
    FOREIGN KEY (`ProjectID`)
    REFERENCES `cognizant`.`project` (`ProjectID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
