import 'package:test/test.dart';
import '../lib/domain/quiz.dart';

main() {
  

  test('My first test', () {
    Question question1 = Question(title:"what is the capital of Cambodia?",choices:["Phnom Penh","Takeo","Svay rieng"],goodChoice: "Phnom Penh");
    Question question2 = Question(title:"4-2",choices:["-2","0","2"],goodChoice: "2");

    Quiz quiz = Quiz(questions:[question1,question2]);
    quiz.players.add(Player(name:"Alice"));
    
    quiz.addAnswer(Answer(question: question1, answerChoice: "Phnom Penh"));
    quiz.addAnswer(Answer(question: question2, answerChoice: "0"));
    quiz.players[0].score = quiz.getTotalPoints();
    quiz.players[0].scoreInPercentage = quiz.getScoreInPercentage().toInt();
    expect(quiz.players[0].score,1);
    expect(quiz.players[0].scoreInPercentage,50);
    quiz.answers.clear();
    quiz.players.add(Player(name:"Bob"));
    quiz.addAnswer(Answer(question: question1, answerChoice: "Takeo"));
    quiz.addAnswer(Answer(question: question2, answerChoice: "2"));
    quiz.players[1].score = quiz.getTotalPoints();
    quiz.players[1].scoreInPercentage = quiz.getScoreInPercentage().toInt();
    expect(quiz.players[1].score,1);
    expect(quiz.players[1].scoreInPercentage,50);

  }); 
}
