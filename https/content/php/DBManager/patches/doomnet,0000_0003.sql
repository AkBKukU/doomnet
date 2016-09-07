/*                                                                           *\
______________________________Patch Information________________________________

Description: Populate Pure Data Tables
Data Integrity: Clears Level and Doom Version tables

Required: Yes
                                                    
\*                                                                           */

DELIMITER //

/*
 * Inserts a new wadset
 */
DROP PROCEDURE IF EXISTS add_wadset;

CREATE PROCEDURE add_wadset ( name_in VARCHAR(256)  )
BEGIN

INSERT INTO wadset ( name ) VALUES
( name_in );

END //


/*
 * Inserts info for a new wad
 */
DROP PROCEDURE IF EXISTS add_wad;

CREATE PROCEDURE add_wad ( id_base_game_in INTEGER , iwad_in TINYINT(1) UNSIGNED, wad_name_in VARCHAR(256) , txt_in TEXT, md5_in VARCHAR(32) )
BEGIN

INSERT INTO wads ( id_base_game, iwad, wad_name, txt, md5 ) VALUES
( id_base_game_in, iwad_in,  wad_name_in, txt_in, md5_in );

END //


/*
 * Inserts info for a new wad
 */
DROP PROCEDURE IF EXISTS add_user;

CREATE PROCEDURE add_user ( username_in VARCHAR(32)  )
BEGIN

INSERT INTO wads ( id_base_game, wad_name, txt, md5 ) VALUES
( id_base_game_in, wad_name_in, txt_in, md5_in );

END // 

DELIMITER ;
