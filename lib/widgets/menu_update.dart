import 'package:flutter/material.dart';

class MenuUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget menuItem(String label, int value, {Color? textColor}) {
      return ElevatedButton(
        child: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
          child: Text(
            label,
            style: TextStyle(
              color: textColor == null
                  ? Theme.of(context).primaryColor
                  : textColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.black45,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.of(context).pop(value);
        },
      );
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            menuItem('Edit', 1),
            menuItem('Sort', 2),
            menuItem('Delete', 3, textColor: Theme.of(context).accentColor),
            menuItem('Cancel', 4),
          ],
        ),
      ),
    );
  }
}
