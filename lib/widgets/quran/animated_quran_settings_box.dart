import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/quran/quran_settings_items.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AnimatedQuranSettingsBox extends StatelessWidget {
  const AnimatedQuranSettingsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Selector<AlQuranInfoProvider, bool>(
      selector: (_, provider) => provider.isQuranSettingsBoxOpen,
      builder: (_, isOpen, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isOpen ? (screenHeight / 2) : 0,
          color: colors.bgColor2,
          curve: Curves.easeIn,
          child: Column(
            children: [
              Container(
                color: colors.bgColor1,
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: language == 'bn' ? "সেটিংস" : "Settings",
                      additionalStyle: TextStyle(
                        fontSize: 19,
                        color: colors.activeColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FaIcon(
                        FontAwesomeIcons.gear,
                        color: colors.activeColor1,
                        size: 16.5,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: colors.bgColor2,
                    child: const QuranSettings(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
