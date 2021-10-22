import 'package:flutter/material.dart';

class GenialAppBarTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onPressed;

  GenialAppBarTab(
      {required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      highlightColor: Colors.white10,
      splashColor: Colors.white12,
      splashFactory: InkRipple.splashFactory,
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
        child: Column(
          children: [
            Text(
              label,
              style: isSelected
                  ? Theme.of(context).textTheme.headline1
                  : Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white38),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Icon(Icons.circle,
                    color: Theme.of(context).colorScheme.secondary, size: 10),
              ),
          ],
        ),
      ),
    );
  }
}
