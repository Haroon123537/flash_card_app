import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late AnimationController _circleController;
  late Animation<double> _circleScale;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _circleScale = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF168CFF),
                  Color(0xFF0755D9),
                  Color(0xFF061B3A),
                ],
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: -100,
            child: ScaleTransition(
              scale: _circleScale,
              child: Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00D9FF).withValues(alpha: 0.10),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: -120,
            child: ScaleTransition(
              scale: _circleScale,
              child: Container(
                height: 320,
                width: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF168CFF).withValues(alpha: 0.12),
                ),
              ),
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      height: 200,
                      width: 200,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Learn Smarter Every Day ",
                    style: TextStyle(
                      fontFamily: 'Poppins-light',
                      fontSize: 14,
                      color: Color(0xFFf3f8f9),
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  SizedBox(height: 25),

                  SizedBox(
                    width: 250,
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Color(0XFFf6fafc),
                      color: Color(0xFF0769f9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
