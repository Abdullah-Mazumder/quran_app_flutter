import 'package:al_quran/screenns/doa/doa_by_category.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Doa extends StatelessWidget {
  const Doa({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: CustomText(
              text: language == 'bn' ? 'দোয়া' : 'Doa',
              additionalStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colors.activeColor1,
              ),
            ),
            backgroundColor: colors.bgColor1,
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: colors.activeColor1,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor:
                  WidgetStatePropertyAll(colors.activeColor2.withOpacity(0.3)),
              tabs: [
                Tab(
                  child: CustomText(
                    text: language == 'bn' ? 'বিষয়' : 'Subject',
                    additionalStyle: TextStyle(
                      color: colors.activeColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: CustomText(
                    text: language == 'bn' ? 'সব দোয়া' : 'All Doa',
                    additionalStyle: TextStyle(
                      color: colors.activeColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DoaByCategory(),
              Icon(Icons.card_membership),
            ],
          ),
        ),
      ),
    );
  }
}
