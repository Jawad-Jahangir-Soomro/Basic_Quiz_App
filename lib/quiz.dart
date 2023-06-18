import 'package:basic_quiz_app/data/questions.dart';
import 'package:basic_quiz_app/question_screen.dart';
import 'package:basic_quiz_app/result_screen.dart';
import 'package:basic_quiz_app/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  Widget? activeScreen ;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    if(selectedAnswers.length == questions.length){
      setState(() {
        activeScreen = ResultScreen(chosenAnswers: selectedAnswers, restart: restartQuiz,);
      });
    }
  }

  void restartQuiz(){
    selectedAnswers = [];
    setState(() {
      activeScreen = QuestionScreen(onSelectAnswer: chooseAnswer,);
    });
  }

  void switchScreen(){
    setState(() {
      activeScreen = QuestionScreen(onSelectAnswer: chooseAnswer,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
