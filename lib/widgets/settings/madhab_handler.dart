import 'package:al_quran/models/app/dropdown_item_model.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MadhabHandler extends StatelessWidget {
  const MadhabHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    final List<DropdownItem> madhabs = [
      DropdownItem(value: 'hanafi', labelEn: 'Hanafi', labelBn: 'হানাফী'),
      DropdownItem(
          value: 'shafeyi',
          labelEn: 'Shafeyi, Maleki & Hambli',
          labelBn: 'শাফেয়ী, মালেকী ও হাম্বলী'),
    ];

    return SelectBoxWithLabel(
      width: 250,
      items: madhabs,
      onChanged: (value) {
        calenderInfoProvider.setMadhab(madhab: value);
      },
      value: calenderInfoProvider.madhab,
      label: language == 'en' ? 'Madhab' : 'মাজহাব',
    );
  }
}
