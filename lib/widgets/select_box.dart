import 'package:al_quran/models/app/dropdown_item_model.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectBox extends StatefulWidget {
  final List<DropdownItem> items;
  final int? width;
  final int? height;
  final void Function(String?)? onChanged;
  final String value;
  final GlobalKey? selectBoxKey;

  const SelectBox({
    super.key,
    required this.items,
    this.width = 120,
    this.height = 200,
    required this.onChanged,
    required this.value,
    this.selectBoxKey,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool isOpenSelectBox = false;

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        key: widget.selectBoxKey,
        onMenuStateChange: (isOpen) {
          setState(() {
            isOpenSelectBox = isOpen;
          });
        },
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: language == 'en' ? item.labelEn : item.labelBn,
                  additionalStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'normal',
                    fontSize: 13.5,
                    color: colors.txtColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
        value: widget.value,
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
      ),
    );
  }
}
