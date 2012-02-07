begin;

--CREATE SCHEMA IF NOT EXISTS `aperophp` DEFAULT COLLATE utf8_bin ;

-- -----------------------------------------------------
-- Table `City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `City` ;

CREATE  TABLE IF NOT EXISTS `City` (
  `id` integer NOT NULL primary key autoincrement ,
  `name` VARCHAR(45) NOT NULL )
;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE  TABLE IF NOT EXISTS `User` (
  `id` integer NOT NULL primary key autoincrement ,
  `lastname` VARCHAR(80) NULL ,
  `firstname` VARCHAR(80) NULL ,
  `email` VARCHAR(80) NOT NULL ,
  `token` VARCHAR(64) NULL ,
  `member_id` integer NULL ,
  CONSTRAINT `fk_User_Member`
    FOREIGN KEY (`member_id` )
    REFERENCES `Member` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Member` ;

CREATE  TABLE IF NOT EXISTS `Member` (
  `id` integer NOT NULL primary key autoincrement ,
  `username` VARCHAR(80) NOT NULL ,
  `password` VARCHAR(80) NOT NULL ,
  `active` integer NOT NULL DEFAULT '1' )
;


-- -----------------------------------------------------
-- Table `User_City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User_City` ;

CREATE  TABLE IF NOT EXISTS `User_City` (
  `id_user` integer NOT NULL ,
  `id_city` integer NOT NULL ,
  CONSTRAINT `fk_Utilisateur_Ville_Ville`
    FOREIGN KEY (`id_city` )
    REFERENCES `City` (`id` )
    ON DELETE NO ACTION
   ,
  CONSTRAINT `fk_Utilisateur_Ville_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Drink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drink` ;

CREATE  TABLE IF NOT EXISTS `Drink` (
  `id` integer NOT NULL ,
  `place` VARCHAR(100) NOT NULL ,
  `day` DATE NOT NULL ,
  `hour` integer NOT NULL ,
  `kind` varchar(255) NOT NULL DEFAULT 'drink' ,
  `description` TEXT NOT NULL ,
  `map` VARCHAR(256) NULL ,
  `id_user` integer NOT NULL ,
  `id_city` integer NOT NULL ,
  CONSTRAINT `fk_Aperos_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
   ,
  CONSTRAINT `fk_Aperos_Ville`
    FOREIGN KEY (`id_city` )
    REFERENCES `City` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Drink_Participation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drink_Participation` ;

CREATE  TABLE IF NOT EXISTS `Drink_Participation` (
  `id_drink` integer NOT NULL ,
  `id_user` integer NOT NULL ,
  `percentage` integer NOT NULL ,
  `reminder` integer NOT NULL ,
  CONSTRAINT `fk_Apero_Participation_Apero`
    FOREIGN KEY (`id_drink` )
    REFERENCES `Drink` (`id` )
    ON DELETE NO ACTION
   ,
  CONSTRAINT `fk_Apero_Participation_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Drink_Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drink_Comment` ;

CREATE  TABLE IF NOT EXISTS `Drink_Comment` (
  `id` integer NOT NULL ,
  `created_at` BIGINT NOT NULL ,
  `content` TEXT NOT NULL ,
  `id_drink` integer NOT NULL ,
  `id_user` integer NOT NULL ,
  CONSTRAINT `fk_Apero_Commentaire_Apero`
    FOREIGN KEY (`id_drink` )
    REFERENCES `Drink` (`id` )
    ON DELETE NO ACTION
   ,
  CONSTRAINT `fk_Apero_Commentaire_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Article` ;

CREATE  TABLE IF NOT EXISTS `Article` (
  `id` integer NOT NULL ,
  `created_at` BIGINT NOT NULL ,
  `title` VARCHAR(60) NOT NULL ,
  `content` TEXT NOT NULL ,
  `published` integer  NOT NULL ,
  `id_user` integer NOT NULL ,
  CONSTRAINT `fk_Articles_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
  )
;


-- -----------------------------------------------------
-- Table `Article_Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Article_Comment` ;

CREATE  TABLE IF NOT EXISTS `Article_Comment` (
  `id` integer NOT NULL ,
  `created_at` BIGINT NOT NULL ,
  `content` TEXT NOT NULL ,
  `id_user` integer NOT NULL ,
  `id_article` integer NOT NULL ,
  CONSTRAINT `fk_Article_Commentaire_Utilisateur`
    FOREIGN KEY (`id_user` )
    REFERENCES `User` (`id` )
    ON DELETE NO ACTION
   ,
  CONSTRAINT `fk_Article_Commentaire_Article`
    FOREIGN KEY (`id_article` )
    REFERENCES `Article` (`id` )
    ON DELETE NO ACTION
  )
;


INSERT INTO `City` (`id`, `name`) VALUES (5, 'Bordeaux');
INSERT INTO `City` (`id`, `name`) VALUES (1, 'Lyon');
INSERT INTO `City` (`id`, `name`) VALUES (3, 'Nantes');
INSERT INTO `City` (`id`, `name`) VALUES (4, 'Orléans');
INSERT INTO `City` (`id`, `name`) VALUES (2, 'Paris');
INSERT INTO `City` (`id`, `name`) VALUES (6, 'Toulouse');

commit;
