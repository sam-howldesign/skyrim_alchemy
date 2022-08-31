import 'package:flutter/material.dart';
import 'drawer_screen.dart';

class PotionsScreen extends StatelessWidget {
  const PotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Effects'),
      ),
      drawer: DrawerScreen(),
      body: const Center(child: Text('Potions')),
    );
  }
}
