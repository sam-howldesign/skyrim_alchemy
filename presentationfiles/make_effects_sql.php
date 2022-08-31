<?php
//read effects json
$effects = json_decode(file_get_contents("effects.json"));

echo "insert into effects (name) values \n";
//foreach effect make an insert statement
foreach ($effects as $effect){
    echo "('$effect'),\n";
}