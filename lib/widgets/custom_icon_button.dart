import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final Widget icon;
  final void Function() onPress;

  const CustomIconButton(
      {super.key, required this.icon, required this.onPress});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
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
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: colors.activeColor1),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Material(
          color: colors.bgColor2,
          child: InkWell(
            onTap: widget.onPress,
            onTapDown: (details) => _controller.forward(),
            onTapUp: (details) => _controller.reverse(),
            splashColor: colors.activeColor1.withOpacity(0.3),
            child: Center(
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}
