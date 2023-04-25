import 'package:flutter/material.dart';

class CategoryCell extends StatelessWidget {
  const CategoryCell({Key? key, required this.value, required this.onDoubleTap}) : super(key: key);

  final VoidCallback onDoubleTap;

  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Text(value)),
    );
  }
}

class PreviewCell extends StatelessWidget {
  const PreviewCell({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          value,
          overflow: TextOverflow.ellipsis,
        ));
  }
}

class ToggleCell extends StatefulWidget {
  const ToggleCell({Key? key, this.onCheckboxToggled, required this.value}) : super(key: key);
  final Function? onCheckboxToggled;
  final String value;
  @override
  State<ToggleCell> createState() => _ToggleCellState();
}

class _ToggleCellState extends State<ToggleCell> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.cyanAccent),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Text(widget.value),
            GestureDetector(
              onTap: () => setState(() {
                isChecked = !isChecked;
                widget.onCheckboxToggled!(isChecked);
              }),
              child: isChecked ? Icon(Icons.expand_circle_down_rounded) : Icon(Icons.arrow_circle_up_rounded),
            )
          ],
        ),
      ),
    );
  }
}
