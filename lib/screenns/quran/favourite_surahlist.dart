import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/favorite_surah_list_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/surah_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavouriteSurahList extends HookWidget {
  const FavouriteSurahList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);
    final favouriteSurahListProvider =
        Provider.of<FavouriteSurahListProvider>(context);

    int totalItem = alQuranInfoProvider.favouriteSurahList.length;

    useEffect(() {
      List<int> keys = alQuranInfoProvider.favouriteSurahList.keys
          .map<int>((id) => int.parse(id))
          .toList();
      keys.sort();

      favouriteSurahListProvider.readSurahInfoWithSurahIds(keys);

      totalItem = alQuranInfoProvider.favouriteSurahList.length;

      return null;
    }, [totalItem]);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.solidHeart,
              title: language == 'bn'
                  ? 'প্রিয় সূরা তালিকা'
                  : 'Favorite Surah List',
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: favouriteSurahListProvider.isLoading
                    ? const Center(
                        child: Loader(),
                      )
                    : favouriteSurahListProvider.data.isEmpty
                        ? Center(
                            child: CustomText(
                              text: language == 'bn'
                                  ? 'আপনার প্রিয় সূরা তালিকা খালি!'
                                  : 'Your favorite surah list is empty!',
                              additionalStyle: TextStyle(
                                fontSize: 18,
                                color: colors.activeColor1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : SizedBox(
                            child: ListView.builder(
                              itemCount: favouriteSurahListProvider.data.length,
                              itemBuilder: (context, index) {
                                return SurahListItem(
                                    surah:
                                        favouriteSurahListProvider.data[index]);
                              },
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
