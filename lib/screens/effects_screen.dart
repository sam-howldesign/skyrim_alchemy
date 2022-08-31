import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import '../utilties/effect.dart';

class EffectsScreen extends StatefulWidget {
  const EffectsScreen({super.key});

  State<EffectsScreen> createState() => _EffectsScreenState();
}

class _EffectsScreenState extends State<EffectsScreen> {
  late Future<List<Effect>> effects;
  List<int> selectedIndexes = [];

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
      throw Exception('Failed to load ingredients');
    }
  }

  @override
  void initState() {
    super.initState();
    effects = fetchEffects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
      ),
      body: Center(
        child: FutureBuilder<List<Effect>>(
          future: effects,
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
                      selectedIndexes.contains(index)
                          ? selectedIndexes.remove(index)
                          : selectedIndexes.add(index);
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
