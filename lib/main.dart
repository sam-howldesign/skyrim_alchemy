import 'dart:async';
import 'package:skyrim_alchemy/screens/drawer_screen.dart';

import 'screens/ingredients_screen.dart';
import 'utilties/effect.dart';

import 'package:flutter/material.dart';

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
  late Future<List<Effect>> futureEffects;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Skyrim Alchemy'),
        ),
        drawer: DrawerScreen(),
        body: const IngredientsScreen());
  }
}
