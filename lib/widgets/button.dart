import 'package:flutter/material.dart';

class FozButton extends StatelessWidget {
  final int index;
  final int isSelectedIndex;
  final String label;
  final void Function(int) onPressed;

  const FozButton({
    super.key,
    required this.index,
    required this.isSelectedIndex,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              index == isSelectedIndex ? Colors.blue[700] : Colors.blue[100],
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(64.0),
          ),
        ),
        onPressed: () => onPressed(index),
        child: Text(
          label,
          style: TextStyle(
              color: index == isSelectedIndex ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
