import 'package:flutter/material.dart';

const startAligment = Alignment.topLeft;        //(const )final sabit , var değiştirilebilir olarak kullanılıyor
const endAligment = Alignment.bottomRight;

class GradientSContainer extends StatelessWidget {
  const GradientSContainer({super.key, required this.colors});

  final List<Color> colors;
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAligment,
          end: endAligment,
        ),
      ),
      child: Center(child: Image.asset('assets/images/bir.png', width: 200, height: 200,)),
    );
  }
}
