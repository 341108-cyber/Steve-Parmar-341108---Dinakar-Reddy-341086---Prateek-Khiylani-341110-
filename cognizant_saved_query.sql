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
  `BU_ID` VARCHAR(8) NOT NULL,
  `BU_Name` VARCHAR(20) NOT NULL,
  `Head_AssociateID` VARCHAR(8) NULL DEFAULT NULL,
  PRIMARY KEY (`BU_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`employee` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`employee` (
  `AssociateID` VARCHAR(8) NOT NULL,
  `FullName` VARCHAR(20) NOT NULL,
  `Designation` VARCHAR(20) NULL DEFAULT NULL,
  `BaseLocation` VARCHAR(20) NULL DEFAULT NULL,
  `Email` VARCHAR(20) NULL DEFAULT NULL,
  `CurrentStatus` VARCHAR(20) NULL DEFAULT 'On Bench',
  `BU_ID` VARCHAR(8) NULL DEFAULT NULL,
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
  `AssetTag` VARCHAR(8) NOT NULL,
  `Model` VARCHAR(15) NULL DEFAULT NULL,
  `SerialNum` VARCHAR(15) NULL DEFAULT NULL,
  `AssignedTo_ID` VARCHAR(8) NULL DEFAULT NULL,
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
  `ClientID` VARCHAR(8) NOT NULL,
  `ClientName` VARCHAR(20) NOT NULL,
  `Region` VARCHAR(20) NULL DEFAULT NULL,
  `ContractStatus` VARCHAR(20) NULL DEFAULT 'Active',
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`skill_master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`skill_master` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`skill_master` (
  `SkillID` VARCHAR(8) NOT NULL,
  `SkillName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`SkillID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`employee_skill_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`employee_skill_map` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`employee_skill_map` (
  `MapID` VARCHAR(8) NOT NULL,
  `AssociateID` VARCHAR(8) NULL DEFAULT NULL,
  `SkillID` VARCHAR(8) NULL DEFAULT NULL,
  `ProficiencyLevel` VARCHAR(20) NULL DEFAULT NULL,
  `CertificationStatus` ENUM("COMPLETED", "IN_PROGRESS", "NOT_STARTED") NULL DEFAULT 'NOT_STARTED',
  PRIMARY KEY (`MapID`),
  INDEX `AssociateID` (`AssociateID` ASC) VISIBLE,
  INDEX `SkillID` (`SkillID` ASC) VISIBLE,
  CONSTRAINT `employee_skill_map_ibfk_1`
    FOREIGN KEY (`AssociateID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`),
  CONSTRAINT `employee_skill_map_ibfk_2`
    FOREIGN KEY (`SkillID`)
    REFERENCES `cognizant`.`skill_master` (`SkillID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`leave_request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`leave_request` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`leave_request` (
  `LeaveID` VARCHAR(8) NOT NULL,
  `AssociateID` VARCHAR(8) NOT NULL,
  `StartDate` DATE NULL DEFAULT NULL,
  `EndDate` DATE NULL DEFAULT NULL,
  `LeaveType` VARCHAR(20) NULL DEFAULT NULL,
  `Status` ENUM("APPROVED", "PENDING") NULL DEFAULT 'Pending',
  `ApproverID` VARCHAR(8) NULL DEFAULT NULL,
  PRIMARY KEY (`LeaveID`),
  INDEX `AssociateID` (`AssociateID` ASC) VISIBLE,
  INDEX `ApproverID` (`ApproverID` ASC) VISIBLE,
  CONSTRAINT `leave_request_ibfk_1`
    FOREIGN KEY (`AssociateID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`),
  CONSTRAINT `leave_request_ibfk_2`
    FOREIGN KEY (`ApproverID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`payroll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`payroll` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`payroll` (
  `PaySlipID` VARCHAR(8) NOT NULL,
  `AssociateID` VARCHAR(8) NULL DEFAULT NULL,
  `PayMonth` VARCHAR(15) NULL DEFAULT NULL,
  `Basic_Salary` DECIMAL(10,2) NULL DEFAULT NULL,
  `HRA` DECIMAL(10,2) NULL DEFAULT NULL,
  `Variable_Pay` DECIMAL(8,2) NULL DEFAULT NULL,
  `Deductions` DECIMAL(8,2) NULL DEFAULT NULL,
  `Net_Salary` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`PaySlipID`),
  INDEX `AssociateID` (`AssociateID` ASC) VISIBLE,
  CONSTRAINT `payroll_ibfk_1`
    FOREIGN KEY (`AssociateID`)
    REFERENCES `cognizant`.`employee` (`AssociateID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cognizant`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cognizant`.`project` ;

CREATE TABLE IF NOT EXISTS `cognizant`.`project` (
  `ProjectID` VARCHAR(8) NOT NULL,
  `ProjectName` VARCHAR(20) NOT NULL,
  `ClientID` VARCHAR(8) NULL DEFAULT NULL,
  `BU_ID` VARCHAR(8) NULL DEFAULT NULL,
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
  `AllocID` VARCHAR(8) NOT NULL,
  `AssociateID` VARCHAR(8) NULL DEFAULT NULL,
  `ProjectID` VARCHAR(8) NULL DEFAULT NULL,
  `AllocationDate` DATE NULL DEFAULT NULL,
  `ReleaseDate` DATE NULL DEFAULT NULL,
  `BillingRate_Hourly` DECIMAL(8,2) NULL DEFAULT NULL,
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
