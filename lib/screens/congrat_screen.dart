import 'package:flutter/material.dart';
import '../models/configuaration.dart';

class CongratScreen extends StatelessWidget {
  const CongratScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Config.PRIMARY_GRADIENT,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
    );
  }
}
