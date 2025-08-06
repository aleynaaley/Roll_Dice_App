import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 2, 16, 31),
                const Color.fromARGB(255, 4, 37, 69),
                const Color.fromARGB(255, 8, 67, 126),
                const Color.fromARGB(255, 54, 91, 127)
              ],
            ),
          ),
          child: const Center(child: Text('HELLOO !')),
        ),
      ),
    ),
  );
}
