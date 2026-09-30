import 'dart:convert';
import 'dart:math' as math;

import 'package:flashcard_quiz_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFlashCard extends StatefulWidget {
  const MyFlashCard({super.key});

  @override
  State<MyFlashCard> createState() => _MyFlashCardState();
}

class _MyFlashCardState extends State<MyFlashCard> {
  //List<Map<String, dynamic>> flashcards = [];
  int selectedIndex = 0;
  final pages = [const HomePage(), const MyFlashCard()];
  List<Map<String, dynamic>> flashcards = [];
  Set<int> flippedCards = {};
  final ScrollController _scrollController = ScrollController();

  void showEditDialog(int editIndex) {
    final questionController = TextEditingController(
      text: flashcards[editIndex]['question'],
    );

    final answerController = TextEditingController(
      text: flashcards[editIndex]['answer'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Flashcard"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: "Question"),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: "Answer"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

                flashcards[editIndex] = {
                  'question': questionController.text.trim(),
                  'answer': answerController.text.trim(),
                };

                final updatedCards = flashcards
                    .map((card) => jsonEncode(card))
                    .toList();

                await prefs.setStringList('flashcards', updatedCards);

                setState(() {});

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void showdeletenotification(int deleteIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Confirmation"),
          titleTextStyle: TextStyle(
            color: Color(0xff1c3f4d),
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins-semibold',
            letterSpacing: 0.2,
          ),
          content: Text("Are you sure you want to delete?"),
          contentTextStyle: TextStyle(
            color: Color(0xff152939),
            fontFamily: ' Poppins-regular',
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

                flashcards.removeAt(deleteIndex);

                final updatedCards = flashcards
                    .map((card) => jsonEncode(card))
                    .toList();

                await prefs.setStringList('flashcards', updatedCards);

                setState(() {});

                Navigator.pop(context); // close confirmation dialog
              },
              child: Text("Yes"),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
            SizedBox(width: 2),
          ],
        );
      },
    );
  }

  Future<void> loadFlashcards() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCards = prefs.getStringList('flashcards') ?? [];

    print('Loaded cards: $savedCards');

    setState(() {
      flashcards = savedCards
          .map((card) => jsonDecode(card) as Map<String, dynamic>)
          .toList();

      //isFlipped = List<bool>.filled(flashcards.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    loadFlashcards();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
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
                              width: MediaQuery.of(context).size.width > 700
                                  ? 900
                                  : MediaQuery.of(context).size.width - 30,

                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),

                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width >
                                              700
                                          ? 2
                                          : 1,

                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,

                                      childAspectRatio:
                                          MediaQuery.of(context).size.width >
                                              700
                                          ? 2.8
                                          : 1.7,
                                    ),
                                itemCount: flashcards.length,

                                itemBuilder: (context, index) {
                                  final card = flashcards[index];

                                  return TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: flippedCards.contains(index) ? 1 : 0,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    builder: (context, value, child) {
                                      final angle = value * math.pi;

                                      return Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..setEntry(3, 2, 0.001)
                                          ..rotateY(angle),
                                        child: value < 0.5
                                            ? child
                                            : Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(
                                                  math.pi,
                                                ),
                                                child: Card(
                                                  elevation: 5.0,
                                                  shadowColor: Color(
                                                    0xffb6ecfd,
                                                  ),
                                                  color: Color(0xfff0f9fd),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              flippedCards
                                                                  .remove(
                                                                    index,
                                                                  );
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.arrow_back,
                                                            color: Color(
                                                              0xff3148bb,
                                                            ),
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Scrollbar(
                                                          thumbVisibility: true,

                                                          child: SingleChildScrollView(
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      25,
                                                                    ),
                                                                child: Text(
                                                                  card['answer'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xff3148bb,
                                                                    ),
                                                                    fontFamily: 'Poppins-semibold',
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
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
                                    child: Card(
                                      elevation: 5.0,
                                      shadowColor: Color.fromARGB(
                                        255,
                                        25,
                                        37,
                                        41,
                                      ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                ),
                                                child: Text(
                                                  '#${index + 1}',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'Poppins-semibold',
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    showEditDialog(index);
                                                  },
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    showdeletenotification(
                                                      index,
                                                    );
                                                  },
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
                                            alignment:
                                                AlignmentGeometry.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                              ),
                                              child: Text(
                                                card['question'],
                                                style: TextStyle(
                                                  color: Color(0xff3148bb),
                                                  fontFamily:
                                                      'Poppins-extrabold',
                                                  letterSpacing: 0.3,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.touch_app_outlined,
                                                color: Color(0xff2f46ab),
                                              ),
                                              SizedBox(width: 5),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (flippedCards.contains(
                                                      index,
                                                    )) {
                                                      flippedCards.remove(
                                                        index,
                                                      );
                                                    } else {
                                                      flippedCards.add(index);
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  "Tap to reveal answer",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4e8cbe),
                                                    fontFamily:
                                                        'Poppins-semibold',
                                                    letterSpacing: 0.3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
              ),
            ),
          );
        },
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
