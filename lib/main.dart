import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avoid Drinks Quiz',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AvoidDrinksQuiz(),
    );
  }
}

class Question {
  String text;
  List<String> options;
  int correctOption;

  Question({
    required this.text,
    required this.options,
    required this.correctOption,
  });
}

class AvoidDrinksQuiz extends StatefulWidget {
  const AvoidDrinksQuiz({Key? key}) : super(key: key);

  @override
  State<AvoidDrinksQuiz> createState() => _AvoidDrinksQuizState();
}

class _AvoidDrinksQuizState extends State<AvoidDrinksQuiz> {
  int score = 0;
  int questionIndex = 0;
  bool showResult = false;

  List<Question> questions = [
    Question(
      text: 'What is the legal drinking age?',
      options: ['16', '18', '21', '25'],
      correctOption: 2,
    ),
    Question(
      text: 'How many standard drinks are in a beer?',
      options: ['1', '5', '8', '12'],
      correctOption: 0,
    ),
    Question(
      text: 'Which organ does alcohol primarily affect?',
      options: ['Heart', 'Liver', 'Lungs', 'Kidneys'],
      correctOption: 1,
    ),
    Question(
      text: 'In which year was the prohibition of alcohol repealed in the United States?',
      options: ['1919', '1933', '1950', '1965'],
      correctOption: 1,
    ),
    Question(
      text: 'What is the main psychoactive substance in alcoholic beverages?',
      options: ['Caffeine', 'Nicotine', 'Ethanol', 'Marijuana'],
      correctOption: 2,
    ),
    Question(
      text: 'How long does it typically take for the body to eliminate one standard drink?',
      options: ['30 minutes', '1 hour', '2 hours', '4 hours'],
      correctOption: 0,
    ),
    Question(
      text: 'Which vitamin is commonly deficient in heavy drinkers?',
      options: ['Vitamin A', 'Vitamin B12', 'Vitamin C', 'Vitamin D'],
      correctOption: 1,
    ),
    Question(
      text: 'What percentage of alcohol is typically found in vodka?',
      options: ['20%', '40%', '60%', '80%'],
      correctOption: 3,
    ),
    Question(
      text: 'Which of the following is a long-term effect of alcohol on the brain?',
      options: ['Improved memory', 'Increased intelligence', 'Reduced cognitive function', 'Enhanced creativity'],
      correctOption: 2,
    ),
    Question(
      text: 'Which type of cancer is associated with heavy alcohol consumption?',
      options: ['Lung cancer', 'Breast cancer', 'Colon cancer', 'Prostate cancer'],
      correctOption: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  void _startQuiz() {
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (!showResult) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        showResult = true;
        _completeGame();
      }
    });
  }

  void _completeGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Completed'),
          content: Text('Congratulations! You completed the quiz. Your total score is $score.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      score = 0;
      questionIndex = 0;
      showResult = false;
    });
    _startQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avoid Drinks Quiz'),
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                questions[questionIndex].text,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              for (int i = 0; i < questions[questionIndex].options.length; i++)
                ElevatedButton(
                  onPressed: () {
                    if (!showResult) {
                      _checkAnswer(i);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    onPrimary: Colors.white,
                  ),
                  child: Text(questions[questionIndex].options[i]),
                ),
              SizedBox(height: 20),
              if (showResult)
                Text(
                  'Total Score: $score',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer(int selectedOption) {
    setState(() {
      if (selectedOption == questions[questionIndex].correctOption) {
        score += 10;
      }
      _nextQuestion();
    });
  }
}
