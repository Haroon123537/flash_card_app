import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_quiz_app/login.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const new({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formedKey = GlobalKey<FormState>();
  bool isloading = false;
  final ScrollController _scrollController = ScrollController();
  TextEditingController emailController = TextEditingController();

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
                //constraints: BoxConstraints.expand(),
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
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
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
                          SizedBox(height: 25),
                          Image.asset(
                            'assets/images/mail_icon.png',
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Forget Password?",
                            style: TextStyle(
                              fontFamily: 'Poppins-extrabold',
                              fontSize: 24,
                              color: Color(0xFF0645C2),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Enter your email and we'll send you a reset link",
                            style: TextStyle(
                              fontFamily: 'Poppins-regular',
                              color: Color(0xFF8A8A8A),
                              fontSize: 14,
                              letterSpacing: 0.3,
                            ),
                          ),

                          Form(
                            key: _formedKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 45),

                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    //key: _formKey,
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
                                          30.0,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF1b2049),
                                          style: BorderStyle.solid,
                                          width: 5.0,
                                        ),
                                      ),
                                      hintText: "name@example.com",
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

                                SizedBox(height: 38),
                                isloading
                                    ? CircularProgressIndicator(
                                        color: Color(0xFF0645C2),
                                        strokeWidth: 3.0,
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.3,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (!_formedKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            setState(() {
                                              isloading = true;
                                            });

                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                    email: emailController.text
                                                        .trim(),
                                                  );

                                              if (!mounted) return;

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Password reset link has been sent successfully to your email.",
                                                      ),
                                                    ),
                                                  );

                                              await Future.delayed(
                                                const Duration(seconds: 2),
                                              );

                                              if (!mounted) return;

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                              );
                                            } on FirebaseAuthException catch (
                                              e
                                            ) {
                                              if (!mounted) return;

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        e.message ?? "Something went wrong. Please try again.",
                                                      ),
                                                    ),
                                                  );
                                            } finally {
                                              if (mounted) {
                                                setState(() {
                                                  isloading = false;
                                                });
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF2fcdfc),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 50,
                                              vertical: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          child: Text(
                                            "Send Reset Link",
                                            style: TextStyle(
                                              color: Color(0xFFf3f7f8),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Jakarta-semibold',
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 15),

                                SizedBox(height: 10),
                              ],
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
                bottom: 0,
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
