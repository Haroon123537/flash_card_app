import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_quiz_app/login.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  bool isnavigate = false;
  bool ishidden = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _scrollController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 900
                          : MediaQuery.of(context).size.width * 0.92,

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
                              //height: 480,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF063cb3),
                              ),
                              child: Form(
                                key: _formKey,
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
                                      width: 330,
                                      child: TextFormField(
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
                                            borderRadius: BorderRadius.circular(
                                              15.0,
                                            ),
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: 330,
                                      child: TextFormField(
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
                                            borderRadius: BorderRadius.circular(
                                              15.0,
                                            ),
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a email';
                                          } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                          ).hasMatch(value)) {
                                            return 'Please enter a valid email address';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: 330,
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: ishidden,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                ishidden = !ishidden;
                                              });
                                            },
                                            icon: Icon(
                                              ishidden
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                          ),
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
                                            borderRadius: BorderRadius.circular(
                                              15.0,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF1b2049),
                                              style: BorderStyle.solid,
                                              width: 5.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a password';
                                          } else if (value.length < 6 ||
                                              value.length > 20) {
                                            return 'Password must be between 6 and 15 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    isloading
                                        ? CircularProgressIndicator(
                                            color: Color(0xFFf7fafb),
                                            strokeWidth: 3.0,
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              setState(() {
                                                isloading = true;
                                              });

                                              try {
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim(),
                                                    );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Sign up successful!',
                                                        ),
                                                      ),
                                                    );
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/home',
                                                );
                                              } on FirebaseAuthException catch (
                                                e
                                              ) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${e.code}: ${e.message}',
                                                    ),
                                                  ),
                                                );
                                              } finally {
                                                setState(() {
                                                  isloading = false;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                0xFF2fcdfc,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 15,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
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
                                    isnavigate
                                        ? CircularProgressIndicator(
                                            color: Color(0xFFf7fafb),
                                            strokeWidth: 3.0,
                                          )
                                        : TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                isnavigate = true;
                                              });
                                              await Future.delayed(
                                                Duration(seconds: 2),
                                              );
                                              try {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Error: ${e.toString()}',
                                                    ),
                                                  ),
                                                );
                                              } finally {
                                                setState(() {
                                                  isnavigate = false;
                                                });
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: Text(
                                              "Already have an account? Sign In",
                                              style: TextStyle(
                                                color: Color(0xFFf3f7f8),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                fontFamily: 'Inter-Medium',
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
        ),
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
