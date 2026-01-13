import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? language;
  final bool isLight;

  const SectionTitle({
    super.key,
    required this.title,
    required this.language,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isLight ? Colors.deepPurple.shade900 : Colors.white,
          ),
        ),
        if (language != null) ...[
          const SizedBox(width: 4),
          Text(
            "• $language",
            style: TextStyle(
              fontSize: 13,
              color: isLight ? Colors.grey.shade600 : Colors.grey.shade300,
            ),
          ),
        ]
      ],
    );
  }
}
