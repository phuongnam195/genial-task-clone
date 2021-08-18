import 'package:flutter/material.dart';

import '../models/configuaration.dart';

class GenialRadioButton extends StatelessWidget {
  final String label;
  final bool value;
  final Function onPressed;

  GenialRadioButton(
      {required this.label, required this.value, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const BUTTON_HEIGHT = 40.0;
    const BUTTON_WIDTH = 100.0;

    return ElevatedButton(
      onPressed: () => this.onPressed(),
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BUTTON_HEIGHT / 2),
        ),
        padding: EdgeInsets.zero,
        fixedSize: Size(BUTTON_WIDTH, BUTTON_HEIGHT),
        elevation: 0,
      ),
      child: Container(
        height: BUTTON_HEIGHT,
        width: BUTTON_WIDTH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient:
                value ? LinearGradient(colors: Config.PRIMARY_GRADIENT) : null,
            borderRadius: BorderRadius.all(Radius.circular(BUTTON_HEIGHT / 2))),
        child: Text(
          this.label,
          style: value
              ? Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white)
              : Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
