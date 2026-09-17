import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00D9FF).withValues(alpha: 0.10),
              ),
            ),
          ),

          // Soft circle 2
          Positioned(
            bottom: 30,
            right: -120,
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF168CFF).withValues(alpha: 0.12),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 200,
                  width: 200,
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
                    // backgroundColor: ,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
