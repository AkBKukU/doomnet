/*                                                                           *\
______________________________Patch Information________________________________

Description: Initial database creation
Data Integrity: Destroy All

Required: Yes

\*                                                                           */

SET FOREIGN_KEY_CHECKS = 0;

-- ---
-- Table 'wads'
-- The files containing the levels to be played
-- ---

DROP TABLE IF EXISTS `wads`;
		
CREATE TABLE `wads` (
  `id_wad` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_doom_version` INTEGER NOT NULL DEFAULT NULL,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wad_name` VARCHAR(256) NULL DEFAULT NULL,
  `txt` TEXT NULL DEFAULT NULL,
  `md5` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id_wad`),
KEY (`id_doom_version`)
) COMMENT 'The files containing the levels to be played';

-- ---
-- Table 'users'
-- 
-- ---

DROP TABLE IF EXISTS `users`;
		
CREATE TABLE `users` (
  `id_user` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` VARCHAR(64) NULL DEFAULT NULL,
  `password` VARCHAR(512) NULL DEFAULT NULL,
  `displayname` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id_user`)
);

-- ---
-- Table 'wads_played'
-- Information provided by the user about the play session.
-- ---

DROP TABLE IF EXISTS `wads_played`;
		
CREATE TABLE `wads_played` (
  `id_wad_instance` INTEGER NULL DEFAULT NULL,
  `id_user` INTEGER NULL DEFAULT NULL,
  `id_wad` INTEGER NULL DEFAULT NULL,
  `submitted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` INTEGER NULL DEFAULT NULL,
  `coop_rating` INTEGER NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `hints` TEXT NULL DEFAULT NULL,
  `beatable` INTEGER NULL DEFAULT NULL,
  UNIQUE KEY (`id_user`, `id_wad`)
) COMMENT 'Information provided by the user about the play session.';

-- ---
-- Table 'doom_versions'
-- Data will be:  1. Doom 2. Doom 2 3. Hexen 4. Heretic 5. Strife 6. Other
-- ---

DROP TABLE IF EXISTS `doom_versions`;
		
CREATE TABLE `doom_versions` (
  `id_doom_version` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id_doom_version`)
) COMMENT 'Data will be:  1. Doom 2. Doom 2 3. Hexen 4. Heretic 5. Stri';

-- ---
-- Table 'engines'
-- The different ports of doom to be used. Most likely Zandronum or ZDoom
-- ---

DROP TABLE IF EXISTS `engines`;
		
CREATE TABLE `engines` (
  `id_engine` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(128) NULL DEFAULT NULL,
  `version` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`id_engine`)
) COMMENT 'The different ports of doom to be used. Most likely Zandronu';

-- ---
-- Table 'maps'
-- The possible map names for the versions of doom. Exa Doom 2 would have MAP01, MAP02, etc
-- ---

DROP TABLE IF EXISTS `maps`;
		
CREATE TABLE `maps` (
  `id_map` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_doom_version` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR(16) NULL DEFAULT NULL,
  PRIMARY KEY (`id_map`)
) COMMENT 'The possible map names for the versions of doom. Exa Doom 2 ';

-- ---
-- Table 'group'
-- 
-- ---

DROP TABLE IF EXISTS `group`;
		
CREATE TABLE `group` (
  `id_group` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `group_name` INTEGER NULL DEFAULT NULL,
  `date_created` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_group`)
);

-- ---
-- Table 'group_members'
-- 
-- ---

DROP TABLE IF EXISTS `group_members`;
		
CREATE TABLE `group_members` (
  `id_user` INTEGER NULL DEFAULT NULL,
  `id_group` INTEGER NULL DEFAULT NULL,
  `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY (`id_group`, `id_user`)
);

-- ---
-- Table 'wad_instance'
-- The instance information from the wad being loaded into the engine
-- ---

DROP TABLE IF EXISTS `wad_instance`;
		
CREATE TABLE `wad_instance` (
  `id_wad_instance` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_group_started` INTEGER NULL DEFAULT NULL,
  `id_wad` INTEGER NULL DEFAULT NULL,
  `id_engine` INTEGER NULL DEFAULT NULL,
  `date_run` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `difficulty` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_wad_instance`)
) COMMENT 'The instance information from the wad being loaded into the ';

-- ---
-- Table 'screenshots'
-- 
-- ---

DROP TABLE IF EXISTS `screenshots`;
		
CREATE TABLE `screenshots` (x
  `id_map` INTEGER NULL DEFAULT NULL,
  UNIQUE KEY (`id_wad`, `id_map`)
) COMMENT 'Levels that the wad has as stated by players. Without lookin';

-- ---
-- Table 'wadset'
-- 
-- ---

DROP TABLE IF EXISTS `wadset`;
		
CREATE TABLE `xwadset` (
  `id_wadset` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id_wadset`)
);

-- ---
-- Table 'wad_in_set'
-- 
-- ---

DROP TABLE IF EXISTS `wad_in_set`;
		
CREATE TABLE `wad_in_set` (
  `id_wadset` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_wad` INTEGER NULL DEFAULT NULL,
  UNIQUE KEY (`id_wadset`, `id_wad`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `wads` ADD FOREIGN KEY (id_wad) REFERENCES `wad_in_set` (`id_wad`);
ALTER TABLE `wads` ADD FOREIGN KEY (id_doom_version) REFERENCES `doom_versions` (`id_doom_version`);
ALTER TABLE `wads_played` ADD FOREIGN KEY (id_wad_instance) REFERENCES `wad_instance` (`id_wad_instance`);
ALTER TABLE `wads_played` ADD FOREIGN KEY (id_user) REFERENCES `users` (`id_user`);
ALTER TABLE `wads_played` ADD FOREIGN KEY (id_wad) REFERENCES `wads` (`id_wad`);
ALTER TABLE `maps` ADD FOREIGN KEY (id_doom_version) REFERENCES `doom_versions` (`id_doom_version`);
ALTER TABLE `group_members` ADD FOREIGN KEY (id_user) REFERENCES `users` (`id_user`);
ALTER TABLE `group_members` ADD FOREIGN KEY (id_group) REFERENCES `group` (`id_group`);
ALTER TABLE `wad_instance` ADD FOREIGN KEY (id_group_started) REFERENCES `group` (`id_group`);
ALTER TABLE `wad_instance` ADD FOREIGN KEY (id_wad) REFERENCES `wads` (`id_wad`);
ALTER TABLE `wad_instance` ADD FOREIGN KEY (id_engine) REFERENCES `engines` (`id_engine`);
ALTER TABLE `screenshots` ADD FOREIGN KEY (id_wad_instance) REFERENCES `wad_instance` (`id_wad_instance`);
ALTER TABLE `screenshots` ADD FOREIGN KEY (id_user) REFERENCES `users` (`id_user`);
ALTER TABLE `wad_levels` ADD FOREIGN KEY (id_wad) REFERENCES `wads` (`id_wad`);
ALTER TABLE `wad_levels` ADD FOREIGN KEY (id_map) REFERENCES `maps` (`id_map`);
ALTER TABLE `wadset` ADD FOREIGN KEY (id_wadset) REFERENCES `wad_in_set` (`id_wadset`);


SET FOREIGN_KEY_CHECKS = 1;

