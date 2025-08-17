import 'package:flutter/material.dart';
import 'package:rool_dice_app/gradient_container.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: GradientSContainer(colors:[
             Color.fromARGB(255, 2, 16, 31),
             Color.fromARGB(255, 4, 37, 69),
             Color.fromARGB(255, 8, 67, 126),
             Color.fromARGB(255, 54, 91, 127)],))));
}
