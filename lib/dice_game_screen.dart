import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rool_dice_app/range_selection_screen.dart';

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

class _DiceGameScreenState extends State<DiceGameScreen>
    with TickerProviderStateMixin {
  late int currentDiceRoll;
  bool isRolling = false;
  final Random randomizer = Random();

  // Fizik animasyon controller'ları
  late AnimationController _physicsController;
  late AnimationController _approachController;
  late AnimationController _rotationController;
  late AnimationController _backgroundController;

  // Pozisyon ve fizik değerleri
  double diceX = 0;
  double diceY = 0;
  double diceScale = 1.0;
  double rotationX = 0;
  double rotationY = 0;
  double rotationZ = 0;

  // Fizik değişkenleri
  double velocityX = 0;
  double velocityY = 0;
  double gravity = 800.0;
  double bounce = 0.7;
  double friction = 0.95;
  late double groundLevel;
  late double screenWidth;

  // Arka plan renkleri
  List<List<Color>> backgroundGradients = [];
  int currentBackgroundIndex = 0;

  @override
  void initState() {
    super.initState();
    currentDiceRoll = widget.minValue;
    _generateBackgroundGradients();
    currentBackgroundIndex = randomizer.nextInt(backgroundGradients.length);

    // Fizik simulasyonu
    _physicsController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Yaklaşma animasyonu
    _approachController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Sürekli dönme animasyonu
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat();

    // Arka plan geçiş animasyonu
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationController.addListener(() {
      if (isRolling) {
        setState(() {
          rotationX += 0.3;
          rotationY += 0.2;
          rotationZ += 0.4;
        });
      }
    });
  }

  void _generateBackgroundGradients() {
    // Her sayı için farklı renk gradyanları oluştur
    final baseColors = [
      [Colors.purple.shade900, Colors.purple.shade600, Colors.purple.shade300],
      [Colors.blue.shade900, Colors.blue.shade600, Colors.blue.shade300],
      [Colors.green.shade900, Colors.green.shade600, Colors.green.shade300],
      [Colors.red.shade900, Colors.red.shade600, Colors.red.shade300],
      [Colors.orange.shade900, Colors.orange.shade600, Colors.orange.shade300],
      [Colors.teal.shade900, Colors.teal.shade600, Colors.teal.shade300],
      [Colors.indigo.shade900, Colors.indigo.shade600, Colors.indigo.shade300],
      [Colors.pink.shade900, Colors.pink.shade600, Colors.pink.shade300],
      [Colors.amber.shade900, Colors.amber.shade600, Colors.amber.shade300],
      [Colors.cyan.shade900, Colors.cyan.shade600, Colors.cyan.shade300],
      [Colors.lime.shade900, Colors.lime.shade600, Colors.lime.shade300],
      [
        Colors.deepOrange.shade900,
        Colors.deepOrange.shade600,
        Colors.deepOrange.shade300,
      ],
      [
        Colors.deepPurple.shade900,
        Colors.deepPurple.shade600,
        Colors.deepPurple.shade300,
      ],
      [
        Colors.lightBlue.shade900,
        Colors.lightBlue.shade600,
        Colors.lightBlue.shade300,
      ],
      [
        Colors.lightGreen.shade900,
        Colors.lightGreen.shade600,
        Colors.lightGreen.shade300,
      ],
      [Colors.yellow.shade900, Colors.yellow.shade600, Colors.yellow.shade300],
      [Colors.brown.shade900, Colors.brown.shade600, Colors.brown.shade300],
      [Colors.grey.shade900, Colors.grey.shade600, Colors.grey.shade300],
      [
        Colors.blueGrey.shade900,
        Colors.blueGrey.shade600,
        Colors.blueGrey.shade300,
      ],
      [
        const Color(0xFF1A1A2E),
        const Color(0xFF16213E),
        const Color(0xFF0F3460),
      ],
      [
        const Color(0xFF2D1B69),
        const Color(0xFF11998E),
        const Color(0xFF38EF7D),
      ],
      [
        const Color(0xFF8360C3),
        const Color(0xFF2EBF91),
        const Color(0xFFFFE53B),
      ],
      [
        const Color(0xFFFF0844),
        const Color(0xFFFFB199),
        const Color(0xFFFFE53B),
      ],
      [
        const Color(0xFF654EA3),
        const Color(0xFFEAAFC8),
        const Color(0xFFFFE53B),
      ],
    ];

    // Girilen aralık kadar gradient oluştur
    int rangeSize = widget.maxValue - widget.minValue + 1;
    backgroundGradients = [];

    for (int i = 0; i < rangeSize; i++) {
      backgroundGradients.add(baseColors[i % baseColors.length]);
    }
  }

  @override
  void dispose() {
    _physicsController.dispose();
    _approachController.dispose();
    _rotationController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  void rollDice() async {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    // Yeni arka plan seç
    int newBackgroundIndex;
    do {
      newBackgroundIndex = randomizer.nextInt(backgroundGradients.length);
    } while (newBackgroundIndex == currentBackgroundIndex &&
        backgroundGradients.length > 1);

    currentBackgroundIndex = newBackgroundIndex;

    // Arka plan geçişini başlat
    _backgroundController.forward().then((_) {
      _backgroundController.reset();
    });

    // Ekran boyutlarını al
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    groundLevel = size.height * 0.7;

    // Başlangıç değerleri - zar ekranın üst kısmından atılıyor
    diceX = (screenWidth / 2) - 100 + (randomizer.nextDouble() - 0.5) * 100;
    diceY = size.height * 0.3;
    diceScale = 0.3;

    // Rastgele başlangıç hızı
    velocityX = (randomizer.nextDouble() - 0.5) * 300;
    velocityY = randomizer.nextDouble() * 150 + 100;

    // Fizik simulasyonu
    _physicsController.addListener(_updatePhysics);
    await _physicsController.forward();
    _physicsController.removeListener(_updatePhysics);

    // Yeni zar değerini belirle (girilen aralıkta)
    setState(() {
      currentDiceRoll =
          widget.minValue +
          randomizer.nextInt(widget.maxValue - widget.minValue + 1);
    });

    // Dönmeyi yavaşlat
    await Future.delayed(const Duration(milliseconds: 500));

    // Ekrana yaklaşma animasyonu
    final approachAnimation = Tween<double>(begin: diceScale, end: 1.0).animate(
      CurvedAnimation(parent: _approachController, curve: Curves.easeOutBack),
    );

    final positionXAnimation = Tween<double>(
      begin: diceX,
      end: (screenWidth / 2) - 100,
    ).animate(
      CurvedAnimation(parent: _approachController, curve: Curves.easeOut),
    );

    final positionYAnimation = Tween<double>(
      begin: diceY,
      end: size.height * 0.4,
    ).animate(
      CurvedAnimation(parent: _approachController, curve: Curves.easeOut),
    );

    void updateApproach() {
      setState(() {
        diceScale = approachAnimation.value;
        diceX = positionXAnimation.value;
        diceY = positionYAnimation.value;
      });
    }

    _approachController.addListener(updateApproach);
    await _approachController.forward();
    _approachController.removeListener(updateApproach);

    // Sıfırla
    _physicsController.reset();
    _approachController.reset();

    setState(() {
      isRolling = false;
      diceX = 0;
      diceY = 0;
      diceScale = 1.0;
      rotationX = 0;
      rotationY = 0;
      rotationZ = 0;
    });
  }

  void _updatePhysics() {
    setState(() {
      // Yerçekimi
      velocityY += gravity * 0.016; // 60 FPS için

      // Pozisyon güncelle
      diceX += velocityX * 0.016;
      diceY += velocityY * 0.016;

      // Yere çarpma kontrolü
      if (diceY >= groundLevel && velocityY > 0) {
        diceY = groundLevel;
        velocityY *= -bounce; // Zıplama
        velocityX *= friction; // Sürtünme

        // Minimum zıplama kontrolü
        if (velocityY.abs() < 50) {
          velocityY = 0;
        }
      }

      // Duvar çarpması
      if (diceX <= 50 || diceX >= screenWidth - 150) {
        velocityX *= -0.8;
        diceX = diceX <= 50 ? 50 : screenWidth - 150;
      }

      // Sürtünme (zeminde)
      if (diceY >= groundLevel - 5) {
        velocityX *= 0.98;
      }

      // Zar boyutunu animasyonlu değiştir
      double targetScale = 0.2 + (groundLevel - diceY) / groundLevel * 0.3;
      diceScale += (targetScale - diceScale) * 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: rollDice,
        child: AnimatedBuilder(
          animation: _backgroundController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: backgroundGradients[currentBackgroundIndex],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder:
                                    (context) => const RangeSelectionScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        // Aralık bilgisi
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
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

                  // Ana zar (normal pozisyon)
                  if (!isRolling)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '$currentDiceRoll',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      backgroundGradients[currentBackgroundIndex][0],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),

                  // Animasyondaki zar
                  if (isRolling)
                    Positioned(
                      left: diceX,
                      top: diceY,
                      child: Transform.scale(
                        scale: diceScale,
                        child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.identity()
                                ..setEntry(3, 2, 0.001) // Perspektif
                                ..rotateX(rotationX)
                                ..rotateY(rotationY)
                                ..rotateZ(rotationZ),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(5, diceScale * 20),
                                ),
                              ],
                            ),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  '$currentDiceRoll',
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        backgroundGradients[currentBackgroundIndex][0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Alt bilgi
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (!isRolling)
                          const Text(
                            'Ekrana dokunarak zar atın',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        if (isRolling)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Zar atılıyor...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
