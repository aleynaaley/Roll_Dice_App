import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rool_dice_app/dice_game_screen.dart';

class RangeSelectionScreen extends StatefulWidget {
  final int selectedTheme;
  final int selectedDiceCount;

  const RangeSelectionScreen({
    super.key,
    required this.selectedTheme,
    required this.selectedDiceCount,
  });

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
            selectedTheme: widget.selectedTheme,
            selectedDiceCount: widget.selectedDiceCount,
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/range.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.0),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kaç rakam arasında zar atılsın?',
                      style: GoogleFonts.jaro(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 55),
                    _buildNumberField(_minController, 'Minimum değer'),
                    const SizedBox(height: 20),
                    _buildNumberField(_maxController, 'Maksimum değer'),
                    const SizedBox(height: 40),
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
                      child: Text(
                        'Oyunu Başlat',
                        style: GoogleFonts.jaro(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
        style: const TextStyle(fontSize: 18),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint giriniz';
          }
          final int? val = int.tryParse(value);
          if (val == null || val < 1 || val > 24) {
            return '1-24 arası olmalı';
          }
          return null;
        },
      ),
    );
  }
}
