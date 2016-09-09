<?php

require_once('DBManager/class.DBManager.php');

class WadInterface 
{
private $mysqli;
private $stmt;
private $wadDir;

private $mapRegex = '/MAP[0-9][1-9]|E[1-9]M[1-9]/';

public function __construct()
{
	// Begin sql connection												 
	$this->mysqli = new mysqli(											  
		"localhost",											
		"root",									  
		"password",									  
		"doomnet"
	);
	
	// Error check and Output											   
	if ($this->mysqli->connect_errno) 
	{
		echo "Error: Failed to connect to MySQL(" . $this->mysqli->connect_errno . ") " . $this->mysqli->connect_error;
	}
	
	$this->wadDir = $_SERVER["DOCUMENT_ROOT"].'/../wads/import/';

}


public function getWadsetWads($id_wadset)
{
	$stmt = $this->mysqli->prepare("call get_wadset_wads(?);");
	$error = $this->mysqli->error;
	if($error == "")
	{	
		$stmt->bind_param("s", $id_wadset);
		$stmt->execute();
		$result = $stmt->get_result();
		$stmt->close();
		$data;
		while ($myrow = $result->fetch_assoc()) 
		{
			$data[] = $myrow;
		}

		return $data;
	}else{
		echo $error;
		return false;
	}
	
}


public function checkWad($filename)
{
	$wadData['wad_name'] = $filename;
	$wadContents = file_get_contents($this->wadDir.$filename);
	$wadData['md5'] = md5($wadContents);

	
	$data=false;
	$stmt = $this->mysqli->prepare("call check_wad_md5(?);");
	$error = $this->mysqli->error;
	if($error == "")
	{	
		$stmt->bind_param("s", $wadData['md5']);
		$stmt->execute();
		$result = $stmt->get_result();
		$stmt->close();
		
		if($result->num_rows > 0)
		{
			unset($data);

		}

		while ($myrow = $result->fetch_assoc()) 
		{
			$data[] = $myrow;
		}

	}else{
		echo $error;
		$data = false;
	}

	if(!$data)
	{
		// Wad is new
		$wadData['exists'] = false;
		$wadData['maps'] = $this->parseFile($wadContents);
		$wadData['map_count'] = count($wadData['maps']);
		if($wadData['map_count'])
		{
			if(strpos($wadData['maps'][0],'E') === 0)
			{
				$wadData['base_game'] = 1;
			} else {
				$wadData['base_game'] = 2;
			}
		}

		$txtfilename = str_ireplace(".wad", ".txt", $filename);
		$wadData['txt']= "";
		if(file_exists($this->wadDir.$txtfilename))
		{
			$wadData['txt'] = file_get_contents($this->wadDir.$txtfilename);
		}

		
	} else {
		$wadData['exists'] = true;

		$foundWadInfo = $this->getWadByMD5($wadData['md5']);

		$wadData['id_wad'] = $foundWadInfo[0]['id_wad'];
		$wadData['base_game_name'] = $foundWadInfo[0]['base_game_name'];
		$wadData['txt'] = $foundWadInfo[0]['txt'];

	}
	
	return $wadData;
}


public function getImportWads()
{
	$wadfolder = new DirectoryIterator($this->wadDir);
	foreach( $wadfolder as $entry )
	{	
		if ( ! $entry->isDot() ) 
		{
			if ( $entry->isFile() && strtoupper(pathinfo($entry->getFilename(), PATHINFO_EXTENSION)) == 'WAD' )
			{
				$wadlist[] = $entry->getFilename();
			}
		}
	}

	foreach($wadlist as $wad)
	{
		$wadInfo[] = $this->checkWad($wad);
	}

	return $wadInfo;
}

public function getWadByMD5($md5)
{
	$stmt = $this->mysqli->prepare("call get_wad_by_md5(?);");
	$error = $this->mysqli->error;
	if($error == "")
	{	
		$stmt->bind_param("s", $md5);
		$stmt->execute();
		$result = $stmt->get_result();
		$stmt->close();
		$data;
		while ($myrow = $result->fetch_assoc()) 
		{
			$data[] = $myrow;
		}

		return $data;
	}else{
		echo $error;
		return false;
	}
	
}



private function parseFile($fileData)
{
	preg_match_all($this->mapRegex, $fileData, $matches);
	return $matches[0];
}

}
