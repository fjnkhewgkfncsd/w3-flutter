import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    int index = 0;
    while(true){
      stdout.write("your name: ");
      String? name = stdin.readLineSync();
      if(name == null || name.isEmpty){
        break;
      }
      Player player = Player(name:name);
      quiz.players.add(player);
      for (var question in quiz.questions) {
      print('Question: ${question.title} - ( ${question.points} points )');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
      }

      double score = quiz.getScoreInPercentage();
      int totalPoints = quiz.getTotalPoints();
      quiz.players[index].score = totalPoints;
      quiz.players[index].scoreInPercentage = score.toInt();
      print('--- ${name} Quiz Finished ---');
      print('${name} score: $score % correct');
      print("${name} score is point is : $totalPoints");
      index++;
      quiz.answers.clear();
    }

    for(var player in quiz.players){
      print("player ${player.name} scored ${player.score} points (${player.scoreInPercentage} %)");
    }
  }

    
}
 