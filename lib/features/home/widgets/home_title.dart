import 'package:flutter/material.dart';
class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(height: 1.6),
        children: <InlineSpan>[
          TextSpan(
            text: 'Translate',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    isLight ? Colors.purple.shade900 : Colors.purple.shade200,
                    isLight ? Colors.purple.shade500 : Colors.purple.shade400,
                  ],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          TextSpan(
            text: ' Every \n',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isLight
                  ? Colors.purple.shade300.withOpacity(0.7)
                  : Colors.white70,
            ),
          ),
          TextSpan(
            text: 'Type Word \n',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isLight ? const Color(0xFF1C1C1C) : Colors.white,
            ),
          ),
          const WidgetSpan(child: SizedBox(height: 20)),
          TextSpan(
            text: 'Translate Multiple Languages \nWith AI',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isLight ? const Color(0xFF4A4A4A) : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}