import 'package:flutter/material.dart';
import 'package:rool_dice_app/styled_text.dart';

const startAligment = Alignment.topLeft;        //(const )final sabit , var değiştirilebilir olarak kullanılıyor
const endAligment = Alignment.bottomRight;

class GradientSContainer extends StatelessWidget {
  const GradientSContainer({super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
             Color.fromARGB(255, 2, 16, 31),
             Color.fromARGB(255, 4, 37, 69),
             Color.fromARGB(255, 8, 67, 126),
             Color.fromARGB(255, 54, 91, 127),
          ],
          begin: startAligment,
          end: endAligment,
        ),
      ),
      child: const Center(child: StyledText()),
    );
  }
}
