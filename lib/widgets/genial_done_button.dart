import 'package:flutter/material.dart';

class GenialDoneButton extends StatelessWidget {
  final Function onPressed;

  GenialDoneButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('/images/icon.png'), fit: BoxFit.cover)),
      ),
    );
  }
}
