 
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {

  // List<Question> questions = [
  //   Question(
  //       title: "Capital of France?",
  //       choices: ["Paris", "London", "Rome"],
  //       goodChoice: "Paris"),
  //   Question(
  //       title: "2 + 2 = ?", 
  //       choices: ["2", "4", "5"], 
  //       goodChoice: "4"),
  // ];
  QuizRepository repository = QuizRepository('quiz_data.json');
  //Quiz quiz = Quiz(questions: questions);
  var quizFromFile = repository.readQuiz();
  QuizConsole console = QuizConsole(quiz: quizFromFile);
  
  console.startQuiz();
  
  repository.writeQuiz(quizFromFile);

}
