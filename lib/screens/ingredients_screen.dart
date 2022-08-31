import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import '../utilties/ingredient.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  late Future<List<Ingredient>> ingredients;
  List<int> selectedIndexes = [];

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

  @override
  void initState() {
    super.initState();
    ingredients = fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
      ),
      body: Center(
        child: FutureBuilder<List<Ingredient>>(
          future: ingredients,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];

                  return ListTile(
                    title: Text(item.name),
                    tileColor: (selectedIndexes.contains(index)
                        ? Colors.cyan
                        : Colors.white),
                    onTap: () {
                      selectedIndexes.add(index);
                    },
                    //subtitle: Text(item.link),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
