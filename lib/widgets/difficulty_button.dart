import '../utils/utils.dart';

class DifficultyButton extends StatelessWidget {
  final Difficulty difficulty;
  final HomeController controller;
  const DifficultyButton({
    super.key,
    required this.difficulty,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: InkWell(
        onTap: () => controller.goToMath(difficulty),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.maxFinite,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            difficulty.name.capitalize(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
