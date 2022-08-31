import 'dart:async';
import 'dart:convert';
import 'package:skyrim_alchemy/screens/drawer_screen.dart';

import 'screens/ingredients_screen.dart';
import 'screens/effects_screen.dart';
import 'screens/potions_screen.dart';
import 'utilties/ingredient.dart';
import 'utilties/effect.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Ingredient>> fetchIngredients() async {
  final response = await http.get(Uri.parse(
      'https://howldesign.com/presentations/alchemy/sa_api.php?action=ingredients'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Ingredient> ingredients = (json.decode(response.body) as List)
        .map((data) => Ingredient.fromJson(data))
        .toList();
    return ingredients;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ingredients');
  }
}

Future<List<Effect>> fetchEffects() async {
  final response = await http.get(Uri.parse(
      'https://howldesign.com/presentations/alchemy/sa_api.php?action=effects'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Effect> effects = (json.decode(response.body) as List)
        .map((data) => Effect.fromJson(data))
        .toList();
    return effects;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load effects');
  }
}

void main() => runApp(MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Ingredient>> futureIngredients;
  late Future<List<Effect>> futureEffects;

  @override
  void initState() {
    super.initState();
    futureIngredients = fetchIngredients();
    futureEffects = fetchEffects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Ingredients'),
        ),
        drawer: DrawerScreen(),
        body: IngredientsScreen(futureIngredients));
  }
}
