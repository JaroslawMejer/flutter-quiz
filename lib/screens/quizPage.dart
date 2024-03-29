import 'package:flutter/material.dart';
import '../quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  int correctAnswers = 0;
  int allAnswers = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        correctAnswers++;
      } else {
        scoreKeeper.add(
          Icon(
            Icons.remove,
            color: Colors.red,
          ),
        );
      }
      allAnswers++;
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: 'You\'ve done it!',
          desc:
          "That was the last question. Your score is $correctAnswers out of $allAnswers",
          buttons: [
            DialogButton(
              child: Text(
                'Thanks',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ).show();
        finishQuiz();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  void finishQuiz() {
    setState(() {
      quizBrain.resetQuiz();
      scoreKeeper.clear();
      correctAnswers = 0;
      allAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Container(child: Row(children: scoreKeeper), height: 24.0,
        ),
      ],
    );
  }
}