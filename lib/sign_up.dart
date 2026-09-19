import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            child: Center(
              child: Container(
                height: 550,
                width: MediaQuery.of(context).size.width * 0.68,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF), // White
                      Color(0xFFF4F9FF), // Very light blue
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Image.asset(
                      'assets/images/app_logo.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 10),
                    ClipPath(
                      clipper: SignUpContainerClipper(),
                      child: Container(
                        height: 425,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF063cb3),
                          //backgroundBlendMode:
                          //
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 45),
                            Text(
                              "Create Your Account",
                              style: TextStyle(
                                color: Color(0xFFf7fafb),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.7,
                                fontFamily: 'Jakarta-semibold',
                              ),
                            ),
                            SizedBox(height: 35),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color(0xFF202553),
                                  ),
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF202553),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFf4f8fa),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFF1b2049),
                                      style: BorderStyle.solid,
                                      width: 5.0,
                                    ),
                                  ),
                                  hintText: "Enter Name",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    color: Color(0xFF0f163f)
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 20,
                                    color: Color(0xFF202553),
                                  ),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF202553),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFf4f8fa),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFF1b2049),
                                      style: BorderStyle.solid,
                                      width: 5.0,
                                    ),
                                  ),
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    color: Color(0xFF0f163f)
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Color(0xFF202553),
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF202553),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFf4f8fa),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    color: Color(0xFF0f163f)
                                        .withValues(alpha: 0.7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFF1b2049),
                                      style: BorderStyle.solid,
                                      width: 5.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                // Handle sign-up logic here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2fcdfc),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFFf3f7f8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Jakarta-semibold',
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,

                                //enabledMouseCursor: true
                              ),
                              child: Text(
                                "Already have an account? Sign In",
                                style: TextStyle(
                                  color: Color(0xFFf3f7f8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Inter-Medium',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: -100,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00D9FF).withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: -50,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00D9FF).withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: -50,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00D9FF).withValues(alpha: 0.10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.moveTo(0, 15);

    // Curved top
    path.quadraticBezierTo(size.width / 2, 45, size.width, 15);

    // Right side
    path.lineTo(size.width, size.height - 20);

    // Bottom-right rounded corner
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );

    // Bottom
    path.lineTo(20, size.height);

    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    // Left side
    path.lineTo(0, 15);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
