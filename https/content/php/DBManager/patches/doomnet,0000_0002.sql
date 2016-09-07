/*                                                                           *\
______________________________Patch Information________________________________

Description: Create veiws for getting basic info
Data Integrity: Safe

Required: Yes

\*                                                                           */

DROP VIEW IF EXISTS wad_list;
CREATE VIEW wad_list AS SELECT wads.id_wad, wads.wad_name,wads.date_added, (SELECT Count(*) FROM wads_played WHERE wads_played.id_wad = wads.id_wad ) as play_count,base_game.name from wads JOIN base_game USING(id_base_game);

