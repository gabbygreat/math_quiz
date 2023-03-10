import '../../utils/utils.dart';

part 'view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  Future<void> goToMath(Difficulty difficulty) async {
    await LocalStorage.instance.getSpelling().then(
      (value) async {
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PassyMathScreen(
              difficulty: difficulty,
              questions: value.map((e) => e!).toList().sublist(0, 10),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
