part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DifficultyButton(
            controller: controller,
            difficulty: Difficulty.normal,
          ),
          DifficultyButton(
            controller: controller,
            difficulty: Difficulty.hard,
          ),
        ],
      ),
    );
  }
}
