<?php

require_once('DBManager/class.DBManager.php');

class WadInterface 
{
	private $mysqli;
	private $stmt;

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
		$stmt = $this->mysqli->prepare("call get_id_wadset(?);");
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


}
