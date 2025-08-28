import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rool_dice_app/dice_game_screen.dart';

class RangeSelectionScreen extends StatefulWidget {
  const RangeSelectionScreen({super.key});

  @override
  State<RangeSelectionScreen> createState() => _RangeSelectionScreenState();
}

class _RangeSelectionScreenState extends State<RangeSelectionScreen> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _minController.text = '1';
    _maxController.text = '6';
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      final int minValue = int.parse(_minController.text);
      final int maxValue = int.parse(_maxController.text);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DiceGameScreen(
            minValue: minValue,
            maxValue: maxValue,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/range.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Sol üstte geri butonu
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),

          // Ana içerik
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kaç rakam arasında?',
                      style: GoogleFonts.jaro(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 55),

                    // Min değer
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _minController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          hintText: 'Minimum değer',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        style: const TextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Minimum değer giriniz';
                          }
                          final int? minVal = int.tryParse(value);
                          if (minVal == null || minVal < 1) {
                            return 'En az 1 olmalı';
                          }
                          if (minVal > 24) {
                            return 'En fazla 24 olabilir';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Max değer
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _maxController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          hintText: 'Maksimum değer',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        style: const TextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Maksimum değer giriniz';
                          }
                          final int? maxVal = int.tryParse(value);
                          if (maxVal == null || maxVal < 2) {
                            return 'En az 2 olmalı';
                          }
                          if (maxVal > 24) {
                            return 'En fazla 24 olabilir';
                          }
                          final int? minVal = int.tryParse(_minController.text);
                          if (minVal != null && maxVal <= minVal) {
                            return 'Minimum değerden büyük olmalı';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Başlat butonu
                    ElevatedButton(
                      onPressed: _startGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 2, 16, 31),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text('Oyunu Başlat',
                        style: GoogleFonts.jaro(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}