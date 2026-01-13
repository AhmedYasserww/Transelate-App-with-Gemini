import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key, required this.onLanguageChanged});
  final ValueChanged<String?> onLanguageChanged;

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final List<Map<String, String>> languageData = [
    {'countryLanguage': 'English - US', 'countryImage': 'assets/images/usa.png'},
    {'countryLanguage': 'English - UK', 'countryImage': 'assets/images/usa.png'},
    {'countryLanguage': 'Russian', 'countryImage': 'assets/images/russia.png'},
    {'countryLanguage': 'Italian', 'countryImage': 'assets/images/italy.png'},
    {'countryLanguage': 'German', 'countryImage': 'assets/images/germany.png'},
    {'countryLanguage': 'French', 'countryImage': 'assets/images/france.png'},
    {'countryLanguage': 'Spanish', 'countryImage': 'assets/images/spain.png'},
    {'countryLanguage': 'Arabic', 'countryImage': 'assets/images/egypt.png'},
    {'countryLanguage': 'China', 'countryImage': 'assets/images/china.png'},
  ];

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: isLight ? Colors.white : Colors.grey.shade800,
        border: Border.all(
          color: isLight
              ? Colors.purple.shade700.withOpacity(0.8)
              : Colors.purple.shade200.withOpacity(0.8),
          width: 1.5,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedCountry,
        hint: Text(
          "Select Language",
          style: TextStyle(
            fontSize: 12.0,
            color: isLight ? Colors.black87 : Colors.white70,
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: isLight
              ? Colors.purple.shade700.withOpacity(0.8)
              : Colors.purple.shade200.withOpacity(0.8),
        ),
        underline: Container(color: Colors.transparent),
        dropdownColor: isLight ? Colors.white : Colors.grey.shade900,
        items: languageData.map((country) {
          final bool isSelected = selectedCountry == country['countryLanguage'];
          return DropdownMenuItem<String>(
            value: country['countryLanguage'],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.asset(
                    country['countryImage']!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    country['countryLanguage']!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: isSelected
                          ? (isLight ? Colors.black87 : Colors.white)
                          : (isLight
                          ? Colors.purple.shade700.withOpacity(0.8)
                          : Colors.purple.shade200.withOpacity(0.8)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedCountry = newValue;
          });
          widget.onLanguageChanged(newValue);
        },
      ),
    );
  }
}
