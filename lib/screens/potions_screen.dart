import 'package:flutter/material.dart';

class PotionsScreen extends StatelessWidget {
  const PotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Potions'),
      ),
      body: const Center(child: Text('Potions')),
    );
  }
}
