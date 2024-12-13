import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String getLanguage(BuildContext context) {
  return context.select((AppInfoProvider value) {
    return value.language;
  });
}
