import 'dart:async';
import 'package:get/get.dart';
import 'package:studysqet/routes/exports.dart';
import 'package:studysqet/services/api_client.dart';
import 'package:studysqet/utils/urls.dart';

class McqController extends GetxController {
  var isCreatingSession = false.obs;
  var isSubmittingAnswer = false.obs;

  var sessionId = ''.obs;
  var currentQuestion = Rxn<Question>();
  var currentQuestionNumber = 1.obs;
  var totalQuestions = 0.obs;
  var selectedOption = Rxn<int>();

  // Timer related
  var timeRemaining = 0.obs;
  var timeLimitPerQuestion = 60.obs;
  Timer? _timer;
  var startTime = DateTime.now();

  // Answer review data
  var currentAnswerReview = Rxn<AnswerReview>();

  // Result data
  var quizResults = Rxn<QuizResults>();

  void createQuizSession(int numberOfQuestions, int timeLimit, String areaId) async {
    try {
      isCreatingSession(true);

      var body = {
        "numberOfQuestions": numberOfQuestions,
        "timeLimitPerQuestion": timeLimit,
        "area": areaId
      };

      final response = await ApiClient.postData(Urls.createQuizSession, body);

      if (response.statusCode == 200 || response.statusCode==201) {
        final data = response.body['data'];
        sessionId.value = data['session'] ?? '';
        currentQuestion.value = Question.fromJson(data['firstQuestion']);
        currentQuestionNumber.value = data['currentQuestion'] ?? 1;
        totalQuestions.value = data['totalQuestions'] ?? 0;
        timeLimitPerQuestion.value = timeLimit;

        startTimer();
        Get.to(() => McqScreen());
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to create quiz session');
      }
    } catch (e) {
      Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isCreatingSession(false);
    }
  }

  void startTimer() {
    timeRemaining.value = timeLimitPerQuestion.value;
    startTime = DateTime.now();
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        // Auto submit when time runs out
        submitAnswer(null, 'SKIP');
      }
    });
  }

  void submitAnswer(int? answer, String questionStatus) async {
    try {
      isSubmittingAnswer(true);
      _timer?.cancel();

      final timeTaken = DateTime.now().difference(startTime).inSeconds;

      var body = {
        "session": sessionId.value,
        "answer": answer?.toString() ?? "0",
        "questionStatus": questionStatus,
        "timeTaken": timeTaken
      };

      final response = await ApiClient.postData(Urls.submitAnswer, body);

      if (response.statusCode == 200 || response.statusCode==201) {
        final data = response.body['data'];
        final status = data['status'];

        if (status == 'COMPLETED') {
          // Quiz completed, show results
          quizResults.value = QuizResults.fromJson(data['results']);
          Get.to(() => ResultScreen());

        } else if (status == 'next_question') {
          // Store current question and answer for review
          currentAnswerReview.value = AnswerReview(
            currentQuestion: currentQuestion.value!,
            selectedOption: answer,
            questionStatus: questionStatus,
            nextQuestion: Question.fromJson(data['question']),
            questionNumber: data['question_number'] ?? 1,
            totalQuestions: data['totalNumberOfQuestions'] ?? 0,
          );

          // Navigate to answer review screen
          Get.to(() => McqAnswerScreen());
        }
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to submit answer');
      }
    } catch (e) {
      Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isSubmittingAnswer(false);
    }
  }

  void loadNextQuestion() {
    if (currentAnswerReview.value != null) {
      currentQuestion.value = currentAnswerReview.value!.nextQuestion;
      currentQuestionNumber.value = currentAnswerReview.value!.questionNumber;
      totalQuestions.value = currentAnswerReview.value!.totalQuestions;
      selectedOption.value = null;
      currentAnswerReview.value = null;
      startTimer();
      Get.back(); // Go back to MCQ screen
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class Question {
  final String id;
  final String title;
  final String difficulty;
  final int rightOption;
  final List<String> options;
  final String solution;

  Question({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.rightOption,
    required this.options,
    required this.solution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      difficulty: json['difficulty'] ?? '',
      rightOption: json['rightOption'] ?? 0,
      options: List<String>.from(json['options'] ?? []),
      solution: json['solution'] ?? '',
    );
  }
}

class AnswerReview {
  final Question currentQuestion;
  final int? selectedOption;
  final String questionStatus;
  final Question nextQuestion;
  final int questionNumber;
  final int totalQuestions;

  AnswerReview({
    required this.currentQuestion,
    required this.selectedOption,
    required this.questionStatus,
    required this.nextQuestion,
    required this.questionNumber,
    required this.totalQuestions,
  });

  bool get isCorrect {
    if (questionStatus == 'SKIP') return false;
    return selectedOption == currentQuestion.rightOption;
  }
}

class QuizResults {
  final int numberOfCorrectAnswer;
  final int accuracy;
  final int numberOfQuestions;
  final List<QuestionResult> questions;

  QuizResults({
    required this.numberOfCorrectAnswer,
    required this.accuracy,
    required this.numberOfQuestions,
    required this.questions,
  });

  factory QuizResults.fromJson(Map<String, dynamic> json) {
    return QuizResults(
      numberOfCorrectAnswer: json['numberOfCorrectAnswer'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      numberOfQuestions: json['numberOfQuestions'] ?? 0,
      questions: (json['questions'] as List?)
          ?.map((e) => QuestionResult.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class QuestionResult {
  final Question question;
  final String questionStatus;
  final bool isCorrect;
  final int selectedOption;

  QuestionResult({
    required this.question,
    required this.questionStatus,
    required this.isCorrect,
    required this.selectedOption,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      question: Question.fromJson(json['question']),
      questionStatus: json['questionStatus'] ?? '',
      isCorrect: json['isCorrect'] ?? false,
      selectedOption: json['selectedOption'] ?? 0,
    );
  }
}