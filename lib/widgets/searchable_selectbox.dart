import 'package:al_quran/state_helper/get_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchableSelectbox extends StatefulWidget {
  final bool isSearchable;
  final List<DropdownMenuItem<String>> items;
  final int? width;
  final int? height;
  final void Function(String?)? onChanged;
  final String value;
  final GlobalKey? selectBoxKey;

  const SearchableSelectbox({
    super.key,
    this.isSearchable = true,
    required this.items,
    this.width = 120,
    this.height = 200,
    required this.onChanged,
    required this.value,
    this.selectBoxKey,
  });

  @override
  State<SearchableSelectbox> createState() => _SearchableSelectboxState();
}

class _SearchableSelectboxState extends State<SearchableSelectbox> {
  bool isOpenSelectBox = false;

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final TextEditingController textEditingController = TextEditingController();

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        key: widget.selectBoxKey,
        onMenuStateChange: (isOpen) {
          setState(() {
            isOpenSelectBox = isOpen;
          });
        },
        items: widget.items,
        value: widget.value,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(
          height: 35,
          width: widget.width!.toDouble(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.activeColor1, width: 3),
            color: colors.bgColor1,
          ),
          elevation: 20,
        ),
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: FaIcon(
              isOpenSelectBox
                  ? FontAwesomeIcons.caretUp
                  : FontAwesomeIcons.caretDown,
              color: colors.activeColor1,
            ),
          ),
          iconSize: 18,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: widget.height!.toDouble(),
          width: widget.width!.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.bgColor1,
            border: Border.all(width: 3, color: colors.activeColor1),
          ),
          offset: const Offset(0, -5),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(0),
            thumbVisibility: WidgetStateProperty.all<bool>(false),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40,
          selectedMenuItemBuilder: (context, child) {
            return Container(
              color: colors.activeColor1.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [child],
              ),
            );
          },
        ),
        dropdownSearchData: widget.isSearchable
            ? DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 100,
                searchInnerWidget: Container(
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    cursorColor: colors.txtColor,
                    style: TextStyle(color: colors.txtColor),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(fontSize: 14, color: colors.txtColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: colors.activeColor1, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: colors.activeColor1, width: 2),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  // Define the regular expression for the search value (case-insensitive)
                  final regex = RegExp(
                    searchValue, // Search pattern
                    caseSensitive: false, // Case insensitive search
                  );

                  // Check if the search value matches any of the item's fields using regex
                  return regex.hasMatch(item.value.toString());
                },
              )
            : null,
        //This to clear the search value when you close the menu
      ),
    );
  }
}
