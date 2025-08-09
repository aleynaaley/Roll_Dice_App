import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientSContainer(),
      ),
    ),
  );
}

class GradientSContainer extends StatelessWidget {
  const GradientSContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 2, 16, 31),
            const Color.fromARGB(255, 4, 37, 69),
            const Color.fromARGB(255, 8, 67, 126),
            const Color.fromARGB(255, 54, 91, 127),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'HELLOO !',
          style: TextStyle(color: Colors.grey, fontSize: 28),
        ),
      ),
    );
  }
}
