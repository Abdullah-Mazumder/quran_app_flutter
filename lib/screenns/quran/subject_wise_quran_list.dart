import 'package:al_quran/provider/alQuran/subject_wise_quran_list_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/sub_wise_quran_list_item.dart';
import 'package:flutter/material.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SubjectWiseQuranList extends HookWidget {
  const SubjectWiseQuranList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    final subjectWiseQuranListProvider =
        Provider.of<SubjectWiseQuranListProvider>(context);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        subjectWiseQuranListProvider.readQuranSubjectList();
      });
      return null;
    }, []);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(
              title: 'বিষয় ভিত্তিক আল-কুরআন',
              icon: FontAwesomeIcons.book,
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: subjectWiseQuranListProvider.isLoading
                    ? const Center(
                        child: Loader(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return SubWiseQuranListItem(
                              subject: subjectWiseQuranListProvider.data[index],
                              id: index + 1);
                        },
                        itemCount: subjectWiseQuranListProvider.data.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
