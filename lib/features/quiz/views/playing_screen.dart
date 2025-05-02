import 'package:pickuplines/core/utils/helpers/THelperFunc.dart';
import 'package:pickuplines/features/quiz/controller/provider/quiz_provider.dart';
import 'package:pickuplines/widgets/custompinter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'result_screen.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final isDarkMode = Thelperfunc.isDarkMode(context);

    return FutureBuilder(
      future: quizProvider.loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error loading quiz data',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        } else {
          return Consumer<QuizProvider>(
            builder: (context, quizProvider, child) {
              final quizList = quizProvider.quizList;
              final currentIndex = quizProvider.currentIndex;

              if (quizList.isEmpty) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      'No quiz data available',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }

              final quiz = quizList[currentIndex];
              final options = quiz.options;

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Question ${currentIndex + 1} of ${quizList.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  centerTitle: true,
                ),
                extendBodyBehindAppBar: true,
                body: CustomPaint(
                  painter: BackgroundPainter(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 90),
                        const SizedBox(height: 16),
                        Card(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          child: Image.asset(quiz.image, height: 250),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          quiz.defaultText,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 90),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 1.5,
                                ),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  quizProvider
                                      .userSelectedIndexList[currentIndex] ==
                                  index;
                              final isCorrect =
                                  quizProvider
                                      .quizList[currentIndex]
                                      .correctAnswerIndex ==
                                  index;
                              final color =
                                  isSelected
                                      ? (isCorrect
                                          ? const Color.fromARGB(
                                            255,
                                            119,
                                            144,
                                            120,
                                          )
                                          : Colors.red)
                                      : (isDarkMode
                                          ? Colors.grey[700]
                                          : Colors.redAccent);

                              return GestureDetector(
                                onTap: () {
                                  quizProvider.selectOption(index);

                                  if (quizProvider.isLastQuestion()) {
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const ResultScreen(),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        quizProvider.nextQuestion();
                                      },
                                    );
                                  }
                                },
                                child: Card(
                                  color: color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      options[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            quizProvider.nextQuestion();
                          },
                          child: const Text('Skip'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
