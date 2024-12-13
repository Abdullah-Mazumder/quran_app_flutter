import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_pressable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoaByCategory extends StatelessWidget {
  const DoaByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    final List<Map<String, dynamic>> categories = [
      {"id": 8, "name": "সালাত", "icon": FontAwesomeIcons.personPraying},
      {"id": 7, "name": "পবিত্রতা", "icon": FontAwesomeIcons.faucet},
      {"id": 17, "name": "কুরআনের দোয়া", "icon": FontAwesomeIcons.bookQuran},
      {"id": 5, "name": "রামাদান - সিয়াম", "icon": FontAwesomeIcons.moon},
      {"id": 6, "name": "হজ্জ - উমরা", "icon": FontAwesomeIcons.kaaba},
      {"id": 1, "name": "ঘুম", "icon": FontAwesomeIcons.bed},
      {"id": 2, "name": "সকাল - সন্ধ্যা", "icon": FontAwesomeIcons.cloudSun},
      {"id": 3, "name": "পরিবার", "icon": FontAwesomeIcons.peopleRoof},
      {"id": 4, "name": "সামাজিক", "icon": FontAwesomeIcons.shareNodes},
      {"id": 9, "name": "খাদ্য ও পানীয়", "icon": FontAwesomeIcons.pizzaSlice},
      {
        "id": 10,
        "name": "সম্পত্তি - রিজিক",
        "icon": FontAwesomeIcons.houseChimney
      },
      {"id": 11, "name": "সফর", "icon": FontAwesomeIcons.road},
      {"id": 12, "name": "প্রকৃতি", "icon": FontAwesomeIcons.tree},
      {
        "id": 13,
        "name": "শুকরিয়া - অনুতাপ",
        "icon": FontAwesomeIcons.faceSadTear
      },
      {
        "id": 14,
        "name": "অসুস্থতা - মৃত্যু",
        "icon": FontAwesomeIcons.virusCovid
      },
      {
        "id": 15,
        "name": "আশ্রয় প্রার্থনা",
        "icon": FontAwesomeIcons.personPraying
      },
      {"id": 18, "name": "রুকইয়াহ", "icon": FontAwesomeIcons.suitcaseMedical},
      {"id": 19, "name": "কাপড় পরিধান", "icon": FontAwesomeIcons.shirt}
    ];

    return Container(
      padding: const EdgeInsets.all(8),
      color: colors.bgColor2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ItemCard(
            title: categories[index]['name'],
            icon: categories[index]['icon'],
            id: categories[index]['id'],
          );
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int id;

  const ItemCard(
      {super.key, required this.title, required this.icon, required this.id});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.activeColor2.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: StyledPressable(
        onPress: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: colors.activeColor1),
            const SizedBox(height: 10),
            CustomText(text: title),
          ],
        ),
      ),
    );
  }
}
