import 'package:flutter/material.dart';

import 'country_item.dart';
class CountryGridView extends StatelessWidget {
  const CountryGridView({super.key});

  final List<Map<String, String>> countryData = const [
    {'countryName': 'USA', 'countryImage': 'assets/images/usa.png'},
    {'countryName': 'England', 'countryImage': 'assets/images/england.png'},
    {'countryName': 'Arabic', 'countryImage': 'assets/images/egypt.png'},
    {'countryName': 'France', 'countryImage': 'assets/images/france.png'},
    {'countryName': 'Spain', 'countryImage': 'assets/images/spain.png'},
    {'countryName': 'Germany', 'countryImage': 'assets/images/germany.png'},
    {'countryName': 'Italy', 'countryImage': 'assets/images/italy.png'},
    {'countryName': 'Netherlands', 'countryImage': 'assets/images/netherlands.png'},
    {'countryName': 'Russia', 'countryImage': 'assets/images/russia.png'},
    {'countryName': 'China', 'countryImage': 'assets/images/china.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    int rowCount = (countryData.length / 2).ceil();
    double gridHeight = rowCount * 73 + (rowCount - 1) * 12;

    return SizedBox(
      height: gridHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: countryData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          final country = countryData[index];
          return CountryItem(
            countryName: country['countryName']!,
            countryImage: country['countryImage']!,
            isLight: isLight,
          );
        },
      ),
    );
  }
}