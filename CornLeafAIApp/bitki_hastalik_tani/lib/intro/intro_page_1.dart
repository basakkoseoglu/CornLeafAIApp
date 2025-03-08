import 'package:flutter/material.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animasyon kontrolcüsü
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animasyon süresi
    )..repeat(reverse: true); // Sonsuz tekrarlı animasyon

    // Tween ile yukarı-aşağı hareket için animasyon
    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _animation.value), // Yukarı-aşağı hareket
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.spa,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bitki Hastalık Tanıma Uygulaması',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Uygulamamız, bitki yaprağındaki hastalıkları hızlı ve kolay bir şekilde tanımanıza yardımcı olur.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
