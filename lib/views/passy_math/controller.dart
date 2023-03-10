import 'dart:async';

import '../../utils/utils.dart';

part 'view.dart';

class PassyMathScreen extends ConsumerStatefulWidget {
  final Difficulty difficulty;
  final List<QuestionModel> questions;
  const PassyMathScreen({
    Key? key,
    required this.difficulty,
    required this.questions,
  }) : super(key: key);

  @override
  ConsumerState<PassyMathScreen> createState() => PassyMathController();
}

class PassyMathController extends ConsumerState<PassyMathScreen> {
  final maxTimePerQuestion = 9;
  final numberOfQuestion = 10;
  late int checkQuestionNumber;
  late Timer timer;
  late List<bool?> answerColor;

  @override
  void initState() {
    super.initState();
    checkQuestionNumber = numberOfQuestion;
    answerColor = List.generate(widget.questions.length, (index) => null,
        growable: false);
    widget.questions.shuffle();
    GlobalVariables.chosen = false;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => reduceTime(timer),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void reduceTime(Timer timer) {
    if (timer.tick <= maxTimePerQuestion) {
      ref.read(timePerQuestionProvider.notifier).state += 1;
    } else {
      restartTimer();
    }
  }

  void restartTimer() {
    timer.cancel();
    ref.read(timePerQuestionProvider.notifier).state = 0;
    ref.read(correctOptionProvider.notifier).state = Option.none;
    checkQuestionNumber -= 1;
    GlobalVariables.chosen = false;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => reduceTime(timer),
    );
    if (checkQuestionNumber == 0) {
      endQuiz();
    }
  }

  void changeIndicatorColor(
      {required Option choice, required Option correct, required int index}) {
    late bool color;
    if (choice == correct) {
      ref.read(scoreProvider.notifier).state += 10;
      color = true;
    } else {
      color = false;
    }
    answerColor[index] = color;
  }

  void endQuiz() {
    timer.cancel();
    ref.read(timePerQuestionProvider.notifier).state = 0;
  }

  Color counterColor() {
    late Color color;
    if (timer.tick <= maxTimePerQuestion / 3) {
      color = Colors.green;
    } else if (timer.tick <=
        maxTimePerQuestion / (maxTimePerQuestion / (3 * 2))) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return PassyMathView(this);
  }
}
