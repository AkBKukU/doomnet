/*                                                                           *\
______________________________Patch Information________________________________

Description: Create veiws for getting basic info
Data Integrity: Safe

Required: Yes

\*                                                                           */

DROP VIEW IF EXISTS wad_list;
CREATE VIEW wad_list AS SELECT wads.wad_name,wads.date_added, (SELECT Count(*) FROM wads_played WHERE wads_played.id_wad = wads.id_wad ) as play_count,doom_versions.name from files JOIN mimetypes USING(id_mimetype) JOIN doom_versions USING (id_doom_version)


DROP VIEW IF EXISTS wad_info;
CREATE VIEW wad_info AS SELECT wads.wad_name,wads.date_added,wads.txt,wads.md5,doom_versions.name from files JOIN mimetypes USING(id_mimetype) JOIN doom_versions USING (id_doom_version)
