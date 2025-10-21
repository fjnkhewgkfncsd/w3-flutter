import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Quiz file not found at: $filePath');
    }
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    // Parse list of questions
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();
    var playersJson = data['players'] as List?;
    var players = playersJson?.map((s) {
      return Player.writeFromFile(
        name: s['name'],
        score: s['score'],
        scoreInPercentage: s['scoreInPercentage'],
      );
    }).toList();
    // Create Quiz object
    return Quiz.readFromFile(
      id: data['id'],
      questions: questions,
      players: players ?? [],
    );
  }


  void writeQuiz(Quiz quiz) {
    final file = File(filePath);

    final data = {
      'id': quiz.id,
      'questions': quiz.questions.map((q) => {
        'id': q.id,
        'title': q.title,
        'choices': q.choices,
        'goodChoice': q.goodChoice,
        'points': q.points,
      }).toList(),
      'players': quiz.players.map((p) => {
        'name': p.name,
        'score': p.score,
        'scoreInPercentage': p.scoreInPercentage,
      }).toList(),
    };

    file.writeAsStringSync(jsonEncode(data), flush: true);
  }
  void createSampleQuiz() {
    final sampleQuiz = Quiz(questions: [
      Question(
        title: "3 + 3 = ?",
        choices: ["2", "3", "6"],
        goodChoice: "6",
        points: 50,
      ),
      Question(
        title: "2 + 2 = ?",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50,
      ),
      Question(
        title: "Capital of France?",
        choices: ["London", "Paris", "Berlin"],
        goodChoice: "Paris",
        points: 30,
      ),
    ]);

    writeQuiz(sampleQuiz);
  }

}
