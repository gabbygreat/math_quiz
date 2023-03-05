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
                        child: const Text(
                          'Where are we',
                          style: TextStyle(
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
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2.4,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              children: const [
                OptionCard(),
                OptionCard(),
                OptionCard(),
                OptionCard(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = controller.numberOfQuestion; i > 0; i--)
                CircleAvatar(
                  radius: controller.checkQuestionNumber == i ? 7 : 4,
                  backgroundColor: Colors.grey,
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
