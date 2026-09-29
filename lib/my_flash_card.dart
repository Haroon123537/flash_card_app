import 'dart:convert';

import 'package:flashcard_quiz_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFlashCard extends StatefulWidget {
  const MyFlashCard({super.key});

  @override
  State<MyFlashCard> createState() => _MyFlashCardState();
}

class _MyFlashCardState extends State<MyFlashCard> {
  int selectedIndex = 0;
  final pages = [const HomePage(), const MyFlashCard()];
  List<Map<String, dynamic>> flashcards = [];

  Future<void> loadFlashcards() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCards = prefs.getStringList('flashcards') ?? [];

    setState(() {
      flashcards = savedCards
          .map((card) => jsonDecode(card) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 50),
                Text(
                  "My FlashCards",
                  style: TextStyle(
                    fontFamily: 'Poppins-extrabold',
                    fontSize: 30,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w800,
                    color: Color(0Xff2035a9),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  "Review your saved flashcards",
                  style: TextStyle(
                    fontFamily: 'Poppins-semibold',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: Color(0xff28628a),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 900,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 2.8,
                          ),

                      itemCount: flashcards.length,

                      itemBuilder: (context, index) {
                        final card = flashcards[index];

                        return Card(
                          elevation: 5.0,
                          shadowColor: Color(0xffb6ecfd),
                          color: Color(0xfff0f9fd),
                          child: Column(
                            children: [
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  SizedBox(width: 16),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffc5e3f7),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      '#${index + 1}',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins-semibold',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1261C9),
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xffc5e3f7),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        color: Color(0xFF1451df),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xffc5e3f7),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Color(0xFFf05f56),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                ],
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    card['question'],
                                    style: TextStyle(
                                      color: Color(0xff3148bb),
                                      fontFamily: 'Poppins-extrabold',
                                      letterSpacing: 0.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.touch_app_outlined,
                                    color: Color(0xff2f46ab),
                                  ),
                                  SizedBox(width: 5),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Tap to reveal answer",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff4e8cbe),
                                        fontFamily: 'Poppins-semibold',
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
        ],
      ),
    );
  }
}
