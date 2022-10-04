DROP DATABASE IF EXISTS `realworld`;
CREATE DATABASE `realworld`;
USE realworld;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT,
    `bio`             varchar(255),
    `image`           varchar(255),
    `password_digest` varchar(255) NOT NULL,
    `username`        varchar(255) NOT NULL,
    `email`           varchar(255) NOT NULL,
    `created_at`      datetime(6),
    `updated_at`      datetime(6),
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_email_uniqueness` (`email`),
    KEY               `idx_created_at` (`created_at`),
    KEY               `idx_updated_at` (`updated_at`),
    KEY               `idx_username` (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT,
    `body`        text         NOT NULL,
    `description` varchar(255) NOT NULL,
    `title`       varchar(255) NOT NULL,
    `slug`        varchar(255) NOT NULL,
    `user_id`     bigint,
    `created_at`  datetime(6),
    `updated_at`  datetime(6),
    PRIMARY KEY (`id`),
    KEY           `idx_created_at` (`created_at`),
    KEY           `idx_updated_at` (`updated_at`),
    KEY           `idx_slug` (`slug`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`
(
    `id`         bigint       NOT NULL AUTO_INCREMENT,
    `body`       varchar(255) NOT NULL,
    `user_id`    bigint,
    `article_id` bigint,
    `created_at` datetime(6),
    `updated_at` datetime(6),
    PRIMARY KEY (`id`),
    KEY          `idx_created_at` (`created_at`),
    KEY          `idx_updated_at` (`updated_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`
(
    `id`         bigint       NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) NOT NULL,
    `created_at` datetime(6),
    `updated_at` datetime(6),
    PRIMARY KEY (`id`),
    KEY          `idx_created_at` (`created_at`),
    KEY          `idx_updated_at` (`updated_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`
(
    `article_id` bigint NOT NULL,
    `tag_id`     bigint NOT NULL,
    PRIMARY KEY (`article_id`, `tag_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `article_favorites`;
CREATE TABLE `article_favorites`
(
    `article_id` bigint NOT NULL,
    `user_id`    bigint NOT NULL,
    PRIMARY KEY (`article_id`, `user_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `user_follows`;
CREATE TABLE `user_follows`
(
    `follower_id` bigint NOT NULL,
    `followee_id` bigint NOT NULL,
    PRIMARY KEY (`follower_id`, `followee_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;