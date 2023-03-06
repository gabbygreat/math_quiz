import 'package:math_quiz/utils/utils.dart';

final timePerQuestionProvider = StateProvider.autoDispose<int>((ref) => 0);
final scoreProvider = StateProvider.autoDispose<int>((ref) => 0);