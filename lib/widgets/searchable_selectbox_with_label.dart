import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SearchableSelectboxWithLabel extends StatelessWidget {
  final bool isSearchable;
  final List<DropdownMenuItem<String>> items;
  final int? width;
  final int? height;
  final void Function(String?)? onChanged;
  final String value;
  final String label;
  final Color? bgColor;
  final double pl;
  final double pr;
  final double pt;
  final double pb;

  SearchableSelectboxWithLabel({
    super.key,
    this.isSearchable = true,
    required this.items,
    this.width = 120,
    this.height = 200,
    required this.onChanged,
    required this.value,
    required this.label,
    this.bgColor,
    this.pl = 10,
    this.pr = 10,
    this.pt = 5,
    this.pb = 5,
  });

  final GlobalKey<DropdownButton2State<String>> dropdownKey =
      GlobalKey<DropdownButton2State<String>>();

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Material(
      color: bgColor ?? colors.bgColor2,
      child: InkWell(
        onTap: () {
          dropdownKey.currentState!.callTap();
        },
        splashColor: colors.activeColor1.withOpacity(0.2),
        child: Padding(
          padding: EdgeInsets.only(left: pl, right: pr, top: pt, bottom: pb),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: label,
                additionalStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SearchableSelectbox(
                isSearchable: isSearchable,
                items: items,
                onChanged: onChanged,
                value: value,
                selectBoxKey: dropdownKey,
                width: width!,
                height: height!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
