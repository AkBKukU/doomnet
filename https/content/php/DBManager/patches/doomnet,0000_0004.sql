/*                                                                           *\
______________________________Patch Information________________________________

Description: Procedures for getting wad info from the md5
Data Integrity: Data unchanged

Required: Yes
                                                    
\*                                                                           */

-- DELIMITER //


-- Table 'wads'

-- Get
DROP PROCEDURE IF EXISTS get_wad_by_md5;

CREATE PROCEDURE get_wad_by_md5 ( md5_in INTEGER )
BEGIN

SELECT wads.id_wad, wads.date_added, wads.wad_name, wads.txt, wads.md5, wads.id_base_game,base_game.name AS base_game_name 
FROM wads JOIN base_game USING(id_base_game) WHERE wads.md5 = md5_in;

END ;


-- DELIMITER ;
