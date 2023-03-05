part of 'controller.dart';

class PassyMathView
    extends StatelessView<PassyMathScreen, PassyMathController> {
  const PassyMathView(PassyMathController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    final time = controller.ref.watch(timePerQuestionProvider);
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
          const SizedBox(
            height: 60,
            child: Center(
              child: Text('120'),
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
          Expanded(
            child: controller.timer.isActive
                ? Column(
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
                  )
                : const Center(),
          ),
          Expanded(
            child: controller.checkQuestionNumber == 0
                ? const Center()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = controller.numberOfQuestion; i > 0; i--)
                CircleAvatar(
                  radius: controller.checkQuestionNumber == i ? 7 : 4,
                  backgroundColor: controller.colors
                              .elementAt(controller.numberOfQuestion - i) ==
                          true
                      ? Colors.green
                      : controller.colors
                                  .elementAt(controller.numberOfQuestion - i) ==
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
