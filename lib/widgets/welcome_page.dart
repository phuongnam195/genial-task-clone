import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  WelcomePage(
      {required this.title, required this.subtitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(flex: 2),
            Expanded(
              flex: 5,
              child: Image.asset(
                imagePath,
                // height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(flex: 2),
          ],
        ));
  }
}
