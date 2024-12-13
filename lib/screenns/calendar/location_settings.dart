import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/calender/country_selection.dart';
import 'package:al_quran/widgets/calender/location_selection.dart';
import 'package:al_quran/widgets/calender/render_google_map.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationSettings extends StatelessWidget {
  const LocationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.locationCrosshairs,
              title: language == 'en' ? "Location Settings" : 'লোকেশন সেটিংস',
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                color: colors.bgColor2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: CustomText(
                          text: language == 'en'
                              ? 'Set your location for calculating Salat, Iftar and Sehri time properl!'
                              : 'সালাত, ইফতার এবং সেহরি এর সময় সঠিকভাবে হিসাব করার জন্য আপনার লোকেশন সেট করুন!',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const CountrySelection(),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: CustomText(
                          text: language == 'en'
                              ? 'Select the method of setting location!'
                              : 'লোকেশন সেট করার পদ্ধতি সিলেক্ট করুন!',
                        ),
                      ),
                      const LocationSelection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: RenderGoogleMap(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
