import 'package:flashcard_quiz_app/about.dart';
import 'package:flashcard_quiz_app/my_flash_card.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isloading = false;
  final pages = [const HomePage(), const MyFlashCard(), const AboutPage()];
  final GlobalKey<FormState> _form47Key = GlobalKey<FormState>();
  TextEditingController questioncontroller = TextEditingController();
  TextEditingController answercontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    questioncontroller.dispose();
    answercontroller.dispose();
  }

  Future<void> saveFlashcard() async {
    //Accessing sharedpreference object for a local storage
    final prefs = await SharedPreferences.getInstance();

    //Then access existing cards or empty list
    final existingCards = prefs.getStringList('flashcards') ?? [];

    //Then create a card in a form of map
    final createcards = {
      'question': questioncontroller.text.trim(),
      'answer': answercontroller.text.trim(),
    };

    //Then converting the map into json because we want data in a string format
    existingCards.add(jsonEncode(createcards));

    //Saving or storing that new data
    await prefs.setStringList('flashcards', existingCards);

    //clearing both textfields
    questioncontroller.clear();
    answercontroller.clear();
  }

  void showCreateFlashcardDialog() {
    bool dialogLoading = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _form47Key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: dialogLoading
                              ? null
                              : () {
                                  Navigator.pop(dialogContext);
                                },
                          icon: const Icon(Icons.close),
                          color: const Color(0xFF292E57),
                        ),
                      ),

                      const Text(
                        'Create Flashcard',
                        style: TextStyle(
                          fontFamily: 'Poppins-extrabold',
                          fontSize: 22,
                          color: Color(0xFF1937A5),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: questioncontroller,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Question',
                          hintText: 'Enter your question',
                          prefixIcon: const Icon(Icons.help_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a question';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: answercontroller,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Answer',
                          hintText: 'Enter the answer',
                          prefixIcon: const Icon(Icons.lightbulb_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter an answer';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: dialogLoading
                              ? null
                              : () async {
                                  if (!_form47Key.currentState!.validate()) {
                                    return;
                                  }

                                  // Start loading
                                  setDialogState(() {
                                    dialogLoading = true;
                                  });

                                  try {
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );

                                    await saveFlashcard();

                                    if (context.mounted) {
                                      Navigator.pop(dialogContext);

                                      ScaffoldMessenger.of(this.context)
                                          .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Flashcard saved successfully!',
                                              ),
                                            ),
                                          );
                                    }
                                  } catch (e) {
                                    setDialogState(() {
                                      dialogLoading = false;
                                    });

                                    if (context.mounted) {
                                      ScaffoldMessenger.of(this.context)
                                          .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'There is an error: $e',
                                              ),
                                            ),
                                          );
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF35C7F2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: dialogLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Save Flashcard',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-semibold',
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0XFFedf4f6),
      appBar: AppBar(
        titleSpacing: 30,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF168CFF), Color(0xFF0755D9)],
            ),
          ),
        ),
        //leadingWidth: 20.0,
        elevation: 5.0,
        shadowColor: Color(0xFF292e57),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Flash',
                    style: TextStyle(
                      fontFamily: 'Poppins-extrabold',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Card',
                    style: TextStyle(
                      fontFamily: 'Poppins-extrabold',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF35C7F2),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              '______ Q U I Z  A P P _____  ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Color(0xFFf9fbfc),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  "Create  New  FlashCards",
                  style: TextStyle(
                    fontFamily: 'Poppins-semibold',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1937a5),
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Add your own flashcards and start",
                  style: TextStyle(
                    fontFamily: 'Inter-Medium  ',
                    letterSpacing: 0.5,
                    fontSize: 15,
                    color: Color(0xFF1a3e4e),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "learning today!",
                  style: TextStyle(
                    fontFamily: 'Inter-Medium  ',
                    letterSpacing: 0.5,
                    fontSize: 15,
                    color: Color(0xFF1a3e4e),
                  ),
                ),
                SizedBox(height: 19),
                Container(
                  height: 220,
                  width: 220,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFeaf8fd),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF62C8F5).withValues(alpha: 0.30),
                        blurRadius: 25,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: DottedBorder(
                    options: RectDottedBorderOptions(
                      color: const Color(0xFF38BDF8),
                      strokeWidth: 2,
                      dashPattern: const [8, 7],
                      //radius: const Radius.circular(18),
                    ),
                    child: SizedBox(
                      height: 200,
                      width: 200,

                      child: Center(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showCreateFlashcardDialog();
                              },
                              borderRadius: BorderRadius.circular(75),
                              child: Image.asset(
                                height: 130,
                                width: 130,
                                'assets/images/center_icon.png',
                              ),
                            ),
                            const SizedBox(height: 1),
                            Transform.translate(
                              offset: Offset(0, -25),
                              child: Text(
                                "Create FlashCard",
                                style: TextStyle(
                                  color: Color(0xFF1937a5),
                                  fontFamily: 'Poppins-semibold',
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, -20),
                              child: Text(
                                "Tap to add a new flashcard",
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                  color: Color(0xFF1a3e4e),
                                  fontFamily: 'Inter-Medium  ',
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, -20),
                              child: Text(
                                "and save it",
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                  color: Color(0xFF1a3e4e),
                                  fontFamily: 'Inter-Medium  ',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -50,
            left: -80,
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
            bottom: -30,
            right: -80,
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

      bottomNavigationBar: NavigationBar(
        maintainBottomViewPadding: true,
        elevation: 5.0,
        shadowColor: Color(0xFF1d3f4e),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Poppins-extrabold',
              fontSize: 13,
              //fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Color(0xFF053fb3),
            );
          }

          return const TextStyle(
            fontFamily: 'Poppins-semibold',
            fontSize: 13,
            letterSpacing: 0.5,
            color: Color(0xFF292E57),
          );
        }),
        backgroundColor: const Color(0xFFfafbfc),

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyFlashCard()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          }
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Color(0xFF292e57), size: 30),
            selectedIcon: Icon(Icons.home, color: Color(0xFF053fb3)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.style_outlined,
              color: Color(0xFF292e57),
              size: 30,
            ),
            selectedIcon: Icon(Icons.style_outlined, color: Color(0xFF053fb3)),
            label: 'My FlashCards',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline, color: Color(0xFF292e57), size: 30),
            label: 'About',
            selectedIcon: Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF053fb3),
            ),
          ),
        ],
      ),
    );
  }
}
