import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusAndNavigationBarProvider extends StatelessWidget {
  final Widget child;

  const StatusAndNavigationBarProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: getTheme(context).colors.bgColor1,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: getTheme(context).colors.bgColor1,
        ),
        child: child,
      ),
    );
  }
}
