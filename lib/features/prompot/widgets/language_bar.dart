import 'package:flutter/material.dart';
import 'language_dropdown.dart';

class LanguageBar extends StatelessWidget {
  final bool isLight;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;

  const LanguageBar({
    super.key,
    required this.isLight,
    required this.onFromChanged,
    required this.onToChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isLight ? 0.05 : 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: LanguageDropdown(onLanguageChanged: onFromChanged)),
          const SizedBox(width: 8),
          Icon(Icons.swap_horiz_rounded,
              color: isLight ? Colors.purple.shade700 : Colors.purple.shade200),
          const SizedBox(width: 8),
          Expanded(child: LanguageDropdown(onLanguageChanged: onToChanged)),
        ],
      ),
    );
  }
}
