import 'package:flutter/material.dart';
class PromptHeader extends StatelessWidget {
  final bool isLight;
  final VoidCallback onHistoryTap;
  final VoidCallback onStarTap;

  const PromptHeader({
    super.key,
    required this.isLight,
    required this.onHistoryTap,
    required this.onStarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Text Translation",
          style:TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isLight ? Colors.deepPurple.shade900 : Colors.white,
          ),
        ),

        Row(
          children: [
            IconButton(
              icon: Icon(Icons.star_border,
                  color: isLight ? Colors.amber.shade700 : Colors.amber.shade300),
              onPressed: onStarTap,
            ),
            IconButton(
              icon: Icon(Icons.history,
                  color: isLight ? Colors.purple.shade700 : Colors.purple.shade200),
              onPressed: onHistoryTap,
            ),
          ],
        ),
      ],
    );
  }
}
