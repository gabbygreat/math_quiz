part of 'controller.dart';

class PassyMathView
    extends StatelessView<PassyMathScreen, PassyMathController> {
  const PassyMathView(PassyMathController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    final time = controller.ref.watch(timePerQuestionProvider);
    final score = controller.ref.watch(scoreProvider);
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Center(
              child: Text('$score'),
            ),
          ),
          if (controller.timer.isActive)
            AnimatedContainer(
              height: 10,
              duration: const Duration(seconds: 1),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width *
                      (time / controller.maxTimePerQuestion)),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: controller.counterColor(),
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: controller.counterColor(),
                    width: 2,
                  ),
                ),
              ),
              child: Container(
                color: controller.counterColor(),
              ),
            ),
          if (controller.timer.isActive)
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CustomPaint(
                      painter: QuestionPainter(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget
                          .questions[controller.numberOfQuestion -
                              controller.checkQuestionNumber]
                          .question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text(
                      'Nice One',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'You did an amazing job 🔥🔥',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Here\'s a summary of the quiz you just took',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AnswerSummary(
                      text: 'Total questions',
                      value: controller.numberOfQuestion.toString(),
                    ),
                    AnswerSummary(
                      text: 'Unanswered',
                      value: controller.answerColor
                          .where((element) => element == null)
                          .length
                          .toString(),
                    ),
                    AnswerSummary(
                      text: 'Correct answers',
                      value: controller.answerColor
                          .where((element) => element == true)
                          .length
                          .toString(),
                    ),
                    AnswerSummary(
                      text: 'Wrong answers',
                      value: controller.answerColor
                          .where((element) => element == false)
                          .length
                          .toString(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your overall percentage in this quiz is ${double.parse(((controller.answerColor.where((element) => element == true).length) / controller.numberOfQuestion).toStringAsFixed(2)) * 100} %',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      label: const Text('Return to home'),
                      icon: const Icon(Icons.home),
                    ),
                  ],
                ),
              ),
            ),
          if (controller.timer.isActive)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2.4,
                ),
                itemBuilder: (context, index) {
                  late Option option;
                  switch (index) {
                    case 0:
                      option = Option.a;
                      break;
                    case 1:
                      option = Option.b;
                      break;
                    case 2:
                      option = Option.c;
                      break;
                    case 3:
                      option = Option.d;
                      break;
                    default:
                      option = Option.none;
                      break;
                  }
                  return OptionCard(
                    time: time,
                    maximum: controller.numberOfQuestion,
                    index: controller.checkQuestionNumber,
                    changeIndicatorColor: controller.changeIndicatorColor,
                    option: option,
                    correctOption: widget
                        .questions[controller.numberOfQuestion -
                            controller.checkQuestionNumber]
                        .correctOption,
                    text: widget
                        .questions[controller.numberOfQuestion -
                            controller.checkQuestionNumber]
                        .options[index],
                  );
                },
              ),
            ),
          if (controller.timer.isActive)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = controller.numberOfQuestion; i > 0; i--)
                  CircleAvatar(
                    radius: controller.checkQuestionNumber == i ? 7 : 4,
                    backgroundColor: controller.answerColor
                                .elementAt(controller.numberOfQuestion - i) ==
                            true
                        ? Colors.green
                        : controller.answerColor.elementAt(
                                    controller.numberOfQuestion - i) ==
                                false
                            ? Colors.red
                            : Colors.grey,
                  ),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class AnswerSummary extends StatelessWidget {
  const AnswerSummary({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            '$text: ',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
