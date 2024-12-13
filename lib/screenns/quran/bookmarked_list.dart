import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/bookmarked_list_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/bookmarked_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookmarkedList extends HookWidget {
  const BookmarkedList({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;

    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);
    final bookmarkedListProvider = Provider.of<BookmarkedListProvider>(context);

    int bookmarkedListVersion = alQuranInfoProvider.bookmarkedList.length;

    useEffect(() {
      final keys = alQuranInfoProvider.bookmarkedList.keys.toList();
      List<Map<String, int>> conditions = keys.map<Map<String, int>>((item) {
        var surahId = int.parse(item.split('_')[0]);
        var verseId = int.parse(item.split('_')[1]);

        return {
          'surahId': surahId,
          'verseId': verseId,
        };
      }).toList();

      bookmarkedListProvider.readVersesWithSurahIdAndVerseId(conditions);

      bookmarkedListVersion = alQuranInfoProvider.bookmarkedList.length;

      return null;
    }, [bookmarkedListVersion]);

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            icon: FontAwesomeIcons.solidBookmark,
            title: language == 'bn' ? 'বুকমার্ক করা তালিকা' : 'Bookmarked List',
          ),
          Expanded(
            child: Container(
              color: colors.bgColor2,
              child: bookmarkedListProvider.isLoading
                  ? const Center(
                      child: Loader(),
                    )
                  : bookmarkedListProvider.data.isEmpty
                      ? Center(
                          child: CustomText(
                            text: language == 'bn'
                                ? 'আপনার বুকমার্ক করা তালিকা খালি!'
                                : 'Your bookmarked list is empty!',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: colors.activeColor1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : SizedBox(
                          child: ListView.builder(
                            itemCount: bookmarkedListProvider.data.length,
                            itemBuilder: (context, index) {
                              return BookmarkedListItem(
                                verse: bookmarkedListProvider.data[index],
                                id: index + 1,
                                totalVerse: bookmarkedListProvider.data.length,
                              );
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
    ));
  }
}
