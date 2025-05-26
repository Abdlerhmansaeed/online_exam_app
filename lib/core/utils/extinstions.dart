import 'package:flutter/material.dart' show BuildContext, MaterialPageRoute, Navigator, Theme, ThemeData, Widget;
import 'package:flutter/widgets.dart' show MediaQuery;

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  ThemeData get theme => Theme.of(this); 
  
}

extension NavigatorExtension on BuildContext {
  void navigateTo(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void navigateAndFinish(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }

  void navigateAndReplace(Widget page) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
  void navigateAndPop(Widget page) {
    Navigator.pop(
      this,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
  
}
