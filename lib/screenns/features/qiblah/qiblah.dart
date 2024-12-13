import 'package:al_quran/screenns/features/qiblah/qiblah_compass.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/get_location_permission.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Qiblah extends StatefulWidget {
  const Qiblah({super.key});

  @override
  State<Qiblah> createState() => _QiblahState();
}

class _QiblahState extends State<Qiblah> {
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  Future<void> getPermission() async {
    hasPermission = await getLocationPermission();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        body: hasPermission
            ? Column(
                children: [
                  CustomAppBar(
                    icon: FontAwesomeIcons.kaaba,
                    title: language == 'bn' ? 'কিবলাহ' : 'Qiblah',
                  ),
                  Expanded(
                    child: Container(
                      color: colors.bgColor2,
                      child: const QiblahCompass(),
                    ),
                  ),
                ],
              )
            : Container(
                color: colors.bgColor2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: language == 'bn'
                            ? "অবস্থান অ্যাক্সেস অস্বীকৃত!"
                            : "Location access denied!",
                        additionalStyle: TextStyle(
                          color: colors.activeColor1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: getPermission,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(colors.activeColor1),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.rotateLeft,
                          color: Colors.white,
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
