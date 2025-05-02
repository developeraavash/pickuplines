import 'package:pickuplines/core/utils/helpers/THelperFunc.dart';
import 'package:pickuplines/features/quiz/controller/provider/quiz_provider.dart';
import 'package:pickuplines/widgets/custompinter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../splash/splashscreen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final quizList = quizProvider.quizList;
    final correctAnswersCount = quizProvider.correctAnswersCount;
    final userSelectedList = quizProvider.userSelectedIndexList;

    final h = MediaQuery.of(context).size.height;

    return CustomPaint(
      painter: BackgroundPainter(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Card(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 25,
              color:
                  Thelperfunc.isDarkMode(context) ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
              },
            ),
          ),
          title: const Text(
            'Your Result',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correct Answers: $correctAnswersCount',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Incorrect Answers: ${quizList.length - correctAnswersCount}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Correct Percentage: ${((correctAnswersCount / quizList.length) * 100).floor()}%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Thelperfunc.isDarkMode(context)
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 6,
                          value: correctAnswersCount / quizList.length,
                          backgroundColor: Colors.red,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (correctAnswersCount > 15)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(),
                    ),
                  ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: quizList.length,
                  itemBuilder: (context, index) {
                    final quiz = quizList[index];
                    final userSelectedIndex = userSelectedList[index];

                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(quiz.image),
                              height: h * 0.13,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Answer: ${quiz.options[quiz.correctAnswerIndex]}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    quiz.correctAnswerIndex == userSelectedIndex
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                            Text(
                              userSelectedIndex != null
                                  ? 'Your Selection: ${quiz.options[userSelectedIndex]}'
                                  : 'Skipped',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
