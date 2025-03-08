import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;

  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
          color: Colors.green.shade400,
          activeColor: Colors.lightGreen[50],
          tabActiveBorder:
              Border.all(color: Color.fromARGB(255, 250, 246, 246)),
          tabBackgroundColor: Color(0xFF505C45),
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 16,
          onTabChange: (value) => onTabChange!(value),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: ' ANA SAYFA',
            ),
            GButton(
              icon: Icons.info,
              text: ' BİLGİ VE ÇÖZÜMLER ',
            ),
          ]),
    );
  }
}
