import 'package:flutter/material.dart';
import 'custombuttom.dart';

class TranslateButtonBar extends StatelessWidget {
  final VoidCallback onTap;

  const TranslateButtonBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          height: 56,
          child: CustomButtom(text: 'Translate', ontap: onTap),
        ),
      ),
    );
  }
}
