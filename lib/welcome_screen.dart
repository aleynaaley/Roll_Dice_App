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

  final List<String> themeNames = [
    "PASTEL",
    "WARM",
    "SKY",
    "EARTH",
    "SPRING",
    "CANDY",
  ];

  final List<String> themePreviews = [
    "assets/images/pastel_t.png",
    "assets/images/warm_t.png",
    "assets/images/sky_t.png",
    "assets/images/earth_t.png",
    "assets/images/spring_t.png",
    "assets/images/candy_t.png",
  ];

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
                    crossAxisCount: 2, // 2 kolon
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: themeNames.length,
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
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 3)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  themePreviews[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              themeNames[index],
                              style: GoogleFonts.jaro(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
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
                children: [1, 2, 4].map((count) {
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
                        builder: (context) => RangeSelectionScreen(
                          selectedTheme: selectedTheme,
                          selectedDiceCount: selectedDiceCount,
                        ),
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
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 60, 59, 59).withOpacity(0.7),
                      ),
                      onPressed: _showThemeSelector,
                      child: Text(
                        "Tema Seç",
                        style: GoogleFonts.jaro(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 60, 59, 59).withOpacity(0.7),
                      ),
                      onPressed: _showDiceSelector,
                      child: Text(
                        "Zar Sayısı",
                        style: GoogleFonts.jaro(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
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
