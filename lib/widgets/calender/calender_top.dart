import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/screenns/calendar/calender_settings.dart';
import 'package:al_quran/screenns/calendar/location_settings.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CalenderTop extends StatelessWidget {
  const CalenderTop({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    return Container(
      color: colors.bgColor1,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.locationCrosshairs,
                color: colors.txtColor,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationSettings(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          calenderInfoProvider.address.length > 20
                              ? '${calenderInfoProvider.address.substring(0, 20)}...'
                              : calenderInfoProvider.address,
                          style:
                              TextStyle(fontSize: 14, color: colors.txtColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FaIcon(
                          FontAwesomeIcons.caretDown,
                          color: colors.txtColor.withOpacity(0.5),
                          size: 18,
                        )
                      ],
                    ),
                    CustomText(text: calenderInfoProvider.country),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalenderSettings(),
                ),
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.sliders,
              color: colors.txtColor,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
