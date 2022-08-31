<?php
$mysqli = new mysqli();
$sql = "select id from ingredients";
$result = $mysqli->query($sql);
$ingredients = [];
if ($result){
    while($row = $result->fetch_assoc()){
        $ingredients[] = $row['id'];
    }    
}
$number_of_ingredients = count($ingredients);
$skipList = [];

//make all potions with 2 ingredients
for ($i=0; $i<$number_of_ingredients; $i++){
    for ($j=0; $j<$number_of_ingredients; $j++){
        if ($i == $j){
            //always skip duplicates
            continue;
        }
        if (array_key_exists("$i.$j", $skipList)){
            //we already got this one
            continue;
        }
        $potion_effects = [];
        $first_ingredient_effects = [];
        $second_ingredient_effects = [];

        $sql = "select effect_id, ingredient_id from effects_ingredients where ingredient_id in ({$ingredients[$i]}, {$ingredients[$j]})";
        //echo "running $sql \n";
        $result = $mysqli->query($sql);
        if ($result){
            while($row = $result->fetch_assoc()){
                if ($row['ingredient_id'] == $ingredients[$i]){
                    $first_ingredient_effects[] = $row['effect_id'];
                }else{
                    $second_ingredient_effects[] = $row['effect_id'];
                }
            }
        }else{
            echo "error with $i and $j";
            continue;
        }
        //echo print_r($first_ingredient_effects, true);
        //echo print_r($second_ingredient_effects, true);
        $potion_effects = array_intersect($first_ingredient_effects, $second_ingredient_effects);
        if (count($potion_effects) > 0){
            //intersecting effects make a potion       
            $mysqli->query("insert into potions () values()");     
            echo "\ninsert into potions () values() \n";
            $newPotionId = $mysqli->insert_id;

            $epInsert = "insert into effects_potions (effect_id, potion_id) values ";
            foreach ($potion_effects as $effect_id){
                $epInsert .= "($effect_id, $newPotionId),";
            }
            $epInsert = substr($epInsert,0,-1);//remove trailing comma
            $mysqli->query($epInsert);
            echo $epInsert . "\n";

            $inInsert =  "insert into ingredients_potions (ingredient_id, potion_id) values ";
            $inInsert .=  "({$ingredients[$i]}, $newPotionId),";
            $inInsert .=  "({$ingredients[$j]}, $newPotionId) ";

            $mysqli->query($inInsert);
            echo $inInsert . "\n";

            $skipList["$j.$i"] = 1;//the other combination is now skipped
        }
    }
}



for ($i=0; $i<$number_of_ingredients; $i++){
    for ($j=0; $j<$number_of_ingredients; $j++){
        for ($k=0; $k<$number_of_ingredients; $k++){
            if ($i == $j || $i == $k || $j == $k){
                //always skip duplicates
                continue;
            }
            if (array_key_exists("$i.$j.$k", $skipList)){
                //we already got this one
                continue;
            }
            $potion_effects = [];
            $first_ingredient_effects = [];
            $second_ingredient_effects = [];    
            $third_ingredient_effects = [];

            $sql = "select effect_id, ingredient_id from effects_ingredients where ingredient_id in ({$ingredients[$i]}, {$ingredients[$j]}, {$ingredients[$k]})";

            $result = $mysqli->query($sql);
            if ($result){
                while($row = $result->fetch_assoc()){
                    if ($row['ingredient_id'] == $ingredients[$i]){
                        $first_ingredient_effects[] = $row['effect_id'];
                    }elseif ($row['ingredient_id'] == $ingredients[$j]){
                        $second_ingredient_effects[] = $row['effect_id'];
                    }else{
                        $third_ingredient_effects[] = $row['effect_id'];
                    }
                }
            }else{
                echo "error with $i and $j and $k";
                continue;
            }

            $potion_effects_a = array_intersect($first_ingredient_effects, $second_ingredient_effects);
            $potion_effects_b = array_intersect($first_ingredient_effects, $third_ingredient_effects);
            $potion_effects_c = array_intersect($second_ingredient_effects, $third_ingredient_effects);
            
            if (  
                (count($potion_effects_a) == 0 && count($potion_effects_b) == 0)
                || (count($potion_effects_a) == 0 && count($potion_effects_c) == 0 )
                || (count($potion_effects_b) == 0 && count($potion_effects_c) == 0 )
            ){
                //if a particular ingredient doesn't combine with either of the other 2 then toss this
                continue;
            }
            //TODO: eventually find a way to pull out uneccesary 3rd ingredients when they pop up


            $potion_effects = array_unique(array_merge($potion_effects_a, $potion_effects_b, $potion_effects_c));
            if (count($potion_effects) == 1){
                //handled in 2 ingredient section, skip it
                continue;
            }

            if (count($potion_effects) > 0){
                //$mysqli->query("insert into potions () values()");     
                echo "\ninsert into potions () values() \n";
                $newPotionId = $mysqli->insert_id;
    
                $epInsert = "insert into effects_potions (effect_id, potion_id) values ";
                foreach ($potion_effects as $effect_id){
                    $epInsert .= "($effect_id, $newPotionId),";
                }
                $epInsert = substr($epInsert,0,-1);//remove trailing comma
                //$mysqli->query($epInsert);
                echo $epInsert . "\n";
    
                $inInsert =  "insert into ingredients_potions (ingredient_id, potion_id) values ";
                $inInsert .=  "({$ingredients[$i]}, $newPotionId),";
                $inInsert .=  "({$ingredients[$j]}, $newPotionId), ";
                $inInsert .=  "({$ingredients[$k]}, $newPotionId) ";
    
                //$mysqli->query($inInsert);
                echo $inInsert . "\n";
    
                $skipList["$i.$k.$j"] = 1;//the other combination is now skipped
                $skipList["$j.$i.$k"] = 1;//the other combination is now skipped
                $skipList["$j.$k.$i"] = 1;//the other combination is now skipped
                $skipList["$k.$i.$j"] = 1;//the other combination is now skipped
                $skipList["$k.$j.$i"] = 1;//the other combination is now skipped
            }
        }//end for k
    }//end for j
}//end for i

