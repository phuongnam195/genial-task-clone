import 'package:flutter/material.dart';

class GenialAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;

  @override
  final Size preferredSize;

  GenialAppBar({Key? key, required this.title, this.trailing})
      : preferredSize = Size.fromHeight(80),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // toolbarHeight: 80,
      flexibleSpace: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(
                  Icons.west,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              this.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            Spacer(),
            if (trailing != null) this.trailing!,
          ],
        ),
      ),
    );
  }
}
