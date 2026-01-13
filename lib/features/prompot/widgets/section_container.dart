import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final bool isLight;

  const SectionContainer({
    super.key,
    required this.child,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isLight ? 0.06 : 0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
