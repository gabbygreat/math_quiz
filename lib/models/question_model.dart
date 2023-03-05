import '../utils/utils.dart';

class QuestionModel {
  final Option correctOption;
  final String question;
  final List<String> options;

  QuestionModel({
    required this.correctOption,
    required this.options,
    required this.question,
  });

  static QuestionModel? fromJson(Map? data) {
    if (data == null) return null;
    late Option correct;
    switch (data['correctOption']) {
      case 'a':
        correct = Option.a;
        break;
      case 'b':
        correct = Option.b;
        break;
      case 'c':
        correct = Option.c;
        break;
      case 'd':
        correct = Option.d;
        break;
      default:
        correct = Option.none;
        break;
    }
    return QuestionModel(
      correctOption: correct,
      options: data['options'],
      question: data['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'correctOption': correctOption.name,
        'options': options,
        'question': question,
      };
}
