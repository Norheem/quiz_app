import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/home_screen.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Quiz();
  }
}

class _Quiz extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'home-screen';

  // @override
  // void initState() {
  //   activeScreen = HomeScreen(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      activeScreen = "questions-screen";
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'home-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(switchScreen);

    if (activeScreen == "questions-screen") {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: screenWidget,
        ),
      ),
    );
  }
}
