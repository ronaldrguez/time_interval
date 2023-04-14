import 'package:app_navigator/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:time_interval/main.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (AppNavigator().pages.value.length > 1) {
          AppNavigator().pop();
          return false;
        } else {
          return false;
        }
      },
      child: const NavigationLayer(
        initPage: App(),
        initPath: 'root',
      ),
    );
  }
}
