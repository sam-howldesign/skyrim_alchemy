<?php
/********
* Spits out Json from the skyrim alchemy database
*********/

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

	$mysqli = new mysqli();
    
	$action = $_REQUEST['action'];
	if ($action === "ingredients"){

		$returnArray = [];
		$result = $mysqli->query("select * from ingredients");
		if ($result){

			while($ingredientDB = $result->fetch_object()){
				$ingredient = new stdClass();
				$ingredient->id = intval($ingredientDB->id);
				$ingredient->name = $ingredientDB->name;
				$ingredient->link = $ingredientDB->link;
				array_push($returnArray, $ingredient);
			}
			echo json_encode($returnArray);
		}else{
			exit;
		}
		
	}elseif ($action === "effects"){

		$returnArray = [];
		$result = $mysqli->query("select * from effects");		
		if ($result){

			while($effectDB = $result->fetch_object()){
				$effect = new stdClass();
				$effect->id = intval($effectDB->id);
				$effect->name = $effectDB->name;
				array_push($returnArray, $effect);
			}
			echo json_encode($returnArray);
		}else{
			exit;
		}
	}elseif ($action === "potions"){
		$effects = $_REQUEST['effects'];
		$ingredients = $_REQUEST['ingredients'];

		//find all potions that have the listed ingredients and the listed effects
		//select * from potions 
		$mysqli->query("");

	}else{
		exit;
	}
	
}else{
	exit;
}


