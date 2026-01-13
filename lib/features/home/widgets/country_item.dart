import 'package:flutter/material.dart';
class CountryItem extends StatelessWidget {
  const CountryItem({
    super.key,
    required this.countryName,
    required this.countryImage,
    required this.isLight,
  });

  final String countryName;
  final String countryImage;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLight
              ? [Colors.white, Colors.grey.shade100]
              : [Colors.grey.shade800, Colors.grey.shade700],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isLight ? 0.05 : 0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.purple.shade200.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            countryImage,
            height: 30,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                countryName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isLight ? Colors.black87 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
