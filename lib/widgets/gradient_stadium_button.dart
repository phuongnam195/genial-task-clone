import 'package:flutter/material.dart';

import '../models/configuaration.dart';

class GradientStadiumButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Function onPressed;

  GradientStadiumButton({
    required this.label,
    required this.width,
    required this.height,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => this.onPressed(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.height / 2),
          ),
          padding: EdgeInsets.zero,
          fixedSize: Size(this.width, this.height),
          elevation: 0,
        ),
        child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: Config.PRIMARY_GRADIENT),
                borderRadius:
                    BorderRadius.all(Radius.circular(this.height / 2))),
            child: Container(
              height: this.height,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: this.height / 3.5),
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
