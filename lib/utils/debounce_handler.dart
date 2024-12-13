import 'dart:async';

import 'package:flutter/material.dart';

VoidCallback debounceHandler(VoidCallback callback,
    {Duration duration = const Duration(milliseconds: 300)}) {
  Timer? timer;

  return () {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    timer = Timer(duration, () {
      callback();
    });
  };
}
