import 'package:flutter/material.dart';

import '../models/configuaration.dart';

class MenuAddingDirection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget directionMenuItem(String label, Function onPressed) {
      return ElevatedButton(
        child: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            label,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.black45,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        onPressed: () => onPressed(),
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: const EdgeInsets.only(top: 25, bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Adding new tasks',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 15),
              directionMenuItem('Add on top', () {
                Navigator.of(context).pop(AddDirection.Top);
              }),
              directionMenuItem('Add bottom', () {
                Navigator.of(context).pop(AddDirection.Bottom);
              }),
              Center(
                child: TextButton(
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 18),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
