<?php
//connect to the DB 
$mysqli = new mysqli();

$ingredients = json_decode(file_get_contents("ingredients.json"));

foreach($ingredients as $ingredient){

    $clean_ingredient = $mysqli->real_escape_string($ingredient->name);
    $result = $mysqli->query("SELECT id FROM ingredients where name = '$clean_ingredient' ");
    if ($result){
        $row = $result->fetch_assoc();
        $ingredient_id = $row['id'];
    }else{
        echo print_r($ingredient, true);
        echo "Didn't find: $clean_ingredient \n";
        continue;
    }
    

    foreach ($ingredient->effects as $effect){
        $clean_effect = $mysqli->real_escape_string($effect);
        $result = $mysqli->query("SELECT id FROM effects where name = '$clean_effect' ");
        if ($result){
            $row = $result->fetch_assoc();
            $effect_id = $row['id'];
            echo "insert into effects_ingredients (effect_id, ingredient_id) values ($effect_id, $ingredient_id);\n";
        }
        
    }
}

