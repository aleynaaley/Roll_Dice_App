import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // Varsayılan değerler
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 16, 31),
              Color.fromARGB(255, 4, 37, 69),
              Color.fromARGB(255, 8, 67, 126),
              Color.fromARGB(255, 54, 91, 127),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Kaç rakam arasında?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                  // Min değer girişi
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
                        labelText: 'Minimum değer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(20),
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
                  
                  // Max değer girişi
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
                        labelText: 'Maksimum değer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(20),
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
                    child: const Text('Oyunu Başlat'),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Geri gitme butonu
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Geri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}