# DoomNet

This is a project to create a web interface for managing a large set of custom WADs to be loaded with a doom game server. A database will be used to hold information about the WADs including the following:

 - Name
 - MD5 Hash
 - Times played
 - A rating
 - A wadset it belongs to(ex: Master Levels for Doom II, Maximum Doom)

## Current Status `2016-09-09`

The current status of different parts of the project

### Database
    - WAD data: *Mostly Functional*
    - Engine(ex: Zandronum) launch info: *structure defined*
    - User data: *structure defined*
    - Played data: *structure defined*

### Web Interface
    - WAD file upload and access: *Begining implimentation*
    - WAD selection: *not started*
    - WAD loading: *not started*
    - WAD downloading: *working on defining*
    - User login: *Has a good start by reusing old code*
    - User rating: *not started*
    - Server launching: *not started*

## Stage
    - Loginless wad selecting and launching version working: *current goal*
    - Basic login and tracking system
    - Rating system
