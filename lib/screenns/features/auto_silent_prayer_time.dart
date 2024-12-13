import 'package:al_quran/provider/app/silent_prayer_time_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/timeofday_to_mill..dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:provider/provider.dart';

class AutoSilentPrayerTime extends StatelessWidget {
  const AutoSilentPrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;

    final prayerTimeProvider = Provider.of<SilentPrayerTimeProvider>(context);

    const platform = MethodChannel('com.abdullah.alQuran.com');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.volumeXmark,
              title: language == 'bn'
                  ? 'নামাজের সময় অটো সাইলেন্ট'
                  : 'Auto silent in prayer time',
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Fajr Start
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text: language == 'bn' ? 'ফজর  ' : 'Fajar  ',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.fajrStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setFajrStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'fajrStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'fajrEnd'});

                                        prayerTimeProvider.setIsFajrEnabled(
                                            value: false);
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.fajrStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.fajrEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setFajrEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'fajrStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'fajrEnd'});

                                        prayerTimeProvider.setIsFajrEnabled(
                                            value: false);
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.fajrEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isFajrEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    final v = await platform
                                        .invokeMethod('enableDndTask', {
                                      'startTime': timeofday_to_mill(
                                          prayerTimeProvider.fajrStart),
                                      'uniqueId': 'fajrStart',
                                      'prayer': 'Fajar'
                                    });

                                    print('=================');
                                    print(v);

                                    await platform.invokeMethod(
                                        'disableDndTask', {
                                      'endTime': timeofday_to_mill(
                                          prayerTimeProvider.fajrEnd),
                                      'uniqueId': 'fajrEnd'
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  try {
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'fajrStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'fajrEnd'});
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                                prayerTimeProvider.setIsFajrEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Juhr Start
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text:
                                      language == 'bn' ? 'যুহর    ' : 'Juhar  ',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.juhrStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setJuhrStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'juhrStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'juhrEnd'});

                                        prayerTimeProvider.setIsJuhrEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.juhrStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.juhrEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setJuhrEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'juhrStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'juhrEnd'});

                                        prayerTimeProvider.setIsJuhrEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.juhrEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isJuhrEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    await platform
                                        .invokeMethod('enableDndTask', {
                                      'startTime': timeofday_to_mill(
                                          prayerTimeProvider.juhrStart),
                                      'uniqueId': 'juhrStart',
                                      'prayer': 'Juhar'
                                    });
                                    await platform.invokeMethod(
                                        'disableDndTask', {
                                      'endTime': timeofday_to_mill(
                                          prayerTimeProvider.juhrEnd),
                                      'uniqueId': 'juhrEnd'
                                    });
                                  } catch (_) {}
                                } else {
                                  try {
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'juhrStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'juhrEnd'});
                                  } catch (_) {}
                                }
                                prayerTimeProvider.setIsJuhrEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Asar Start
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text: language == 'bn' ? 'আসর  ' : 'Asar    ',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.asrStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setAsrStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'asrStart'});
                                        await platform.invokeMethod(
                                            'stopTask', {'uniqueId': 'asrEnd'});

                                        prayerTimeProvider.setIsAsrEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.asrStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.asrEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setAsrEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'asrStart'});
                                        await platform.invokeMethod(
                                            'stopTask', {'uniqueId': 'asrEnd'});

                                        prayerTimeProvider.setIsAsrEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.asrEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isAsrEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    await platform
                                        .invokeMethod('enableDndTask', {
                                      'startTime': timeofday_to_mill(
                                          prayerTimeProvider.asrStart),
                                      'uniqueId': 'asrStart',
                                      'prayer': 'Asar'
                                    });
                                    await platform.invokeMethod(
                                        'disableDndTask', {
                                      'endTime': timeofday_to_mill(
                                          prayerTimeProvider.asrEnd),
                                      'uniqueId': 'asrEnd'
                                    });
                                  } catch (_) {}
                                } else {
                                  try {
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'asrStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'asrEnd'});
                                  } catch (_) {}
                                }
                                prayerTimeProvider.setIsAsrEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Maghrib Start
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text: language == 'bn' ? 'মাগরিব' : 'Magrib',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: prayerTimeProvider
                                                .maghribStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setMaghribStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'magribStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'magribEnd'});

                                        prayerTimeProvider.setIsMaghribEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.maghribStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.maghribEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setMaghribEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'magribStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'magribEnd'});

                                        prayerTimeProvider.setIsMaghribEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.maghribEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isMaghribEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    await platform
                                        .invokeMethod('enableDndTask', {
                                      'startTime': timeofday_to_mill(
                                          prayerTimeProvider.maghribStart),
                                      'uniqueId': 'magribStart',
                                      'prayer': 'Magrib'
                                    });
                                    await platform
                                        .invokeMethod('disableDndTask', {
                                      'endTime': timeofday_to_mill(
                                          prayerTimeProvider.maghribEnd),
                                      'uniqueId': 'magribEnd'
                                    });
                                  } catch (_) {}
                                } else {
                                  try {
                                    await platform.invokeMethod('stopTask',
                                        {'uniqueId': 'magribStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'magribEnd'});
                                  } catch (_) {}
                                }
                                prayerTimeProvider.setIsMaghribEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Esa Start
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text: language == 'bn'
                                      ? 'এসা      '
                                      : 'Esa       ',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.esaStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setEsaStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'esaStart'});
                                        await platform.invokeMethod(
                                            'stopTask', {'uniqueId': 'esaEnd'});

                                        prayerTimeProvider.setIsEsaEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.esaStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.esaEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setEsaEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'esaStart'});
                                        await platform.invokeMethod(
                                            'stopTask', {'uniqueId': 'esaEnd'});

                                        prayerTimeProvider.setIsEsaEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.esaEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isEsaEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    await platform
                                        .invokeMethod('enableDndTask', {
                                      'startTime': timeofday_to_mill(
                                          prayerTimeProvider.esaStart),
                                      'uniqueId': 'esaStart',
                                      'prayer': 'Esa'
                                    });
                                    await platform.invokeMethod(
                                        'disableDndTask', {
                                      'endTime': timeofday_to_mill(
                                          prayerTimeProvider.esaEnd),
                                      'uniqueId': 'esaEnd'
                                    });
                                  } catch (_) {}
                                } else {
                                  try {
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'esaStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'esaEnd'});
                                  } catch (_) {}
                                }
                                prayerTimeProvider.setIsEsaEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Juma Start
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        decoration: BoxDecoration(
                          color: colors.bgColor1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                CustomText(
                                  text: language == 'bn'
                                      ? 'জুমা     '
                                      : 'Juma    ',
                                  additionalStyle: TextStyle(
                                    fontSize: 14,
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.jumaStart);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setJumaStartTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'jumaStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'jumaEnd'});

                                        prayerTimeProvider.setIsJumaEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.jumaStart),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime:
                                                prayerTimeProvider.jumaEnd);
                                    if (selectedTime != null) {
                                      prayerTimeProvider.setJumaEndTime(
                                          time: selectedTime);

                                      try {
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'jumaStart'});
                                        await platform.invokeMethod('stopTask',
                                            {'uniqueId': 'jumaEnd'});

                                        prayerTimeProvider.setIsJumaEnabled(
                                            value: false);
                                      } catch (_) {}
                                    }
                                  },
                                  child: CustomText(
                                    text: formatTimeWithAmPm(
                                        prayerTimeProvider.jumaEnd),
                                    additionalStyle: TextStyle(
                                      fontSize: 14,
                                      color: colors.activeColor1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StyledCheckBox(
                              value: prayerTimeProvider.isJumaEnabled,
                              onChanged: (newValue) async {
                                if (newValue) {
                                  try {
                                    await platform
                                        .invokeMethod('enableJumaDndTask', {
                                      'hour': prayerTimeProvider.jumaStart.hour,
                                      'minute':
                                          prayerTimeProvider.jumaStart.minute,
                                      'uniqueId': 'jumaStart',
                                      'prayer': 'Juma'
                                    });

                                    await platform
                                        .invokeMethod('disableJumaDndTask', {
                                      'hour': prayerTimeProvider.jumaEnd.hour,
                                      'minute':
                                          prayerTimeProvider.jumaEnd.minute,
                                      'uniqueId': 'jumaEnd'
                                    });
                                  } catch (_) {}
                                } else {
                                  try {
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'jumaStart'});
                                    await platform.invokeMethod(
                                        'stopTask', {'uniqueId': 'jumaEnd'});
                                  } catch (_) {}
                                }
                                prayerTimeProvider.setIsJumaEnabled(
                                    value: newValue);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
