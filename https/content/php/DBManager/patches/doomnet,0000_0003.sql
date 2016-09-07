/*                                                                           *\
______________________________Patch Information________________________________

Description: Procedures as get,add,update,delete for wad info tables
Data Integrity: Data unchanged

Required: Yes
                                                    
\*                                                                           */

DELIMITER //


-- Table 'wads'

-- Get
DROP PROCEDURE IF EXISTS get_wad;

CREATE PROCEDURE get_wad ( id_wad_in INTEGER )
BEGIN

SELECT wads.id_wad, wads.date_added, wads.wad_name, wads.txt, wads.md5, wads.id_base_game,base_game.name AS base_game_name 
FROM wads JOIN base_game USING(id_base_game) WHERE wads.id_wad = id_wad_in;

END //

-- Add
DROP PROCEDURE IF EXISTS add_wad;

CREATE PROCEDURE add_wad ( id_base_game_in INTEGER , iwad_in TINYINT(1) UNSIGNED, wad_name_in VARCHAR(256) , txt_in TEXT, md5_in VARCHAR(32) )
BEGIN

INSERT INTO wads ( id_base_game, iwad, wad_name, txt, md5 ) VALUES
( id_base_game_in, iwad_in,  wad_name_in, txt_in, md5_in );

END //

-- Update
DROP PROCEDURE IF EXISTS update_wad;

CREATE PROCEDURE update_wad ( id_wad_in INTEGER, wad_name_in VARCHAR(256) , txt_in TEXT, id_base_game_in INTEGER )
BEGIN

UPDATE wads SET wads.wad_name = wad_name_in, wads.txt = txt_in, wads.id_base_game = id_base_game_in
WHERE wads.id_wad = id_wad_in;

END //

-- Delete
DROP PROCEDURE IF EXISTS delete_wad;

CREATE PROCEDURE delete_wad ( id_wad_in INTEGER )
BEGIN

DELETE FROM wads
WHERE wads.id_wad = id_wad_in;

END //

-- Check MD5
DROP PROCEDURE IF EXISTS check_wad_md5;

CREATE PROCEDURE check_wad_md5 ( md5_in VARCHAR(32) )
BEGIN

SELECT Count(*) AS found FROM wads WHERE wads.md5 = md5_in;

END //







-- wad_levels


-- Get
DROP PROCEDURE IF EXISTS get_wad_level;

CREATE PROCEDURE get_wad_level ( id_wad_in INTEGER )
BEGIN

SELECT wad_levels.id_map FROM wad_levels 
WHERE id_wad = id_wad_in;

END //

-- Add
DROP PROCEDURE IF EXISTS add_wad_level;

CREATE PROCEDURE add_wad_level ( id_wad_in INTEGER , id_map_in INTEGER )
BEGIN

INSERT INTO wad_levels ( id_wad, id_map ) VALUES
( id_wad_in, id_map_in );

END //


-- Delete
DROP PROCEDURE IF EXISTS delete_wad_level;

CREATE PROCEDURE delete_wad_level ( id_wad_in INTEGER , id_map_in INTEGER )
BEGIN

DELETE FROM wad_levels 
WHERE id_wad = id_wad_in AND id_map = id_map_in;

END //




-- wadset

-- Get
DROP PROCEDURE IF EXISTS get_wadset;

CREATE PROCEDURE get_wadset ( id_wadset_in INTEGER )
BEGIN

SELECT * FROM wadset
WHERE id_wadset = id_wadset_in;

END //

-- Add
DROP PROCEDURE IF EXISTS add_wadset;

CREATE PROCEDURE add_wadset ( name_in VARCHAR(256)  )
BEGIN

INSERT INTO wadset ( name ) VALUES
( name_in );

END //


-- Delete
DROP PROCEDURE IF EXISTS delete_wadset;

CREATE PROCEDURE delete_wadset ( id_wadset_in INTEGER )
BEGIN

DELETE FROM wadset
WHERE id_wadset = id_wadset_in;

END //


-- Update
DROP PROCEDURE IF EXISTS update_wadset;

CREATE PROCEDURE update_wadset ( id_wadset_in INTEGER, name_in VARCHAR(256) )
BEGIN

UPDATE wadset SET name = name_in
WHERE id_wadset = id_wadset_in;

END //



-- wad_in_set


-- Get
DROP PROCEDURE IF EXISTS get_wadset_wads;

CREATE PROCEDURE get_wadset_wads ( id_wadset_in INTEGER )
BEGIN

SELECT wad_in_set.id_wad FROM wad_in_set 
WHERE id_wadset = id_wadset_in;

END //

-- Add
DROP PROCEDURE IF EXISTS add_wad_level;

CREATE PROCEDURE add_wad_level ( id_wadset_in INTEGER , id_wad_in INTEGER )
BEGIN

INSERT INTO wad_in_set ( id_wadset, id_wad ) VALUES
( id_wadset_in, id_wad_in );

END //


-- Delete
DROP PROCEDURE IF EXISTS delete_wadset_wad;

CREATE PROCEDURE delete_wadset_wad ( id_wadset_in INTEGER , id_wad_in INTEGER )
BEGIN

DELETE FROM wad_in_set 
WHERE id_wad = id_wad_in AND id_wadset = id_wadset_in;

END //





DELIMITER ;
