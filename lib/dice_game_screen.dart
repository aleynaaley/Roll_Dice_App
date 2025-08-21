import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rool_dice_app/range_selection_screen.dart';
import 'package:rool_dice_app/background_gradients.dart';

class DiceGameScreen extends StatefulWidget {
  final int minValue;
  final int maxValue;

  const DiceGameScreen({
    super.key,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<DiceGameScreen> createState() => _DiceGameScreenState();
}

class _DiceGameScreenState extends State<DiceGameScreen> {
  late int currentDiceRoll;
  final Random randomizer = Random();
  List<String> backgroundImages = [];
  String currentBackgroundImage = '';
  bool isRolling = false;

  @override
  void initState() {
    super.initState();
    currentDiceRoll = widget.minValue;
    
    // Aralığa göre arka plan görsel listesi al
    backgroundImages = BackgroundManager.getBackgroundsForRange(
      widget.minValue, 
      widget.maxValue
    );
    currentBackgroundImage = backgroundImages[0];
  }

  void rollDice() {
    if (isRolling) return;
    
    setState(() {
      isRolling = true;
    });

    // Rastgele arka plan seç (girilen aralıktan)
    int randomIndex = randomizer.nextInt(backgroundImages.length);
    currentBackgroundImage = backgroundImages[randomIndex];

    // Kısa gecikmeden sonra rolling'i false yap
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isRolling = false;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: rollDice,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(currentBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Üst bilgi çubuğu
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Geri butonu
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const RangeSelectionScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    // Aralık bilgisi
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.minValue} - ${widget.maxValue}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Alt bilgi
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      isRolling ? 'Zar atılıyor...' : 'Ekrana dokunarak zar atın',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}