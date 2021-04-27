
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Scool
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Scool
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Scool` DEFAULT CHARACTER SET utf8 ;
USE `Scool` ;

-- -----------------------------------------------------
-- Table `Scool`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`Students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `date_register` DATETIME NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scool`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`instructors` (
  `instructor_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`instructor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scool`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`Courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `tittle` VARCHAR(255) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `instructor_id` SMALLINT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_Courses_instructors1_idx` (`instructor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_instructors1`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `Scool`.`instructors` (`instructor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scool`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`Enrollment` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  INDEX `fk_Enrollment_Students_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Enrollment_Courses1_idx` (`course_id` ASC) VISIBLE,
  PRIMARY KEY (`course_id`, `student_id`),
  CONSTRAINT `fk_Enrollment_Students`
    FOREIGN KEY (`student_id`)
    REFERENCES `Scool`.`Students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Enrollment_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `Scool`.`Courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scool`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`tags` (
  `tag_id` TINYINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scool`.`course_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Scool`.`course_tags` (
  `course_id` INT NOT NULL,
  `tag_id` TINYINT NOT NULL,
  INDEX `fk_course_tags_Courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_course_tags_tags1_idx` (`tag_id` ASC) VISIBLE,
  PRIMARY KEY (`course_id`, `tag_id`),
  CONSTRAINT `fk_course_tags_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `Scool`.`Courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_tags_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `Scool`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Workbench Synchronization
-- Generated: 2021-04-27 14:50
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Sollo

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `Scool`.`Enrollment` 
DROP FOREIGN KEY `fk_Enrollment_Courses1`;

ALTER TABLE `Scool`.`Courses` 
DROP FOREIGN KEY `fk_Courses_instructors1`;

ALTER TABLE `Scool`.`course_tags` 
DROP FOREIGN KEY `fk_course_tags_Courses1`,
DROP FOREIGN KEY `fk_course_tags_tags1`;

ALTER TABLE `Scool`.`Enrollment` 
ADD COLUMN `coupon` VARCHAR(50) NULL DEFAULT NULL AFTER `price`;

ALTER TABLE `Scool`.`Enrollment` 
DROP FOREIGN KEY `fk_Enrollment_Students`;

ALTER TABLE `Scool`.`Enrollment` ADD CONSTRAINT `fk_Enrollment_Students`
  FOREIGN KEY (`student_id`)
  REFERENCES `Scool`.`Students` (`student_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Enrollment_Courses1`
  FOREIGN KEY (`course_id`)
  REFERENCES `Scool`.`Courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `Scool`.`Courses` 
ADD CONSTRAINT `fk_Courses_instructors1`
  FOREIGN KEY (`instructor_id`)
  REFERENCES `Scool`.`instructors` (`instructor_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `Scool`.`course_tags` 
ADD CONSTRAINT `fk_course_tags_Courses1`
  FOREIGN KEY (`course_id`)
  REFERENCES `Scool`.`Courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_course_tags_tags1`
  FOREIGN KEY (`tag_id`)
  REFERENCES `Scool`.`tags` (`tag_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;