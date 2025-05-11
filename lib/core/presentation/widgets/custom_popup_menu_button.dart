import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<CustomPopupMenuItem> popupMenuItems;

  const CustomPopupMenuButton({Key? key, required this.popupMenuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context) => [
        for (int i = 0; i < popupMenuItems.length; i++)
          PopupMenuItem<int>(
            value: i,
            onTap: popupMenuItems[i].onTap,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              tileColor: Colors.transparent,
              title: Text(popupMenuItems[i].title),
              leading: popupMenuItems[i].leading,
            ),
          )
      ],
    );
  }
}

class CustomPopupMenuItem {
  const CustomPopupMenuItem({
    required this.onTap,
    required this.title,
    this.leading,
  });

  final VoidCallback onTap;
  final String title;
  final Widget? leading;
}
