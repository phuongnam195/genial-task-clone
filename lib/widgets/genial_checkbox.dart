import 'package:flutter/material.dart';

import '../models/configuaration.dart';

class GenialCheckbox extends StatelessWidget {
  final bool value;
  final String? label;
  final IconData icon;
  final IconData? alterIcon;
  final Function onChecked;
  final Color backgroundColor;

  GenialCheckbox({
    required this.value,
    this.label,
    required this.icon,
    this.alterIcon,
    required this.onChecked,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const BUTTON_HEIGHT = 40.0;
    const BUTTON_WIDTH = 40.0;

    return Row(
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ElevatedButton(
          onPressed: () => this.onChecked(),
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
                gradient: LinearGradient(colors: Config.PRIMARY_GRADIENT),
                borderRadius:
                    BorderRadius.all(Radius.circular(BUTTON_HEIGHT / 2))),
            child: Container(
              height: BUTTON_HEIGHT - 4,
              width: BUTTON_WIDTH - 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: value ? Colors.transparent : backgroundColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(BUTTON_HEIGHT / 2)),
              ),
              child: Icon(
                (alterIcon != null && value) ? alterIcon : icon,
                size: 18,
                color: value
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
