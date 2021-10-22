import 'package:flutter/material.dart';

import './main_screen.dart';
import '../widgets/gradient_stadium_button.dart';
import '../widgets/welcome_page.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _dotIndicator(int page) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 25),
        child: Icon(
          Icons.circle,
          color: _currentPage == page
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey[300],
          size: 10,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              WelcomePage(
                  title: 'Plan',
                  subtitle:
                      'Create a list of tasks that\nyou want to do tommorow.',
                  imagePath: '/images/welcome/1-plan.png'),
              WelcomePage(
                  title: 'Perform',
                  subtitle:
                      'Complete the tasks over the next day.\nWhen the day ends the tasks all\ndisappear.',
                  imagePath: '/images/welcome/2-perform.png'),
              WelcomePage(
                  title: 'Statistics',
                  subtitle:
                      'All completed and failed tasks will be stored\nin your statistics.',
                  imagePath: '/images/welcome/3-statistics.png'),
              WelcomePage(
                  title: 'Focus',
                  subtitle:
                      'Everything you couldn\'t do you can repeat\nagain, if it is important.',
                  imagePath: '/images/welcome/4-focus.png'),
              WelcomePage(
                  title: 'Be successful!',
                  subtitle: 'Try to complete all tasks throughout the day.',
                  imagePath: '/images/welcome/5-be-successful.png'),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              // width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _currentPage != 4
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _dotIndicator(0),
                            _dotIndicator(1),
                            _dotIndicator(2),
                            _dotIndicator(3),
                            _dotIndicator(4),
                          ],
                        )
                      : GradientStadiumButton(
                          label: 'CREATE PLAN',
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.077,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(MainScreen.routeName);
                          })),
            ),
          ),
        ],
      ),
    );
  }
}
