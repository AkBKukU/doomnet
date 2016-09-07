/*                                                                           *\
______________________________Patch Information________________________________

Description: Create veiws for getting basic info
Data Integrity: Safe

Required: Yes

\*                                                                           */

DROP VIEW IF EXISTS wad_list;
CREATE VIEW wad_list AS SELECT wads.id_wad, wads.wad_name,wads.date_added, (SELECT Count(*) FROM wads_played WHERE wads_played.id_wad = wads.id_wad ) AS play_count,base_game.name AS base_game_name FROM wads JOIN base_game USING(id_base_game);

