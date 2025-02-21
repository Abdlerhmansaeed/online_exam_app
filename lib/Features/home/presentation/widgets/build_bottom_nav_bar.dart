// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
class BuildBottomNavBar extends StatelessWidget {
   int selectedIndex;
  void Function(int)? onTabFunction;
  BuildContext context;

   BuildBottomNavBar({
    Key? key,
required this.context,
    required this.selectedIndex,
    required this.onTabFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
     
    onTap: onTabFunction,
      currentIndex: selectedIndex ,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/result_icon.png'),),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
  }
}
