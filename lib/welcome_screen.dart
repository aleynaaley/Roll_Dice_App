import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rool_dice_app/range_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homepage.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          color: Colors.black.withOpacity(0.3), // Hafif karartma efekti
          child: Center(
            child: Column(
              children: [
                const Spacer(), // boşluk yukarıyı doldurur
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RangeSelectionScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 260,
                    height: 102,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.12),
                        end: Alignment(0.56, 1.85),
                        colors: [Color(0xFFD6D6D6), Color(0xFF878585)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'ZAR AT',
                        style: GoogleFonts.jaro(
                          fontSize: 55,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50), // alttan biraz boşluk kalsın
              ],
            ),
          ),
        ),
      ),
    );
  }
}
