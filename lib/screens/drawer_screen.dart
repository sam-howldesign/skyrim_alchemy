import 'package:flutter/material.dart';
import 'package:skyrim_alchemy/screens/ingredients_screen.dart';
import 'package:skyrim_alchemy/screens/effects_screen.dart';
import 'package:skyrim_alchemy/screens/potions_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
              title: const Text('Ingredients'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const IngredientsScreen(),
                ));
              }),
          ListTile(
              title: const Text('Effects'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EffectsScreen(),
                ));
              }),
          ListTile(
              title: const Text('Potions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PotionsScreen(),
                ));
              }),
        ],
      ),
    );
  }
}
