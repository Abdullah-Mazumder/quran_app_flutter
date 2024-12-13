import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/allah_logo.dart';
import 'package:al_quran/widgets/muhammad_logo.dart';
import 'package:flutter/material.dart';

class SearchSurah extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchSurah({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final language = getLanguage(context);

    return Container(
      color: theme.colors.bgColor1,
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AllahLogo(),
          Expanded(
            child: Container(
              height: 38,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: TextField(
                onChanged: onChanged,
                cursorColor: theme.colors.activeColor1,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.search,
                      color: theme.colors.activeColor1,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText:
                      language == 'en' ? "Search Surah..." : "সূরা খুঁজুন...",
                  hintStyle: TextStyle(
                    color: theme.colors.activeColor1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: theme.colors.bgColor2,
                ),
                style: TextStyle(
                  color: theme.colors.activeColor1,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const MuhammadLogo(),
        ],
      ),
    );
  }
}
