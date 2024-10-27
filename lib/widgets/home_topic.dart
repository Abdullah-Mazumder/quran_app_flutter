import 'dart:async';

import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class HomeTopic extends StatelessWidget {
  final String title;
  final String? imagePath;
  final Widget nextScreen;
  final int width;
  final Widget? icon;

  const HomeTopic({
    Key? key,
    this.imagePath,
    required this.title,
    required this.nextScreen,
    this.width = 40,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.activeColor1,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Material(
        color: colors.bgColor2,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: colors.activeColor1.withOpacity(0.3),
          onTap: () {
            Timer(const Duration(milliseconds: 400), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => nextScreen,
                ),
              );
            });
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.bgColor1,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  width: 60,
                  height: 60,
                  child: imagePath != null
                      ? Center(
                          child: Image.asset(
                            imagePath!,
                            width: width.toDouble(),
                          ),
                        )
                      : Center(
                          child: icon,
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.txtColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'regularFont',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
