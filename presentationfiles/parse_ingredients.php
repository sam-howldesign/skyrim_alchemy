<?php

$htmlFile = fopen("skyrimalchemy_index.html", "r");

$insideIngredients = false;

$ingredients = [];

$ingredient = new stdClass();

$uniqueEffects = [];

if ($htmlFile){
    while(($line = fgets($htmlFile)) !== false){
        if ( preg_match('/<ul class=\'ingredient-list\'>/', $line)){
            $insideIngredients = true;
            continue;
        }
        if (preg_match('/<\/ul>/', $line)){
            $insideIngredients = false;
            continue;
        }
        if (!$insideIngredients){
            continue;
        }
    
    
        if (preg_match('/<a class=\'[^\']*\' href=\'([^\']*)\'.*&lt;a href=\'[^\']*\'&gt;([a-zA-Z- ]*)&lt;\/a&gt;.*&lt;a href=\'[^\']*\'&gt;([a-zA-Z- ]*)&lt;\/a&gt;.*&lt;a href=\'[^\']*\'&gt;([a-zA-Z- ]*)&lt;\/a&gt;.*&lt;a href=\'[^\']*\'&gt;([a-zA-Z- ]*)&lt;\/a&gt;/', $line, $matches)){
            $ingredient = new stdClass();
            $ingredient->link = 'http://www.skyrimalchemy.com' . $matches[1];
            $effects = [];
            
            $uniqueEffects[$matches[2]] = 1;
            array_push($effects, $matches[2]);

            $uniqueEffects[$matches[3]] = 1;
            array_push($effects, $matches[3]);
        	
        	$uniqueEffects[$matches[4]] = 1;        	
            array_push($effects, $matches[4]);
            
        	$uniqueEffects[$matches[5]] = 1;
            array_push($effects, $matches[5]);            
                        
            $ingredient->effects = $effects;
        }

        if (preg_match('/^[a-zA-Z\' ]*$/', $line)){
            $ingredient->name = rtrim($line);            
        }

        if (preg_match('/<\/a>/', $line)){
            array_push($ingredients, $ingredient);
        }
    }

    fclose($htmlFile);
}

echo json_encode(array_keys($uniqueEffects));
//echo json_encode($ingredients);