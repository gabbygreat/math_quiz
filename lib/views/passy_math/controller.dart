import 'dart:async';

import '../../utils/utils.dart';

part 'view.dart';

class PassyMathScreen extends ConsumerStatefulWidget {
  final Difficulty difficulty;
  const PassyMathScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  ConsumerState<PassyMathScreen> createState() => PassyMathController();
}

class PassyMathController extends ConsumerState<PassyMathScreen> {
  int maxTimePerQuestion = 9;
  final numberOfQuestion = 3;
  late int checkQuestionNumber;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    checkQuestionNumber = numberOfQuestion;
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
    if (timer.tick <= maxTimePerQuestion / 1) {
      ref.read(timePerQuestionProvider.notifier).state += 1;
    } else {
      restartTimer();
    }
  }

  void restartTimer() {
    timer.cancel();
    ref.read(timePerQuestionProvider.notifier).state = 0;
    checkQuestionNumber -= 1;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => reduceTime(timer),
    );
    if (checkQuestionNumber == 0) {
      endQuiz();
    }
  }

  void endQuiz() {
    timer.cancel();
    ref.read(timePerQuestionProvider.notifier).state = 0;
    print('Finished');
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
