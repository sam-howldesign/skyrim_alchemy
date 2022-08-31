import 'package:flutter/material.dart';
import 'drawer_screen.dart';
import '../utilties/ingredient.dart';

class IngredientsScreen extends StatelessWidget {
  final Future<List<Ingredient>> futureIngredients;

  const IngredientsScreen(this.futureIngredients);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Ingredients'),
      ),
      drawer: DrawerScreen(),
      body: Center(
        child: FutureBuilder<List<Ingredient>>(
          future: futureIngredients,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];

                  return ListTile(
                    title: Text(item.name),
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
