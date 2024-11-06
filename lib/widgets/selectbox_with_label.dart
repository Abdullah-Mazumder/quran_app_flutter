import 'package:al_quran/models/app/dropdown_item_model.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/select_box.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SelectBoxWithLabel extends StatelessWidget {
  final List<DropdownItem> items;
  final int? width;
  final int? height;
  final void Function(String?)? onChanged;
  final String value;
  final String label;
  final Color? bgColor;

  SelectBoxWithLabel({
    super.key,
    required this.items,
    this.width = 120,
    this.height = 200,
    required this.onChanged,
    required this.value,
    required this.label,
    this.bgColor,
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
          padding:
              const EdgeInsets.only(left: 15, right: 12, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: label,
                additionalStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SelectBox(
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
