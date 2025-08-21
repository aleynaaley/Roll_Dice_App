import 'package:flutter/material.dart';

class BackgroundManager {
  // Welcome ve Range Selection için sabit gradient
  static const List<Color> welcomeGradient = [
    Color.fromARGB(255, 2, 16, 31),
    Color.fromARGB(255, 4, 37, 69),
    Color.fromARGB(255, 8, 67, 126),
    Color.fromARGB(255, 54, 91, 127),
  ];

  // Arka plan görsellerinin yolları
  static const List<String> backgroundImages = [
    'assets/images/dice-1.png',
    'assets/images/dice-2.png',
    'assets/images/dice-3.png',
    'assets/images/dice-4.png',
    'assets/images/dice-5.png',
    'assets/images/dice-6.png',
    'assets/images/dice-7.png',
    'assets/images/dice-8.png',
    'assets/images/dice-9.png',
    'assets/images/dice-10.png',
    'assets/images/dice-11.png',
    'assets/images/dice-12.png',
    'assets/images/dice-13.png',
    'assets/images/dice-14.png',
    'assets/images/dice-15.png',
    'assets/images/dice-16.png',
    'assets/images/dice-17.png',
    'assets/images/dice-18.png',
    'assets/images/dice-19.png',
    'assets/images/dice-20.png',
    'assets/images/dice-21.png',
    'assets/images/dice-22.png',
    'assets/images/dice-23.png',
    'assets/images/dice-24.png',
  ];

  
  // Belirli bir aralık için görsel listesi oluştur
  static List<String> getBackgroundsForRange(int minValue, int maxValue) {
    List<String> selectedBackgrounds = [];
    
    for (int i = minValue; i <= maxValue; i++) {
      // dice-1.png, dice-2.png ... dice-24.png
      selectedBackgrounds.add('assets/images/dice-$i.png');
    }
    
    return selectedBackgrounds;
  }
  
  // Fallback için gradient renkler (eğer görsel yüklenmezse)
  static final List<List<Color>> fallbackGradients = [
    [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)],
    [const Color(0xFF0F4C75), const Color(0xFF3282B8), const Color(0xFFBBE1FA)],
    [const Color(0xFF134E5E), const Color(0xFF71B280), const Color(0xFFA8E6CF)],
    [const Color(0xFF8B0000), const Color(0xFFDC143C), const Color(0xFFFFB6C1)],
    [const Color(0xFFFF4500), const Color(0xFFFF6347), const Color(0xFFFFE4B5)],
    [const Color(0xFF004D40), const Color(0xFF00695C), const Color(0xFF4DB6AC)],
    [const Color(0xFF1A237E), const Color(0xFF3F51B5), const Color(0xFF9FA8DA)],
    [const Color(0xFF880E4F), const Color(0xFFE91E63), const Color(0xFFF8BBD9)],
    [const Color(0xFFFF6F00), const Color(0xFFFF8F00), const Color(0xFFFFE082)],
    [const Color(0xFF006064), const Color(0xFF00ACC1), const Color(0xFF80DEEA)],
    [const Color(0xFF33691E), const Color(0xFF689F38), const Color(0xFFDCEDC8)],
    [const Color(0xFFBF360C), const Color(0xFFFF5722), const Color(0xFFFFCCBC)],
    [const Color(0xFF4A148C), const Color(0xFF7B1FA2), const Color(0xFFD1C4E9)],
    [const Color(0xFF01579B), const Color(0xFF0288D1), const Color(0xFFB3E5FC)],
    [const Color(0xFF1B5E20), const Color(0xFF388E3C), const Color(0xFFC8E6C9)],
    [const Color(0xFFF57F17), const Color(0xFFFFEB3B), const Color(0xFFFFF9C4)],
    [const Color(0xFF3E2723), const Color(0xFF5D4037), const Color(0xFFD7CCC8)],
    [const Color(0xFF212121), const Color(0xFF424242), const Color(0xFFE0E0E0)],
    [const Color(0xFF263238), const Color(0xFF455A64), const Color(0xFFCFD8DC)],
    [const Color(0xFF0C0C0C), const Color(0xFF1C1C1C), const Color(0xFF2C2C2C)],
    [const Color(0xFF2D1B69), const Color(0xFF11998E), const Color(0xFF38EF7D)],
    [const Color(0xFF8360C3), const Color(0xFF2EBF91), const Color(0xFFFFE53B)],
    [const Color(0xFFFF0844), const Color(0xFFFFB199), const Color(0xFFFFE53B)],
    [const Color(0xFF654EA3), const Color(0xFFEAAFC8), const Color(0xFFFFE53B)],
  ];
}
