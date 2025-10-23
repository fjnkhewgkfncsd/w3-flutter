import 'package:uuid/uuid.dart';
var uuid = Uuid();
class Question{
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;
  final String id ;
  Question({required this.title, required this.choices, required this.goodChoice, this.points = 1,String? id}) : id = id ?? uuid.v4();
}

class Answer{
  final Question question;
  final String answerChoice;
  final String id ;

  Answer({required this.question, required this.answerChoice, String? id}) : id = id ?? uuid.v4();

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz{
  List<Question> questions;
  List <Answer> answers =[];
  List<Player> players = [];
  final String id;

  Quiz({required this.questions, String? id}) : id = id ?? uuid.v4();
  Quiz.readFromFile({required this.questions, required this.players, String? id}) : id = id ?? uuid.v4();
  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  double getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore/ questions.length)*100);
  }
  int getTotalPoints(){
    int totalPoints = 0;
    for(var answer in answers){
      if(answer.isGood()){
        totalPoints += answer.question.points;
      }
    }
    return totalPoints;
  }
  Question? getQuestionById(String id){
    try{
      return questions.firstWhere((question) => question.id == id);
    }catch(e){
      return null;
    }
  }

  Answer? getAnswerById(String id){
    try{
      return answers.firstWhere((answer) => answer.id == id);
    }catch(e){
      return null;
    }
  }
}
class Player{
  final String name;
  late int score;
  late int scoreInPercentage;

  Player({required this.name});
  Player.writeFromFile({required this.name, required this.score, required this.scoreInPercentage});
}