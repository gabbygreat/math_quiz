import '../utils/utils.dart';

class OptionCard extends StatefulWidget {
  final String text;
  final Option option;
  final Option correctOption;
  final Function changeIndicatorColor;
  final int time;
  final int index;
  final int maximum;
  const OptionCard({
    super.key,
    required this.text,
    required this.option,
    required this.correctOption,
    required this.time,
    required this.index,
    required this.maximum,
    required this.changeIndicatorColor,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool selected = false;
  void clicked() {
    if (!GlobalVariables.chosen) {
      selected = !selected;
      GlobalVariables.chosen = true;
      setState(() {});
      widget.changeIndicatorColor(
        choice: widget.option,
        correct: widget.correctOption,
        index: widget.maximum - widget.index,
      );
    }
  }

  void reset() {
    if (widget.time == 0) {
      selected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    reset();
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => clicked(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
          color: selected
              ? widget.correctOption == widget.option
                  ? Colors.green
                  : Colors.red
              : Colors.transparent,
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
