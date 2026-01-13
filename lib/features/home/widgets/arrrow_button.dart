import 'package:flutter/material.dart';
class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.controller,
    required this.onTap,
  });

  final AnimationController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return GestureDetector(
      onTap: onTap,
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.9)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                (isLight ? const Color(0xFF6D1B7B) : Colors.purple.shade300)
                    .withOpacity(0.8),
                (isLight ? const Color(0xFF6D1B7B) : Colors.purple.shade200)
                    .withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 6),
                blurRadius: 6,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isLight ? Colors.white : Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: isLight ? const Color(0xFF6D1B7B) : Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
