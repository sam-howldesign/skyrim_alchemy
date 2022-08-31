<?php
//read ingredients json
$ingredients = json_decode(file_get_contents("ingredients.json"));

echo "insert into ingredients (name, link) values \n";
//foreach ingredients make an insert statement
foreach ($ingredients as $ingredient){
    echo "('{$ingredient->name}', '{$ingredient->link}'),\n";

}