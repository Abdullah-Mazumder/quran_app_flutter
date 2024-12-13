import 'dart:async';

import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final void Function() onPress;
  const Button({super.key, required this.label, required this.onPress});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 50,
      ),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    _scale = 1 - _controller.value;

    return Transform.scale(
      scale: _scale,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.activeColor1,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Material(
          color: colors.activeColor2,
          child: InkWell(
            splashColor: colors.activeColor1.withOpacity(1),
            onTapDown: (details) => _controller.forward(),
            onTapUp: (details) => _controller.reverse(),
            onTap: () {
              Timer(const Duration(milliseconds: 200), () {
                widget.onPress();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 10,
              ),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
