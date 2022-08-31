import 'package:flutter/material.dart';
import 'drawer_screen.dart';

class EffectsScreen extends StatelessWidget {
  const EffectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Effects'),
      ),
      drawer: DrawerScreen(),
      body: const Center(child: Text('Effects')),
    );
  }
}
