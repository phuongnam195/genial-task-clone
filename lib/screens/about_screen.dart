import 'package:flutter/material.dart';

import '../widgets/genial_appbar.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/more/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenialAppBar(title: 'About'),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    './assets/images/icon.png',
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(height: 15),
              Text(
                'GenialTask',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Version 2.4',
                style: TextStyle(
                    color: Color(0xFF8A98B1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 50),
              Text('Cloned by Phuong Nam',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
