-- MySQL Script generated by MySQL Workbench
-- mar. 14 mars 2023 00:32:45
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dev
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dev`;

-- -----------------------------------------------------
-- Schema dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dev` DEFAULT CHARACTER SET gb18030;
USE `dev`;

-- -----------------------------------------------------
-- Table `dev`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`user`;

CREATE TABLE IF NOT EXISTS `dev`.`user`
(
    `id`         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(25)      NOT NULL,
    `firstname`  VARCHAR(25)      NOT NULL,
    `email`      VARCHAR(100)     NOT NULL,
    `password`   VARCHAR(75)      NOT NULL,
    `created_at` DATETIME         NOT NULL,
    `updated_at` DATETIME         NULL,
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`artist`;

CREATE TABLE IF NOT EXISTS `dev`.`artist`
(
    `id`         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(25)      NOT NULL,
    `firstname`  VARCHAR(25)      NOT NULL,
    `created_at` DATETIME         NOT NULL,
    `updated_at` DATETIME         NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`album`;

CREATE TABLE IF NOT EXISTS `dev`.`album`
(
    `id`            INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`         VARCHAR(45)      NOT NULL,
    `image_url`     VARCHAR(255)     NOT NULL,
    `released_date` DATETIME         NOT NULL,
    `created_at`    DATETIME         NOT NULL,
    `updated_at`    DATETIME         NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`track`;

CREATE TABLE IF NOT EXISTS `dev`.`track`
(
    `id`         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`      VARCHAR(45)      NOT NULL,
    `album_id`   INT(10) UNSIGNED NOT NULL,
    `nb_views`   INT(10) UNSIGNED NULL DEFAULT 0,
    `image_url`  VARCHAR(255)     NOT NULL,
    `created_at` DATETIME         NOT NULL,
    `updated_at` DATETIME         NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_track_album_idx` (`album_id` ASC) VISIBLE,
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
    CONSTRAINT `fk_track_album`
        FOREIGN KEY (`album_id`)
            REFERENCES `dev`.`album` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`podcast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`podcast`;

CREATE TABLE IF NOT EXISTS `dev`.`podcast`
(
    `id`          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`       VARCHAR(45)      NOT NULL,
    `description` VARCHAR(255)     NULL,
    `image_url`   VARCHAR(255)     NOT NULL,
    `created_at`  DATETIME         NOT NULL,
    `updated_at`  DATETIME         NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`playlist`;

CREATE TABLE IF NOT EXISTS `dev`.`playlist`
(
    `id`          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`       VARCHAR(45)      NOT NULL,
    `description` VARCHAR(255)     NULL,
    `is_public`   TINYINT(1)       NULL DEFAULT 0,
    `user_id`     INT(10) UNSIGNED NOT NULL,
    `image_url`   VARCHAR(255)     NOT NULL,
    `created_at`  DATETIME         NOT NULL,
    `updated_at`  DATETIME         NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_playlist_user_idx` (`user_id` ASC) VISIBLE,
    UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
    CONSTRAINT `fk_playlist_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `dev`.`user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`playlist_has_track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`playlist_has_track`;

CREATE TABLE IF NOT EXISTS `dev`.`playlist_has_track`
(
    `playlist_id` INT(10) UNSIGNED NOT NULL,
    `track_id`    INT(10) UNSIGNED NOT NULL,
    INDEX `fk_playlist_has_track_playlist_idx` (`playlist_id` ASC) VISIBLE,
    INDEX `fk_playlist_has_track_track_idx` (`track_id` ASC) VISIBLE,
    PRIMARY KEY (`playlist_id`, `track_id`),
    CONSTRAINT `fk_playlist_has_track_playlist`
        FOREIGN KEY (`playlist_id`)
            REFERENCES `dev`.`playlist` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_playlist_has_track_track`
        FOREIGN KEY (`track_id`)
            REFERENCES `dev`.`track` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`artist_has_album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`artist_has_album`;

CREATE TABLE IF NOT EXISTS `dev`.`artist_has_album`
(
    `artist_id` INT(10) UNSIGNED NOT NULL,
    `album_id`  INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`artist_id`, `album_id`),
    INDEX `fk_artist_has_album_album_idx` (`album_id` ASC) VISIBLE,
    CONSTRAINT `fk_artist_has_album_artist`
        FOREIGN KEY (`artist_id`)
            REFERENCES `dev`.`artist` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_artist_has_album_album`
        FOREIGN KEY (`album_id`)
            REFERENCES `dev`.`album` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`artist_has_podcast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`artist_has_podcast`;

CREATE TABLE IF NOT EXISTS `dev`.`artist_has_podcast`
(
    `artist_id`  INT(10) UNSIGNED NOT NULL,
    `podcast_id` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`artist_id`, `podcast_id`),
    INDEX `fk_artist_has_podcast_podcast_idx` (`podcast_id` ASC) VISIBLE,
    CONSTRAINT `fk_artist_has_podcast_podcast`
        FOREIGN KEY (`podcast_id`)
            REFERENCES `dev`.`podcast` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_artist_has_podcast_artist`
        FOREIGN KEY (`artist_id`)
            REFERENCES `dev`.`artist` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`notification_content_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`notification_content_type`;

CREATE TABLE IF NOT EXISTS `dev`.`notification_content_type`
(
    `notification_content_type_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`                         VARCHAR(25)      NOT NULL,
    `created_at`                   DATETIME         NOT NULL,
    `updated_at`                   DATETIME         NULL,
    PRIMARY KEY (`notification_content_type_id`),
    UNIQUE INDEX `notification_content_type_id_UNIQUE` (`notification_content_type_id` ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`notification`;

CREATE TABLE IF NOT EXISTS `dev`.`notification`
(
    `id`                           INT(10) UNSIGNED                                            NOT NULL AUTO_INCREMENT,
    `notification_content_type_id` INT(10) UNSIGNED                                            NOT NULL,
    `description`                  VARCHAR(255)                                                NULL,
    `type`                         ENUM ('recommendation', 'new content', 'sharing', 'update') NOT NULL,
    `validated_at`                 DATETIME                                                    NOT NULL,
    `created_at`                   DATETIME                                                    NOT NULL,
    `updated_at`                   DATETIME                                                    NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `notification_id_UNIQUE` (`id` ASC, `notification_content_type_id` ASC) VISIBLE,
    INDEX `fk_notification_notification_content_type_idx` (`notification_content_type_id` ASC) VISIBLE,
    CONSTRAINT `fk_notification_notification_content_type`
        FOREIGN KEY (`notification_content_type_id`)
            REFERENCES `dev`.`notification_content_type` (`notification_content_type_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`album_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`album_notification`;

CREATE TABLE IF NOT EXISTS `dev`.`album_notification`
(
    `notification_id`              INT(10) UNSIGNED NOT NULL,
    `notification_content_type_id` INT(10) UNSIGNED NOT NULL,
    `album_id`                     INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`notification_id`),
    INDEX `fk_album_notification_album_idx` (`album_id` ASC) VISIBLE,
    INDEX `fk_album_notification_notification_idx` (`notification_id` ASC, `notification_content_type_id` ASC) VISIBLE,
    CONSTRAINT `fk_album_notification_album`
        FOREIGN KEY (`album_id`)
            REFERENCES `dev`.`album` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_album_notification_notification`
        FOREIGN KEY (`notification_id`, `notification_content_type_id`)
            REFERENCES `dev`.`notification` (`id`, `notification_content_type_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`playlist_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`playlist_notification`;

CREATE TABLE IF NOT EXISTS `dev`.`playlist_notification`
(
    `notification_id`              INT(10) UNSIGNED NOT NULL,
    `notification_content_type_id` INT(10) UNSIGNED NOT NULL,
    `playlist_id`                  INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`notification_id`),
    UNIQUE INDEX `notification_id_notification_type_id_UNIQUE` (`notification_id` ASC, `notification_content_type_id` ASC) VISIBLE,
    INDEX `fk_playlist_notification_playlist_idx` (`playlist_id` ASC) VISIBLE,
    CONSTRAINT `fk_playlist_notification_playlist`
        FOREIGN KEY (`playlist_id`)
            REFERENCES `dev`.`playlist` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_playlist_notification_notification`
        FOREIGN KEY (`notification_id`, `notification_content_type_id`)
            REFERENCES `dev`.`notification` (`id`, `notification_content_type_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`track_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`track_notification`;

CREATE TABLE IF NOT EXISTS `dev`.`track_notification`
(
    `notification_id`              INT(10) UNSIGNED NOT NULL,
    `notification_content_type_id` INT(10) UNSIGNED NOT NULL,
    `track_id`                     INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`notification_id`),
    INDEX `fk_track_notification_track_idx` (`track_id` ASC) VISIBLE,
    INDEX `fk_track_notification_notification_idx` (`notification_id` ASC, `notification_content_type_id` ASC) VISIBLE,
    CONSTRAINT `fk_track_notification_track`
        FOREIGN KEY (`track_id`)
            REFERENCES `dev`.`track` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_track_notification_notification`
        FOREIGN KEY (`notification_id`, `notification_content_type_id`)
            REFERENCES `dev`.`notification` (`id`, `notification_content_type_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`podcast_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`podcast_notification`;

CREATE TABLE IF NOT EXISTS `dev`.`podcast_notification`
(
    `notification_id`              INT(10) UNSIGNED NOT NULL,
    `notification_content_type_id` INT(10) UNSIGNED NOT NULL,
    `podcast_id`                   INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`notification_id`),
    INDEX `fk_podcast_notification_podcast_idx` (`podcast_id` ASC) VISIBLE,
    INDEX `fk_podcast_notification_notification_idx` (`notification_id` ASC, `notification_content_type_id` ASC) VISIBLE,
    CONSTRAINT `fk_podcast_notification_podcast`
        FOREIGN KEY (`podcast_id`)
            REFERENCES `dev`.`podcast` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_podcast_notification_notification`
        FOREIGN KEY (`notification_id`, `notification_content_type_id`)
            REFERENCES `dev`.`notification` (`id`, `notification_content_type_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dev`.`user_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dev`.`user_notification`;

CREATE TABLE IF NOT EXISTS `dev`.`user_notification`
(
    `id`              INT(10)             NOT NULL AUTO_INCREMENT,
    `user_id`         INT(10) UNSIGNED    NOT NULL,
    `notification_id` INT(10) UNSIGNED    NOT NULL,
    `is_read`         TINYINT(1) UNSIGNED NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    INDEX `fk_user_notification_user_idx` (`user_id` ASC) VISIBLE,
    INDEX `fk_user_notification_notification_idx` (`notification_id` ASC) VISIBLE,
    CONSTRAINT `fk_user_notification_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `dev`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_user_notification_notification`
        FOREIGN KEY (`notification_id`)
            REFERENCES `dev`.`notification` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
