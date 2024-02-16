import 'package:flutter/material.dart';

class TempHome extends StatelessWidget {
  const TempHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Home'),
      ),
      body: const Center(
        child: Text('This is a temporary home screen'),
      ),
    );
  }
}