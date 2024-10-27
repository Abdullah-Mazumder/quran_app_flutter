import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/checkbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerHandler extends StatelessWidget {
  const AudioPlayerHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);

    return Selector<AlQuranInfoProvider, bool>(
      builder: (_, value, __) {
        return CheckboxWithLabel(
          title: language == 'bn' ? "অডিও প্লেয়ার" : "Audio Player",
          value: value,
          onChanged: () {
            alQuranInfoProvider.setIsEnableAudioPlayer();
          },
        );
      },
      selector: (_, provider) => provider.isEnableAudioPlayer,
    );
  }
}
