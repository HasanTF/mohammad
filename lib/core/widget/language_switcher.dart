import 'package:beuty_support/core/constants/themes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beuty_support/features/providers/language_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  final List<Map<String, dynamic>> languages = const [
    {'name': 'English', 'locale': Locale('en'), 'flag': '🇺🇸'},
    {'name': 'العربية', 'locale': Locale('ar'), 'flag': '🇸🇦'},
    {'name': 'Español', 'locale': Locale('es'), 'flag': '🇪🇸'},
  ];

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    Locale currentLocale = languageProvider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<Locale>(
        value: currentLocale,
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(175),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.borderR),
              topRight: Radius.circular(AppBorderRadius.borderR),
              bottomRight: Radius.circular(AppBorderRadius.borderR / 5),
              bottomLeft: Radius.circular(AppBorderRadius.borderR / 5),
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(175),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppBorderRadius.borderR),
              bottomRight: Radius.circular(AppBorderRadius.borderR),
            ),
          ),
          offset: const Offset(0, 0),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            languageProvider.setLocale(newLocale);
          }
        },
        items: languages.map((lang) {
          return DropdownMenuItem<Locale>(
            value: lang['locale'],
            child: Row(
              children: [
                Text(lang['flag'], style: TextStyle(fontSize: Sizes.large)),
                SizedBox(width: Sizes.extraSmall),
                Text(
                  lang['name'],
                  style: TextStyle(fontSize: Sizes.small, color: Colors.white),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
