import 'dart:async';

import 'package:al_quran/db/db_helper.dart';
import 'package:al_quran/screenns/home_screen.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:flutter/material.dart';

class SplashScreenn extends StatefulWidget {
  const SplashScreenn({super.key});

  @override
  State<SplashScreenn> createState() => _SplashScreennState();
}

class _SplashScreennState extends State<SplashScreenn> {
  @override
  void initState() {
    super.initState();

    loadDatabase();

    Timer(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SafeArea(child: HomeScreen()),
        ),
      );
    });
  }

  void loadDatabase() async {
    await DBHelper.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: colors.bgColor2,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: 220,
              child: Image.asset('assets/images/brand.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Loader(),
          ),
        ],
      ),
    );
  }
}
