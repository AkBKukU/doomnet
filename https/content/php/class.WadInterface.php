<?php

require_once('DBManager/class.DBManager.php');

class WadInterface 
{
private $mysqli;
private $stmt;

private $DOOM_START_INDEX = 0;
private $DOOM2_START_INDEX = 36;

public $mapList = 
array(
	"E1M1",												  
	"E1M2",												  
	"E1M3",												  
	"E1M4",												  
	"E1M5",												  
	"E1M6",												  
	"E1M7",												  
	"E1M8",												  
	"E1M9",												  
	"E2M1",												  
	"E2M2",												  
	"E2M3",												  
	"E2M4",												  
	"E2M5",												  
	"E2M6",												  
	"E2M7",												  
	"E2M8",												  
	"E2M9",												  
	"E3M1",												  
	"E3M2",												  
	"E3M3",												  
	"E3M4",												  
	"E3M5",												  
	"E3M6",												  
	"E3M7",												  
	"E3M8",												  
	"E3M9",												  
	"E4M1",												  
	"E4M2",												  
	"E4M3",												  
	"E4M4",												  
	"E4M5",												  
	"E4M6",												  
	"E4M7",												  
	"E4M8",												  
	"E4M9",												  
	"MAP01",												 
	"MAP02",												 
	"MAP03",												 
	"MAP04",												 
	"MAP05",												 
	"MAP06",												 
	"MAP07",												 
	"MAP08",												 
	"MAP09",												 
	"MAP10",												 
	"MAP11",												 
	"MAP12",												 
	"MAP13",												 
	"MAP14",												 
	"MAP15",												 
	"MAP16",												 
	"MAP17",												 
	"MAP18",												 
	"MAP19",												 
	"MAP20",												 
	"MAP21",												 
	"MAP22",												 
	"MAP23",												 
	"MAP24",												 
	"MAP25",												 
	"MAP26",												 
	"MAP27",												 
	"MAP28",												 
	"MAP29", 
	"MAP30",
	"MAP31",
	"MAP32"
);

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


public function addWad($filename)
{
	$SUCCESS = 0;
	$FAIL_UNKNOWN = 1;
	$WAD_ALREADY_EXISTS = 0;

	$wadContents = file_get_contents($_SERVER["DOCUMENT_ROOT"].'/../wads/import/'.$filename);
	$wadHash = md5($wadContents);

	
	$data=false;
	$stmt = $this->mysqli->prepare("call check_wad_md5(?);");
	$error = $this->mysqli->error;
	if($error == "")
	{	
		$stmt->bind_param("s", $wadHash);
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

	if($data)
	{
		// Wad is new
		$wadMaps = $this->parseFile($wadContents);
		$txtfilename = str_ireplace(".wad", ".txt", $filename);
		// if file exsists 

	}

}
private function parseFile($fileData)
{																				
	// Start map index at E1M1											   
	$mapIndex = $this->DOOM_START_INDEX;								 
	$isDoom1 = false; // Use to skip checking for doom 2 maps
	$foundMaps;
																			 
	// Check for doom 1 first map											
	if ( strpos($fileData,$this->mapList[$this->DOOM_START_INDEX]) !== false )
	{																		
		// Put map into found list									   
		$foundMaps[] = $this->mapList[$this->DOOM_START_INDEX];		
																		 
		// Mark wad as a doom 1 wad										 
		$isDoom1 = true;												  
																		 
		// Move to look for E1M2										 
		$mapIndex++;													  
	}																		
																				 
	// Check for doom 2 first map											
	if (																	 
		!$isDoom1 &&													  
		strpos($fileData,$this->mapList[$this->DOOM2_START_INDEX]) !== false 
	)
	{																		
		// Put map into found list									   
		$foundMaps[] = $this->mapList[$this->DOOM2_START_INDEX];		
																				 
		// Move to look for MAP02										
		$mapIndex = $this->DOOM2_START_INDEX + 1;						
	}																		
																				 
	// Go through standard map names and search for them.					
	$mapCount = count($this->mapList);
	for (; $mapIndex < $mapCount;$mapIndex++)						
	{																		
		// Exit if wad is for doom 1 and have tested all levels		  
		if ( $isDoom1 && $mapIndex > $this->DOOM2_START_INDEX )		   
		{																
			break;												   
		}																
																			 
		// Look for next level in wad									
		if ( strpos($fileData,$this->mapList[$mapIndex]) !== false )
		{																
			$foundMaps[] = $this->mapList[$mapIndex];			 
		}																
	}					

	return $foundMaps;
} 

}
