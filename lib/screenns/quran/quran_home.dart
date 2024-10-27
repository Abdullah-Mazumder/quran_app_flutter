import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/surah_list_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/search_surah.dart';
import 'package:al_quran/widgets/quran/surah_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuranHome extends StatefulWidget {
  const QuranHome({super.key});

  @override
  State<QuranHome> createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome> {
  String inputText = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SurahListProvider>(context, listen: false)
          .readSurahListFromDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final surahListData = Provider.of<SurahListProvider>(context);
    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);

    List<SingleSurahInfo> filterWithSearchTerm() {
      return surahListData.data.where((surahItem) {
        final escapedTerm = RegExp.escape(inputText);
        final regex = RegExp(escapedTerm, caseSensitive: false);

        return regex.hasMatch(surahItem.nameEn) ||
            regex.hasMatch(surahItem.meaningEn) ||
            regex.hasMatch(surahItem.nameBn) ||
            regex.hasMatch(surahItem.meaningBn) ||
            regex.hasMatch(surahItem.nameAr);
      }).toList();
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SearchSurah(
              onChanged: (value) {
                setState(() {
                  inputText = value;
                });
              },
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: surahListData.isLoading == true
                    ? const Center(
                        child: Loader(),
                      )
                    : ScrollablePositionedList.builder(
                        itemCount: filterWithSearchTerm().length,
                        initialScrollIndex:
                            alQuranInfoProvider.lastReadSurah - 1,
                        itemBuilder: (context, index) {
                          return SurahListItem(
                              surah: filterWithSearchTerm()[index]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
