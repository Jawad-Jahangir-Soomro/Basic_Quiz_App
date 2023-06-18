import 'package:basic_quiz_app/data/questions.dart';
import 'package:basic_quiz_app/question_summary.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.chosenAnswers,
    required this.restart
  }) : super(key: key);

  final void Function() restart;

  final List<String> chosenAnswers;

  List<Map<String,Object>> getSummaryData(){
    final List<Map<String, Object>> summary = [];

    for(var i=0;i<chosenAnswers.length;i++){
      summary.add({
        "question_index" : i,
        "questions" : questions[i].text,
        "correct_answer" : questions[i].answers[0],
        "chosen_answer" : chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {

    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data){
      return data['chosen_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "You Answered $numCorrectQuestions out of $numTotalQuestions Questions\n Correctly!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 30,),
            QuestionSummary(summaryData),
            const SizedBox(height: 30,),
            TextButton(
                onPressed: restart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.restart_alt_outlined),
                    SizedBox(width: 10,),
                    Text("Restart Quiz")
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
