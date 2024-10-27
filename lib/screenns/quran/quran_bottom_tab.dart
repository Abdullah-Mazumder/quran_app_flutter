// ignore_for_file: deprecated_member_use

import 'package:al_quran/screenns/quran/bookmarked_list.dart';
import 'package:al_quran/screenns/quran/favourite_surahlist.dart';
import 'package:al_quran/screenns/quran/quran_home.dart';
import 'package:al_quran/screenns/quran/mushaf_quran_list.dart';
import 'package:al_quran/screenns/quran/subject_wise_quran_list.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuranBottomTab extends StatefulWidget {
  const QuranBottomTab({
    super.key,
  });

  @override
  State<QuranBottomTab> createState() => _QuranBottomTabState();
}

class _QuranBottomTabState extends State<QuranBottomTab> {
  int selectedIndex = 2;

  List<Widget> screens = [
    const BookmarkedList(),
    const FavouriteSurahList(),
    const QuranHome(),
    const MushafQuranList(),
    const SubjectWiseQuranList(),
  ];

  List<int> tracker = [];

  void selectedIndexHandler(int index) {
    int len = tracker.length;

    if (len == 0) {
      tracker.add(index);
    } else {
      int lastEl = tracker.last;
      if (lastEl != index) {
        tracker.add(index);
      }
    }

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 45,
          backgroundColor: colors.bgColor1,
          elevation: 0,
          selectedIndex: selectedIndex,
          destinations: [
            Material(
              color: colors.bgColor1,
              child: InkWell(
                splashColor: colors.activeColor1.withOpacity(0.2),
                onTap: () => selectedIndexHandler(0),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.solidBookmark,
                    size: 20,
                    color: selectedIndex == 0
                        ? colors.activeColor1
                        : colors.txtColor,
                  ),
                ),
              ),
            ),
            Material(
              color: colors.bgColor1,
              child: InkWell(
                splashColor: colors.activeColor1.withOpacity(0.2),
                onTap: () => selectedIndexHandler(1),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.solidHeart,
                    size: 20,
                    color: selectedIndex == 1
                        ? colors.activeColor1
                        : colors.txtColor,
                  ),
                ),
              ),
            ),
            Material(
              color: colors.bgColor1,
              child: InkWell(
                splashColor: colors.activeColor1.withOpacity(0.2),
                onTap: () => selectedIndexHandler(2),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.house,
                    size: 20,
                    color: selectedIndex == 2
                        ? colors.activeColor1
                        : colors.txtColor,
                  ),
                ),
              ),
            ),
            Material(
              color: colors.bgColor1,
              child: InkWell(
                splashColor: colors.activeColor1.withOpacity(0.2),
                onTap: () => selectedIndexHandler(3),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.quran,
                    size: 20,
                    color: selectedIndex == 3
                        ? colors.activeColor1
                        : colors.txtColor,
                  ),
                ),
              ),
            ),
            Material(
              color: colors.bgColor1,
              child: InkWell(
                splashColor: colors.activeColor1.withOpacity(0.2),
                onTap: () => selectedIndexHandler(4),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.book,
                    size: 20,
                    color: selectedIndex == 4
                        ? colors.activeColor1
                        : colors.txtColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (selectedIndex == 2) return true;

            setState(() {
              selectedIndex = 2;
            });

            return false;
          },
          child: screens[selectedIndex],
        ),
      ),
    );
  }
}
