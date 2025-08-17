import 'package:flutter/material.dart';
import 'package:rool_dice_app/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientSContainer(
          colors: [
            const Color.fromARGB(255, 2, 16, 31),
            const Color.fromARGB(255, 4, 37, 69),
            const Color.fromARGB(255, 8, 67, 126),
            const Color.fromARGB(255, 54, 91, 127),
          ],
        ),
      ),
    ),
  );
}
