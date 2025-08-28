import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rool_dice_app/range_selection_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int selectedTheme = 0; // 0-5 arası tema
  int selectedDiceCount = 1; // 1,2,4 olabilir

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text("Tema Seç", style: GoogleFonts.jaro(fontSize: 28)),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final isSelected = selectedTheme == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = index;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(12),
                          border:
                              isSelected
                                  ? Border.all(color: Colors.black, width: 3)
                                  : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDiceSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text("Zar Sayısı Seç", style: GoogleFonts.jaro(fontSize: 28)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                children:
                    [1, 2, 4].map((count) {
                      final isSelected = selectedDiceCount == count;
                      return ChoiceChip(
                        label: Text(
                          "$count Zar",
                          style: GoogleFonts.jaro(fontSize: 20),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedDiceCount = count;
                          });
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

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
          color: Colors.black.withOpacity(0.0),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
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
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'ZAR AT',
                        style: GoogleFonts.jaro(
                          fontSize: 45,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Yeni Butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color.fromARGB(255, 60, 59, 59).withOpacity(0.7),
                      ),
                      onPressed: _showThemeSelector,
                      child: Text(
                        "Tema Seç",
                        style: GoogleFonts.jaro(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white,)
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color.fromARGB(255, 60, 59, 59).withOpacity(0.7),
                      ),
                      onPressed: _showDiceSelector,
                      child: Text(
                        "Zar Sayısı",
                        style: GoogleFonts.jaro(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white,)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
